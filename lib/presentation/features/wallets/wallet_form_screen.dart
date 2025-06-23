import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/entities/chart_account.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../../domain/usecases/chart_account_usecases.dart';
import '../../core/atoms/app_app_bar.dart'; // ✅ REFACTORIZADO: Usar AppAppBar atomizado
import '../../core/atoms/app_floating_label_field.dart'; // ✅ REUTILIZADO: Para name y description
import '../../core/atoms/currency_selector_button.dart'; // ✅ NUEVO: Para currency selection
import '../../core/atoms/parent_wallet_selector_button.dart'; // ✅ NUEVO: Para parent wallet
import '../../core/molecules/form_action_bar.dart'; // ✅ REUTILIZADO: Footer buttons
import '../../core/molecules/error_message_card.dart';
import '../../core/molecules/currency_selection_dialog.dart'; // ✅ AGREGADO: Import del diálogo de currency
import '../../core/molecules/parent_wallet_selection_dialog.dart'; // ✅ AGREGADO: Import del diálogo de parent wallet
import '../../navigation/navigation_service.dart';

class WalletFormScreen extends StatefulWidget {
  final Wallet? wallet;

  const WalletFormScreen({Key? key, this.wallet}) : super(key: key);

  @override
  State<WalletFormScreen> createState() => _WalletFormScreenState();
}

