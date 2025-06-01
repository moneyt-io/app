import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/loan_entry.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../features/loans/loan_provider.dart';
import '../design_system/theme/app_dimensions.dart';

class LoanPaymentModal extends StatefulWidget {
  final LoanEntry loan;
  final VoidCallback onPaymentConfirmed;

  const LoanPaymentModal({
    super.key,
    required this.loan,
    required this.onPaymentConfirmed,
  });

  @override
  State<LoanPaymentModal> createState() => _LoanPaymentModalState();
}

class _LoanPaymentModalState extends State<LoanPaymentModal> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  List<Wallet> _wallets = [];
  Wallet? _selectedWallet;
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;
  
  double get _outstandingBalance => widget.loan.amount - widget.loan.totalPaid;
  bool get _isLend => widget.loan.documentTypeId == 'L';

  @override
  void initState() {
    super.initState();
    _loadWallets();
    _amountController.text = _outstandingBalance.toStringAsFixed(2);
  }

  Future<void> _loadWallets() async {
    try {
      final walletUseCases = GetIt.instance<WalletUseCases>();
      final wallets = await walletUseCases.getAllWallets();
      setState(() {
        _wallets = wallets;
        if (_wallets.isNotEmpty) {
          _selectedWallet = _wallets.first;
        }
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar wallets: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: EdgeInsets.only(
        top: AppDimensions.paddingMedium,
        left: AppDimensions.paddingMedium,
        right: AppDimensions.paddingMedium,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppDimensions.paddingMedium,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                _isLend ? Icons.payment : Icons.attach_money,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _isLend ? 'Recibir Pago' : 'Realizar Pago',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          
          const SizedBox(height: AppDimensions.paddingMedium),
          
          // Información del préstamo
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Saldo pendiente:'),
                    Text(
                      '\$${_outstandingBalance.toStringAsFixed(2)}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Contacto:'),
                    Text(widget.loan.contact?.name ?? 'Desconocido'),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppDimensions.paddingMedium),
          
          // Formulario
          Form(
            key: _formKey,
            child: Column(
              children: [
                // Monto
                TextFormField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    labelText: 'Monto del pago',
                    border: OutlineInputBorder(),
                    prefixText: '\$ ',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Debe ingresar un monto';
                    }
                    final amount = double.tryParse(value);
                    if (amount == null || amount <= 0) {
                      return 'Debe ingresar un monto válido';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: AppDimensions.paddingMedium),
                
                // Selector de wallet
                DropdownButtonFormField<Wallet>(
                  decoration: const InputDecoration(
                    labelText: 'Wallet',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedWallet,
                  items: _wallets.map((wallet) {
                    return DropdownMenuItem<Wallet>(
                      value: wallet,
                      child: Text('${wallet.name} (${wallet.currencyId})'),
                    );
                  }).toList(),
                  onChanged: (wallet) {
                    setState(() {
                      _selectedWallet = wallet;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Debe seleccionar un wallet';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: AppDimensions.paddingMedium),
                
                // Fecha
                InkWell(
                  onTap: () => _selectDate(context),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Fecha',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    child: Text(
                      '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    ),
                  ),
                ),
                
                const SizedBox(height: AppDimensions.paddingMedium),
                
                // Descripción
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descripción (opcional)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                
                const SizedBox(height: AppDimensions.paddingLarge),
                
                // Botones
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancelar'),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingMedium),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSubmit,
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Confirmar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedWallet == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debe seleccionar un wallet')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final amount = double.parse(_amountController.text);
      final description = _descriptionController.text.isEmpty 
          ? null 
          : _descriptionController.text;

      final loanProvider = Provider.of<LoanProvider>(context, listen: false);
      
      await loanProvider.createLoanPayment(
        loanId: widget.loan.id,
        paymentAmount: amount,
        date: _selectedDate,
        description: description,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pago registrado exitosamente')),
        );
        widget.onPaymentConfirmed();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
