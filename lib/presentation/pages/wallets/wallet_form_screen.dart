import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/entities/chart_account.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../../domain/usecases/chart_account_usecases.dart';
import '../../atoms/app_button.dart';
import '../../../core/presentation/app_dimensions.dart';
import '../../molecules/error_message_card.dart';
import '../../molecules/form_field_container.dart';
import '../../molecules/form_submit_button.dart';
import '../../routes/navigation_service.dart';

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
  
  bool _isLoading = false;
  bool _isChartAccountsLoading = true;
  String? _error;
  
  ChartAccount? _associatedChartAccount;

  bool get isEditing => widget.wallet != null;
  late final WalletUseCases _walletUseCases;
  late final ChartAccountUseCases _chartAccountUseCases;

  // Lista simulada de divisas (esto debería venir de una API o BD)
  final List<Map<String, String>> _currencies = [
    {'id': 'USD', 'name': 'Dólar estadounidense'},
    {'id': 'EUR', 'name': 'Euro'},
    {'id': 'COP', 'name': 'Peso colombiano'},
    {'id': 'MXN', 'name': 'Peso mexicano'},
  ];

  @override
  void initState() {
    super.initState();
    _walletUseCases = GetIt.instance<WalletUseCases>();
    _chartAccountUseCases = GetIt.instance<ChartAccountUseCases>();
    _initializeFormData();
    
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
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
          
          // Devolver la billetera a la pantalla anterior
          NavigationService.goBack(wallet);
        }
      } else {
        // Creación de nueva wallet con generación automática de cuenta contable
        final wallet = await _walletUseCases.createWalletWithAccount(
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
          
          // Devolver la billetera a la pantalla anterior
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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar billetera' : 'Nueva billetera'),
        centerTitle: true,
        elevation: 0,
      ),
      body: _isChartAccountsLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(AppDimensions.spacing16),
                children: [
                  // Error (si existe)
                  if (_error != null)
                    ErrorMessageCard(
                      message: _error!,
                      onClose: () => setState(() => _error = null),
                    ),
                  
                  // Nombre (requerido)
                  FormFieldContainer(
                    child: TextFormField(
                      controller: _nameController,
                      decoration: FormFieldContainer.getOutlinedDecoration(
                        context,
                        labelText: 'Nombre',
                        prefixIcon: Icon(
                          Icons.text_fields,
                          color: colorScheme.primary,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'El nombre es requerido';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacing16),
                  
                  // Descripción (opcional)
                  FormFieldContainer(
                    isOptional: true,
                    child: TextFormField(
                      controller: _descriptionController,
                      decoration: FormFieldContainer.getOutlinedDecoration(
                        context,
                        labelText: 'Descripción',
                        prefixIcon: Icon(
                          Icons.description_outlined,
                          color: colorScheme.primary,
                        ),
                      ),
                      maxLines: 3,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacing16),
                  
                  // Divisa
                  FormFieldContainer(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCurrency,
                      isExpanded: true,
                      alignment: AlignmentDirectional.centerStart,
                      itemHeight: 60,
                      decoration: FormFieldContainer.getOutlinedDecoration(
                        context,
                        labelText: 'Divisa',
                        prefixIcon: Icon(
                          Icons.currency_exchange,
                          color: colorScheme.primary,
                        ),
                      ),
                      items: _currencies.map((currency) {
                        return DropdownMenuItem(
                          value: currency['id'],
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${currency['id']} - ${currency['name']}',
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedCurrency = value;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacing16),
                          
                  // Mostrar la cuenta contable asociada (solo en modo edición)
                  if (isEditing && _associatedChartAccount != null) ...[
                    FormFieldContainer(
                      child: InputDecorator(
                        decoration: FormFieldContainer.getOutlinedDecoration(
                          context,
                          labelText: 'Cuenta contable asociada',
                          prefixIcon: Icon(
                            Icons.account_tree_outlined,
                            color: colorScheme.primary,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacing8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_associatedChartAccount!.code} - ${_associatedChartAccount!.name}',
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: AppDimensions.spacing4),
                              Text(
                                'La cuenta contable no puede ser modificada',
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                          
                  // En modo creación, mostrar mensaje informativo
                  if (!isEditing) ...[
                    const SizedBox(height: AppDimensions.spacing16),
                    Container(
                      padding: const EdgeInsets.all(AppDimensions.spacing12),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                        border: Border.all(
                          color: colorScheme.outline.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: colorScheme.primary,
                            size: AppDimensions.iconSizeMedium,
                          ),
                          const SizedBox(width: AppDimensions.spacing8),
                          Expanded(
                            child: Text(
                              'Se creará automáticamente una cuenta contable asociada a esta billetera',
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: AppDimensions.spacing16,
          right: AppDimensions.spacing16,
          bottom: MediaQuery.of(context).padding.bottom + AppDimensions.spacing16,
          top: AppDimensions.spacing16,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: AppButton(
          text: 'Guardar',
          onPressed: _saveWallet,
          type: AppButtonType.primary,
          isLoading: _isLoading,
          isFullWidth: true,
        ),
      ),
    );
  }
}
