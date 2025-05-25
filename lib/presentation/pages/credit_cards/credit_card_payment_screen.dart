import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../core/presentation/app_dimensions.dart';
import '../../../domain/entities/credit_card.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/usecases/transaction_usecases.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../../domain/usecases/credit_card_usecases.dart';
import '../../atoms/app_button.dart';

class CreditCardPaymentScreen extends StatefulWidget {
  final CreditCard creditCard;
  
  const CreditCardPaymentScreen({
    super.key,
    required this.creditCard,
  });

  @override
  State<CreditCardPaymentScreen> createState() => _CreditCardPaymentScreenState();
}

class _CreditCardPaymentScreenState extends State<CreditCardPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  final _transactionUseCases = GetIt.instance<TransactionUseCases>();
  final _walletUseCases = GetIt.instance<WalletUseCases>();
  final _creditCardUseCases = GetIt.instance<CreditCardUseCases>();
  
  DateTime _selectedDate = DateTime.now();
  Wallet? _selectedWallet;
  List<Wallet> _wallets = [];
  
  bool _isLoading = false;
  double _usedAmount = 0.0;
  double _availableCredit = 0.0;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Función local para formatear moneda mientras no existe CurrencyFormatter
  String _formatCurrency(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  Future<void> _loadInitialData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final walletsResult = await _walletUseCases.getAllWallets();
      final usedAmount = await _creditCardUseCases.getUsedAmount(widget.creditCard);
      final availableCredit = await _creditCardUseCases.getAvailableCredit(widget.creditCard);
      
      if (mounted) {
        setState(() {
          _wallets = walletsResult;
          _usedAmount = usedAmount;
          _availableCredit = availableCredit;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar datos: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _selectWallet() async {
    if (_wallets.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay billeteras disponibles')),
      );
      return;
    }

    // Mostrar dialog simple para seleccionar wallet
    final selectedWallet = await showDialog<Wallet>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seleccionar billetera origen'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _wallets.map((wallet) {
              return ListTile(
                title: Text(wallet.name),
                subtitle: Text(wallet.currencyId),
                onTap: () => Navigator.of(context).pop(wallet),
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );

    if (selectedWallet != null) {
      setState(() {
        _selectedWallet = selectedWallet;
      });
    }
  }

  Future<void> _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _setQuickAmount(double amount) {
    _amountController.text = amount.toStringAsFixed(2);
  }

  Future<void> _confirmPayment() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedWallet == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor seleccione una billetera origen')),
      );
      return;
    }

    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingrese un monto válido')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _transactionUseCases.createCreditCardPayment(
        date: _selectedDate,
        description: _descriptionController.text.trim().isEmpty 
            ? null 
            : _descriptionController.text.trim(),
        amount: amount,
        currencyId: _selectedWallet!.currencyId,
        sourceWalletId: _selectedWallet!.id,
        targetCreditCardId: widget.creditCard.id,
        targetCurrencyId: widget.creditCard.currencyId,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pago realizado exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true); // Retornar true para indicar éxito
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al realizar el pago: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagar Tarjeta'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator()) 
          : Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(AppDimensions.spacing16),
                children: [
                  // Información de la tarjeta
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(AppDimensions.spacing16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.creditCard.name,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: AppDimensions.spacing8),
                          _buildInfoRow('Cupo total', _formatCurrency(_availableCredit + _usedAmount)),
                          _buildInfoRow('Saldo utilizado', _formatCurrency(_usedAmount)),
                          _buildInfoRow('Disponible', _formatCurrency(_availableCredit)),
                          
                          // Debug info - temporal para verificar valores
                          if (_usedAmount == 0 && _availableCredit == 0) ...[
                            SizedBox(height: AppDimensions.spacing8),
                            Container(
                              padding: EdgeInsets.all(AppDimensions.spacing8),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Debug: No hay transacciones registradas para esta tarjeta',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.orange.shade700,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: AppDimensions.spacing24),

                  // Formulario de pago
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(AppDimensions.spacing16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Detalles del Pago',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: AppDimensions.spacing16),

                          // Selector de billetera origen
                          const Text('Billetera origen'),
                          SizedBox(height: AppDimensions.spacing8),
                          InkWell(
                            onTap: _selectWallet,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(AppDimensions.spacing12),
                              decoration: BoxDecoration(
                                border: Border.all(color: colorScheme.outline),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _selectedWallet?.name ?? 'Seleccionar billetera',
                                      style: TextStyle(
                                        color: _selectedWallet != null 
                                            ? colorScheme.onSurface 
                                            : colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: AppDimensions.spacing16),

                          // Campo de monto usando TextFormField básico
                          TextFormField(
                            controller: _amountController,
                            decoration: const InputDecoration(
                              labelText: 'Monto a pagar',
                              hintText: '0.00',
                              prefixIcon: Icon(Icons.attach_money),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese un monto';
                              }
                              final amount = double.tryParse(value);
                              if (amount == null || amount <= 0) {
                                return 'Por favor ingrese un monto válido';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: AppDimensions.spacing8),

                          // Botones de monto rápido
                          if (_usedAmount > 0) ...[
                            Wrap(
                              spacing: AppDimensions.spacing8,
                              children: [
                                if (_usedAmount * 0.05 > 0) // Pago mínimo (5%)
                                  OutlinedButton(
                                    onPressed: () => _setQuickAmount(_usedAmount * 0.05),
                                    child: Text('Pago mín. ${_formatCurrency(_usedAmount * 0.05)}'),
                                  ),
                                OutlinedButton(
                                  onPressed: () => _setQuickAmount(_usedAmount),
                                  child: Text('Total ${_formatCurrency(_usedAmount)}'),
                                ),
                              ],
                            ),
                            SizedBox(height: AppDimensions.spacing16),
                          ],

                          // Campo de fecha usando TextFormField básico
                          TextFormField(
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'Fecha del pago',
                              prefixIcon: Icon(Icons.calendar_today),
                              border: OutlineInputBorder(),
                            ),
                            controller: TextEditingController(
                              text: '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                            ),
                            onTap: _selectDate,
                          ),

                          SizedBox(height: AppDimensions.spacing16),

                          // Campo de descripción
                          TextFormField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Descripción (opcional)',
                              hintText: 'Ej: Pago mensual tarjeta',
                              prefixIcon: Icon(Icons.description),
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: AppDimensions.spacing24),

                  // Botón de confirmar
                  AppButton(
                    text: 'Confirmar Pago',
                    onPressed: _isLoading ? null : _confirmPayment,
                    type: AppButtonType.primary,
                    isFullWidth: true,
                    isLoading: _isLoading,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.spacing4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
