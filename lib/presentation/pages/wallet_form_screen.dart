import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/usecases/wallet_usecases.dart';
import '../../domain/usecases/chart_account_usecases.dart';
import '../atoms/app_button.dart';
import '../molecules/form_field_container.dart';
import '../routes/navigation_service.dart';

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
  
  String _selectedCurrency = 'USD'; // Moneda por defecto
  bool _isLoading = false;
  String? _error;
  
  late final WalletUseCases _walletUseCases;
  late final ChartAccountUseCases _chartAccountUseCases;
  
  bool get isEditing => widget.wallet != null;

  @override
  void initState() {
    super.initState();
    _walletUseCases = GetIt.instance<WalletUseCases>();
    _chartAccountUseCases = GetIt.instance<ChartAccountUseCases>();
    
    if (isEditing) {
      _nameController.text = widget.wallet!.name;
      _descriptionController.text = widget.wallet!.description ?? '';
      _selectedCurrency = widget.wallet!.currencyId;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  
  Future<void> _saveWallet() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final now = DateTime.now();
      
      // Si es una nueva billetera, generar su cuenta contable
      int chartAccountId = 0;
      if (!isEditing) {
        final chartAccount = await _chartAccountUseCases.generateAccountForWallet(
          _nameController.text.trim()
        );
        chartAccountId = chartAccount.id;
      }
      
      final wallet = Wallet(
        id: isEditing ? widget.wallet!.id : 0,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty 
                    ? null 
                    : _descriptionController.text.trim(),
        currencyId: _selectedCurrency,
        chartAccountId: isEditing ? widget.wallet!.chartAccountId : chartAccountId,
        active: true,
        createdAt: isEditing ? widget.wallet!.createdAt : now,
        updatedAt: now,
        deletedAt: null,
      );

      Wallet savedWallet;
      if (isEditing) {
        await _walletUseCases.updateWallet(wallet);
        savedWallet = wallet;
      } else {
        savedWallet = await _walletUseCases.createWallet(wallet);
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isEditing ? 'Billetera actualizada con éxito' : 'Billetera creada con éxito'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
        
        NavigationService.goBack(savedWallet);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
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
        title: Text(isEditing ? 'Editar Billetera' : 'Nueva Billetera'), // Cambiamos título
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Error (si existe)
            if (_error != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: colorScheme.error,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _error!,
                        style: TextStyle(
                          color: colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: colorScheme.onErrorContainer,
                      ),
                      onPressed: () => setState(() => _error = null),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // Tarjeta principal
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: colorScheme.outline.withOpacity(0.3),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Información de la billetera', // Cambiamos texto
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Nombre de billetera
                    FormFieldContainer(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre de billetera', // Cambiamos label
                          prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Ingrese un nombre para la billetera'; // Cambiamos mensaje
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Moneda
                    FormFieldContainer(
                      child: DropdownButtonFormField<String>(
                        value: _selectedCurrency,
                        decoration: const InputDecoration(
                          labelText: 'Moneda',
                          prefixIcon: Icon(Icons.currency_exchange),
                          border: InputBorder.none,
                        ),
                        items: [
                          const DropdownMenuItem(
                            value: 'USD',
                            child: Text('Dólar (USD)'),
                          ),
                          const DropdownMenuItem(
                            value: 'EUR',
                            child: Text('Euro (EUR)'),
                          ),
                          // Agregar más monedas según sea necesario
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedCurrency = value;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Descripción (opcional)
                    FormFieldContainer(
                      child: TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Descripción (opcional)',
                          prefixIcon: Icon(Icons.description_outlined),
                          border: InputBorder.none,
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).padding.bottom + 16,
          top: 16,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, -1),
              blurRadius: 4,
            ),
          ],
        ),
        child: AppButton(
          text: 'Guardar',
          onPressed: _isLoading ? null : _saveWallet,
          isLoading: _isLoading,
          type: AppButtonType.primary,
          isFullWidth: true,
        ),
      ),
    );
  }
}
