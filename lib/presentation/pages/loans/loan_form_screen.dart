import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/loan_entry.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/entities/credit_card.dart';
import '../../../domain/usecases/contact_usecases.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../../domain/usecases/credit_card_usecases.dart';
import '../../providers/loan_provider.dart';
import '../../molecules/payment_method_selector.dart';
import '../../routes/navigation_service.dart';
import '../../../core/presentation/app_dimensions.dart';

class LoanFormScreen extends StatefulWidget {
  final LoanEntry? loan;

  const LoanFormScreen({
    super.key,
    this.loan,
  });

  @override
  State<LoanFormScreen> createState() => _LoanFormScreenState();
}

class _LoanFormScreenState extends State<LoanFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _documentType = 'L'; // L = Lend, B = Borrow
  Contact? _selectedContact;
  String? _selectedPaymentType;
  int? _selectedPaymentId;
  DateTime _selectedDate = DateTime.now();
  String _selectedCurrency = 'USD';

  List<Contact> _contacts = [];
  List<Wallet> _wallets = [];
  List<CreditCard> _creditCards = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _initializeForm();
  }

  void _initializeForm() {
    if (widget.loan != null) {
      final loan = widget.loan!;
      _documentType = loan.documentTypeId;
      _amountController.text = loan.amount.toString();
      _descriptionController.text = loan.description ?? '';
      _selectedDate = loan.date;
      _selectedCurrency = loan.currencyId;
    }
  }

  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);
    
    try {
      final contactUseCases = GetIt.instance<ContactUseCases>();
      final walletUseCases = GetIt.instance<WalletUseCases>();
      final creditCardUseCases = GetIt.instance<CreditCardUseCases>();

      final results = await Future.wait([
        contactUseCases.getAllContacts(),
        walletUseCases.getAllWallets(),
        creditCardUseCases.getAllCreditCards(),
      ]);

      setState(() {
        _contacts = results[0] as List<Contact>;
        _wallets = results[1] as List<Wallet>;
        _creditCards = results[2] as List<CreditCard>;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar datos: ${e.toString()}')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = widget.loan != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Préstamo' : 'Nuevo Préstamo'),
        actions: [
          if (!_isLoading)
            TextButton(
              onPressed: _handleSubmit,
              child: Text(
                isEditing ? 'Actualizar' : 'Crear',
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                children: [
                  // Tipo de préstamo
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tipo de Préstamo',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.paddingMedium),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  title: const Text('Prestar Dinero'),
                                  subtitle: const Text('Dinero que doy'),
                                  value: 'L',
                                  groupValue: _documentType,
                                  onChanged: isEditing ? null : (value) {
                                    setState(() {
                                      _documentType = value!;
                                      _selectedPaymentType = null;
                                      _selectedPaymentId = null;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  title: const Text('Pedir Prestado'),
                                  subtitle: const Text('Dinero que recibo'),
                                  value: 'B',
                                  groupValue: _documentType,
                                  onChanged: isEditing ? null : (value) {
                                    setState(() {
                                      _documentType = value!;
                                      _selectedPaymentType = null;
                                      _selectedPaymentId = null;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: AppDimensions.paddingMedium),

                  // Selector de contacto
                  DropdownButtonFormField<Contact>(
                    decoration: const InputDecoration(
                      labelText: 'Contacto',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedContact,
                    items: _contacts.map((contact) {
                      return DropdownMenuItem<Contact>(
                        value: contact,
                        child: Text(contact.name),
                      );
                    }).toList(),
                    onChanged: (contact) {
                      setState(() {
                        _selectedContact = contact;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Debe seleccionar un contacto';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: AppDimensions.paddingMedium),

                  // Monto
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      labelText: 'Monto',
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

                  // Método de pago
                  PaymentMethodSelector(
                    wallets: _wallets,
                    creditCards: _creditCards,
                    selectedPaymentType: _selectedPaymentType,
                    selectedPaymentId: _selectedPaymentId,
                    isLendingOperation: _documentType == 'L',
                    onPaymentMethodChanged: (type, id) {
                      setState(() {
                        _selectedPaymentType = type;
                        _selectedPaymentId = id;
                      });
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
                    maxLines: 3,
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
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

    if (_selectedContact == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debe seleccionar un contacto')),
      );
      return;
    }

    // Validar método de pago para operaciones con transferencia
    if (_selectedPaymentType != null && _selectedPaymentId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debe seleccionar un método de pago específico')),
      );
      return;
    }

    final amount = double.parse(_amountController.text);
    final description = _descriptionController.text.isEmpty 
        ? null 
        : _descriptionController.text;

    try {
      final loanProvider = Provider.of<LoanProvider>(context, listen: false);
      
      final loan = await loanProvider.createLoanWithPaymentMethod(
        documentTypeId: _documentType,
        contactId: _selectedContact!.id,
        amount: amount,
        currencyId: _selectedCurrency,
        date: _selectedDate,
        paymentType: _selectedPaymentType ?? 'T',
        paymentId: _selectedPaymentId,
        description: description,
      );

      if (loan != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Préstamo creado exitosamente')),
        );
        NavigationService.goBack();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
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