class _WalletFormScreenState extends State<WalletFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedCurrency = 'USD';
  int? _selectedParentId;
  String? _selectedParentName; // ✅ NUEVO: Para mostrar nombre del parent
  List<Wallet> _parentWallets = [];

  bool _isLoading = false;
  bool _isChartAccountsLoading = true;
  bool _isParentWalletsLoading = true;
  String? _error;

  ChartAccount? _associatedChartAccount;

  bool get isEditing => widget.wallet != null;
  late final WalletUseCases _walletUseCases;
  late final ChartAccountUseCases _chartAccountUseCases;

  // ✅ REFACTORIZADO: Lista de currencies mejorada con nombres completos
  final List<Map<String, String>> _currencies = [
    {'id': 'USD', 'name': 'US Dollar', 'symbol': '\$'},
    {'id': 'EUR', 'name': 'Euro', 'symbol': '€'},
    {'id': 'COP', 'name': 'Colombian Peso', 'symbol': '\$'},
    {'id': 'MXN', 'name': 'Mexican Peso', 'symbol': '\$'},
  ];

  @override
  void initState() {
    super.initState();
    _walletUseCases = GetIt.instance<WalletUseCases>();
    _chartAccountUseCases = GetIt.instance<ChartAccountUseCases>();
    _initializeFormData();
    _loadParentWallets();

    if (isEditing) {
      _loadAssociatedChartAccount();
    } else {
      setState(() {
        _isChartAccountsLoading = false;
      });
    }
  }

  Future<void> _loadAssociatedChartAccount() async {
    try {
      setState(() {
        _isChartAccountsLoading = true;
      });

      if (isEditing && widget.wallet!.chartAccountId > 0) {
        final chartAccount = await _chartAccountUseCases.getChartAccountById(widget.wallet!.chartAccountId);
        
        setState(() {
          _associatedChartAccount = chartAccount;
          _isChartAccountsLoading = false;
        });
      } else {
        setState(() {
          _isChartAccountsLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error al cargar cuenta contable: $e';
        _isChartAccountsLoading = false;
      });
    }
  }

  void _initializeFormData() {
    if (isEditing) {
      final wallet = widget.wallet!;
      _nameController.text = wallet.name;
      _descriptionController.text = wallet.description ?? '';
      _selectedCurrency = wallet.currencyId;
      _selectedParentId = wallet.parentId;
    }
  }

  Future<void> _loadParentWallets() async {
    try {
      setState(() {
        _isParentWalletsLoading = true;
      });
      final allWallets = await _walletUseCases.getAllWallets();
      final potentialParents = allWallets
          .where((w) => !isEditing || w.id != widget.wallet!.id)
          .where((w) => w.parentId == null) // Solo wallets padre
          .toList();

      if (mounted) {
        setState(() {
          _parentWallets = potentialParents;
          
          // ✅ NUEVO: Buscar nombre del parent seleccionado
          if (_selectedParentId != null) {
            final parentWallet = potentialParents.firstWhere(
              (w) => w.id == _selectedParentId,
              orElse: () => potentialParents.first,
            );
            _selectedParentName = parentWallet.name;
          }
          
          _isParentWalletsLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Error al cargar billeteras padre: $e';
          _isParentWalletsLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // ✅ ACTUALIZADO: Método para mostrar currency selector
  void _showCurrencySelector() async {
    final result = await CurrencySelectionDialog.show(
      context: context,
      selectedCurrency: _selectedCurrency,
    );

    if (result != null) {
      setState(() {
        _selectedCurrency = result.id;
      });
    }
  }

  // ✅ ACTUALIZADO: Método para mostrar parent wallet selector
  void _showParentWalletSelector() async {
    if (_parentWallets.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay billeteras disponibles como padre'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final result = await ParentWalletSelectionDialog.show(
      context: context,
      availableWallets: _parentWallets,
      selectedWalletId: _selectedParentId,
    );

    if (result != null) {
      setState(() {
        _selectedParentId = result.id;
        _selectedParentName = result.name;
      });
    } else {
      // Si se retorna null explícitamente, significa "No parent"
      setState(() {
        _selectedParentId = null;
        _selectedParentName = null;
      });
    }
  }

  Future<void> _saveWallet() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final now = DateTime.now();
      
      if (isEditing) {
        // Actualización de wallet existente
        final wallet = Wallet(
          id: widget.wallet!.id,
          parentId: _selectedParentId,
          currencyId: _selectedCurrency,
          chartAccountId: widget.wallet!.chartAccountId, // Mantener la cuenta existente
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
          active: true,
          createdAt: widget.wallet!.createdAt,
          updatedAt: now,
          deletedAt: null,
        );

        await _walletUseCases.updateWallet(wallet);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Billetera actualizada con éxito'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
          
          NavigationService.goBack(wallet);
        }
      } else {
        // ✅ SIMPLIFICADO: Creación de nueva wallet sin initial balance
        final wallet = await _walletUseCases.createWalletWithAccount(
          parentId: _selectedParentId,
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
          currencyId: _selectedCurrency,
        );
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Billetera creada con éxito'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
          
          NavigationService.goBack(wallet);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // ✅ NUEVO: Obtener nombre de currency seleccionada
    final selectedCurrencyData = _currencies.firstWhere(
      (currency) => currency['id'] == _selectedCurrency,
      orElse: () => _currencies.first,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // HTML: bg-slate-50
      
      // ✅ REFACTORIZADO: Usar AppAppBar atomizado exacto del HTML
      appBar: AppAppBar(
        title: isEditing ? 'Edit wallet' : 'New wallet', // HTML: exacto del wallet_form.html
        type: AppAppBarType.blur, // HTML: bg-slate-50/80 backdrop-blur-md
        leading: AppAppBarLeading.close, // HTML: close button exacto
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      
      body: _isChartAccountsLoading || _isParentWalletsLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // ✅ REFACTORIZADO: Form content como main del HTML
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16), // HTML: px-4 py-4
                      child: Column(
                        children: [
                          // Error (si existe)
                          if (_error != null)
                            ErrorMessageCard(
                              message: _error!,
                              onClose: () => setState(() => _error = null),
                            ),
                          
                          // ✅ REFACTORIZADO: Wallet name con floating label exacto del HTML
                          AppFloatingLabelField(
                            controller: _nameController,
                            label: 'Wallet name', // HTML: exacto
                            placeholder: 'Enter wallet name', // HTML: exacto
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'El nombre es requerido';
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.words,
                          ),
                          
                          const SizedBox(height: 24), // HTML: space-y-6
                          
                          // ✅ REFACTORIZADO: Description con floating label exacto del HTML
                          AppFloatingLabelField(
                            controller: _descriptionController,
                            label: 'Description', // HTML: exacto
                            placeholder: 'Optional description for this wallet', // HTML: exacto
                            maxLines: 3, // HTML: textarea con rows="3"
                            textInputAction: TextInputAction.newline,
                          ),
                          
                          const SizedBox(height: 24), // HTML: space-y-6
                          
                          // ✅ NUEVO: Currency selector exacto del HTML
                          CurrencySelectorButton(
                            label: 'Currency', // HTML: exacto
                            selectedCurrency: _selectedCurrency,
                            selectedCurrencyName: selectedCurrencyData['name']!,
                            onPressed: _showCurrencySelector,
                          ),
                          
                          const SizedBox(height: 24), // HTML: space-y-6
                          
                          // ✅ NUEVO: Parent wallet selector exacto del HTML
                          ParentWalletSelectorButton(
                            label: 'Parent wallet (optional)', // HTML: exacto
                            selectedWalletName: _selectedParentName,
                            onPressed: _showParentWalletSelector,
                          ),
                          
                          // Mostrar la cuenta contable asociada (solo en modo edición)
                          if (isEditing && _associatedChartAccount != null) ...[
                            const SizedBox(height: 24),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFFCBD5E1)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cuenta contable asociada',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${_associatedChartAccount!.code} - ${_associatedChartAccount!.name}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'La cuenta contable no puede ser modificada',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF64748B),
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                
                // ✅ REFACTORIZADO: Footer exacto del HTML con FormActionBar
                FormActionBar(
                  onCancel: () => Navigator.of(context).pop(),
                  onSave: _saveWallet,
                  isLoading: _isLoading,
                  enabled: !_isLoading,
                ),
              ],
            ),
    );
  }
}