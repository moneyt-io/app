import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../features/wallets/wallet_provider.dart';
import '../../core/providers/currency_provider.dart';
import '../../../core/utils/number_formatter.dart';
import '../../core/l10n/generated/strings.g.dart';
import '../theme/v2_colors.dart';

class V2WalletsScreen extends StatefulWidget {
  const V2WalletsScreen({super.key});

  @override
  State<V2WalletsScreen> createState() => _V2WalletsScreenState();
}

class _V2WalletsScreenState extends State<V2WalletsScreen> {
  late final WalletUseCases _walletUseCases;

  @override
  void initState() {
    super.initState();
    _walletUseCases = GetIt.instance<WalletUseCases>();
    // Cargar data si es necesario
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WalletProvider>().loadInitialData();
    });
  }

  Future<void> _deleteWallet(Wallet wallet) async {
    final provider = context.read<WalletProvider>();
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(t.v2.settings.deleteWallet, style: const TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
        content: Text(t.v2.settings.deleteWalletWarning, style: const TextStyle(fontFamily: 'Manrope', color: V2Colors.onSurfaceVariant)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t.v2.settings.cancel, style: const TextStyle(color: V2Colors.onSurfaceVariant, fontFamily: 'Manrope', fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(t.v2.settings.delete, style: const TextStyle(color: V2Colors.error, fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await provider.deleteWallet(wallet.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(t.v2.settings.walletDeleted)),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(t.v2.settings.deleteError(error: e.toString()))),
          );
        }
      }
    }
  }

  void _showAddOrEditWalletDialog(String currencyId, {Wallet? walletToEdit}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _WalletFormBottomSheet(
        walletToEdit: walletToEdit,
        currencyId: currencyId,
        onSave: (name) async {
          final provider = context.read<WalletProvider>();
          
            if (walletToEdit != null) {
              // Editar
              final updatedWallet = walletToEdit.copyWith(
                name: name,
                updatedAt: DateTime.now(),
              );
              await provider.updateWallet(updatedWallet);
            } else {
              // Crear
              Wallet? root = provider.wallets.where((w) => w.parentId == null && w.currencyId == currencyId && w.name == 'Base').firstOrNull;
              
              if (root == null) {
                final newRoot = Wallet(
                  id: 0,
                  name: 'Base',
                  currencyId: currencyId,
                  chartAccountId: 0,
                  active: true,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );
                await _walletUseCases.createWallet(newRoot);
                await provider.loadInitialData();
                root = provider.wallets.where((w) => w.parentId == null && w.currencyId == currencyId && w.name == 'Base').firstOrNull;
              }
              
              if (root != null) {
                final newWallet = Wallet(
                  id: 0,
                  name: name,
                  currencyId: currencyId,
                  parentId: root.id,
                  chartAccountId: 0,
                  active: true,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );
                await _walletUseCases.createWallet(newWallet);
                provider.loadInitialData();
              }
            }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: V2Colors.background,
        appBar: AppBar(
          backgroundColor: V2Colors.background,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: V2Colors.onSurface),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            t.v2.settings.wallets,
            style: const TextStyle(
              color: V2Colors.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'Manrope',
            ),
          ),
          centerTitle: true,
        ),
        body: Consumer2<WalletProvider, CurrencyProvider>(
          builder: (context, walletProvider, currencyProvider, child) {
            if (walletProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // Listar todas las billeteras que sean hijos (tengan parentId), sin importar su divisa
            final walletsToDisplay = walletProvider.wallets.where((w) => w.parentId != null).toList();

            return Column(
              children: [
                Expanded(
                  child: walletsToDisplay.isEmpty
                    ? Center(
                        child: Text(t.v2.settings.noWalletsCreated, 
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: V2Colors.outlineVariant, fontFamily: 'Manrope')
                        )
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        itemCount: walletsToDisplay.length,
                        itemBuilder: (context, index) {
                          final wallet = walletsToDisplay[index];
                          
                          // Saldo real de cada billetera
                          final balance = walletProvider.walletBalances[wallet.id] ?? 0.0;
                          
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: V2Colors.surfaceContainerLowest,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ListTile(
                              onTap: () => _showAddOrEditWalletDialog(wallet.currencyId, walletToEdit: wallet),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              leading: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: V2Colors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                child: const Icon(Icons.account_balance_wallet, color: V2Colors.primary),
                              ),
                              title: Text(
                                wallet.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: V2Colors.onSurface,
                                  fontFamily: 'Manrope',
                                ),
                              ),
                              subtitle: Text(
                                NumberFormatter.formatCurrency(balance, currencyId: wallet.currencyId),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: V2Colors.onSurfaceVariant,
                                  fontFamily: 'Manrope',
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline, color: V2Colors.error),
                                onPressed: () => _deleteWallet(wallet),
                              ),
                            ),
                          );
                        },
                      ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: Consumer<CurrencyProvider>(
          builder: (context, currencyProvider, child) {
            return FloatingActionButton(
              backgroundColor: V2Colors.primary,
              onPressed: () => _showAddOrEditWalletDialog(currencyProvider.currencyId),
              child: const Icon(Icons.add, color: Colors.white),
            );
          }
        ),
      ),
    );
  }
}

class _WalletFormBottomSheet extends StatefulWidget {
  final Wallet? walletToEdit;
  final String currencyId;
  final Function(String name) onSave;

  const _WalletFormBottomSheet({
    this.walletToEdit,
    required this.currencyId,
    required this.onSave,
  });

  @override
  State<_WalletFormBottomSheet> createState() => _WalletFormBottomSheetState();
}

class _WalletFormBottomSheetState extends State<_WalletFormBottomSheet> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.walletToEdit?.name ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: bottomInset > 0 ? bottomInset + 24 : 48,
      ),
      decoration: const BoxDecoration(
        color: V2Colors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          Center(
            child: Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: V2Colors.outlineVariant.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          Text(
            widget.walletToEdit == null ? t.v2.settings.newWallet : t.v2.settings.editWallet,
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: V2Colors.onSurface,
            ),
          ),
          const SizedBox(height: 32),
          
          // Name Input
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: t.v2.settings.walletName,
              labelStyle: const TextStyle(
                fontFamily: 'Manrope',
                color: V2Colors.outline,
              ),
              floatingLabelStyle: const TextStyle(
                fontFamily: 'Manrope',
                color: V2Colors.primary,
                fontWeight: FontWeight.w700,
              ),
              filled: true,
              fillColor: V2Colors.surfaceContainerLowest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: V2Colors.primary, width: 2),
              ),
            ),
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: V2Colors.onSurface,
            ),
            autofocus: widget.walletToEdit == null,
            textCapitalization: TextCapitalization.words,
          ),
          
          const SizedBox(height: 32),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    t.v2.settings.wallets,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: V2Colors.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    final name = _nameController.text.trim();
                    if (name.isEmpty) return;
                    Navigator.pop(context);
                    widget.onSave(name);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: V2Colors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: Text(
                    t.v2.settings.saveWallet,
                    style: const TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
