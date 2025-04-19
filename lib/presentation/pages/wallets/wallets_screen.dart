import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/entities/chart_account.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../../domain/usecases/chart_account_usecases.dart';
import '../../atoms/app_button.dart';
import '../../../core/presentation/app_dimensions.dart';
import '../../molecules/empty_state.dart';
import '../../molecules/search_field.dart';
import '../../molecules/wallet_list_item.dart';
import '../../molecules/confirm_delete_dialog.dart';
import '../../organisms/app_drawer.dart';
import '../../routes/navigation_service.dart';
import '../../routes/app_routes.dart';
import '../../molecules/confirmation_dialog.dart';
import '../../organisms/wallet_list_view.dart';  // Agregar esta importación

class WalletsScreen extends StatefulWidget {
  const WalletsScreen({Key? key}) : super(key: key);

  @override
  State<WalletsScreen> createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  final WalletUseCases _walletUseCases = GetIt.instance<WalletUseCases>();
  final ChartAccountUseCases _chartAccountUseCases = GetIt.instance<ChartAccountUseCases>();
  final TextEditingController _searchController = TextEditingController();

  List<Wallet> _wallets = [];
  Map<int, ChartAccount> _chartAccountsMap = {};
  String _searchQuery = '';
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadWallets();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadWallets() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _error = null;
      });
    }

    try {
      // Cargar la lista de wallets
      final wallets = await _walletUseCases.getAllWallets();
      
      // Obtener cuentas contables para mostrar información adicional
      final chartAccountIds = wallets.map((w) => w.chartAccountId).toSet();
      final chartAccounts = await _chartAccountUseCases.getAllChartAccounts();
      
      final chartAccountsMap = <int, ChartAccount>{};
      for (final account in chartAccounts) {
        if (chartAccountIds.contains(account.id)) {
          chartAccountsMap[account.id] = account;
        }
      }
      
      if (mounted) {
        setState(() {
          _wallets = wallets;
          _chartAccountsMap = chartAccountsMap;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  void _navigateToWalletForm({Wallet? wallet}) async {
    final result = await NavigationService.navigateTo(
      AppRoutes.walletForm,
      arguments: wallet,
    );

    if (result != null) {
      _loadWallets();
    }
  }

  Future<void> _deleteWallet(Wallet wallet) async {
    // Usar ConfirmDeleteDialog exactamente como en CategoriesScreen
    final confirmed = await ConfirmDeleteDialog.show(
      context: context,
      title: 'Eliminar billetera',
      message: '¿Estás seguro de eliminar',
      itemName: wallet.name,
      // Opciones personalizadas
      icon: Icons.account_balance_wallet_outlined,
      confirmText: 'Confirmar eliminación',
    );

    if (confirmed == true) {
      try {
        await _walletUseCases.deleteWallet(wallet.id);
        _loadWallets();
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Billetera eliminada con éxito'),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al eliminar: $e'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    // Filtrar wallets basado en el término de búsqueda
    final filteredWallets = _wallets.where((wallet) => 
      wallet.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      (wallet.description?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)
    ).toList();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billeteras'),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(AppDimensions.spacing16),
            child: SearchField(
              controller: _searchController,
              hintText: 'Buscar billeteras',
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          
          // Cuerpo principal
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? _buildErrorState()
                    : RefreshIndicator(
                        onRefresh: _loadWallets,
                        child: filteredWallets.isEmpty
                            ? _buildEmptyState()
                            : WalletListView(
                                wallets: filteredWallets,
                                chartAccountsMap: _chartAccountsMap,
                                onWalletTap: (wallet) => _navigateToWalletForm(wallet: wallet),
                                onWalletDelete: _deleteWallet,
                                // Aquí podrías pasar balances reales cuando se implementen
                              ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToWalletForm(),
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        tooltip: 'Crear billetera',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildWalletsList(List<Wallet> wallets) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.spacing16),
      itemCount: wallets.length,
      itemBuilder: (context, index) {
        final wallet = wallets[index];
        final chartAccount = _chartAccountsMap[wallet.chartAccountId];
        
        return WalletListItem(
          wallet: wallet,
          chartAccount: chartAccount,
          balance: 0.0, // Placeholder para el balance, se implementará después
          onTap: () => _navigateToWalletForm(wallet: wallet),
          onDelete: () => _deleteWallet(wallet),
          onEdit: () => _navigateToWalletForm(wallet: wallet),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      children: [
        EmptyState(
          icon: Icons.account_balance_wallet_outlined,
          title: _searchQuery.isEmpty 
              ? 'No hay billeteras' 
              : 'No hay resultados',
          message: _searchQuery.isEmpty 
              ? 'Añade tu primera billetera para comenzar a gestionar tus finanzas' 
              : 'No se encontraron billeteras que coincidan con "$_searchQuery"',
          action: _searchQuery.isNotEmpty ? AppButton(
            text: 'Limpiar búsqueda',
            onPressed: () {
              _searchController.clear();
              setState(() {
                _searchQuery = '';
              });
            },
            type: AppButtonType.text,
          ) : AppButton(
            text: 'Crear billetera',
            onPressed: () => _navigateToWalletForm(),
            type: AppButtonType.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: AppDimensions.spacing48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: AppDimensions.spacing16),
            const Text(
              'Error al cargar las billeteras',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppDimensions.spacing8),
            Text(_error ?? 'Error desconocido'),
            const SizedBox(height: AppDimensions.spacing16),
            AppButton(
              text: 'Reintentar',
              onPressed: _loadWallets,
              type: AppButtonType.primary,
            ),
          ],
        ),
      ),
    );
  }
}
