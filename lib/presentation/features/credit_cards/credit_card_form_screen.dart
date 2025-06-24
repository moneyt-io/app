import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/credit_card.dart';
import '../../../domain/entities/chart_account.dart';
import '../../../domain/usecases/credit_card_usecases.dart';
import '../../../domain/usecases/chart_account_usecases.dart';
import '../../core/atoms/app_floating_label_field.dart';
import '../../core/atoms/card_color_button.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/atoms/currency_selector_button.dart'; // ✅ CAMBIADO: Usar el original
import '../../core/molecules/card_color_palette.dart';
import '../../core/molecules/payment_dates_row.dart';
import '../../core/molecules/sticky_form_footer.dart';
import '../../core/molecules/error_message_card.dart';
import '../../core/molecules/currency_selection_dialog.dart'; // ✅ AGREGADO: Para funcionalidad completa
import '../../navigation/navigation_service.dart';

class CreditCardFormScreen extends StatefulWidget {
  final CreditCard? creditCard;

  const CreditCardFormScreen({Key? key, this.creditCard}) : super(key: key);

  @override
  State<CreditCardFormScreen> createState() => _CreditCardFormScreenState();
}

class _CreditCardFormScreenState extends State<CreditCardFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quotaController = TextEditingController();
  final _interestRateController = TextEditingController();
  
  String _selectedCurrency = 'USD';
  int _cutoffDay = 15; // ✅ AGREGADO: Día de corte
  int _paymentDay = 10; // ✅ AGREGADO: Día de pago
  CardColorType _selectedColor = CardColorType.blue; // ✅ AGREGADO: Color de tarjeta
  bool _isLoading = false;
  bool _isChartAccountLoading = false;
  String? _error;
  ChartAccount? _associatedChartAccount;

  bool get isEditing => widget.creditCard != null;
  late final CreditCardUseCases _creditCardUseCases;
  late final ChartAccountUseCases _chartAccountUseCases;

  final List<Map<String, String>> _currencies = [
    {'id': 'USD', 'name': 'US Dollar'},
    {'id': 'EUR', 'name': 'Euro'},
    {'id': 'COP', 'name': 'Colombian Peso'},
    {'id': 'MXN', 'name': 'Mexican Peso'},
  ];

  @override
  void initState() {
    super.initState();
    _creditCardUseCases = GetIt.instance<CreditCardUseCases>();
    _chartAccountUseCases = GetIt.instance<ChartAccountUseCases>();
    _initializeFormData();
    
    if (isEditing) {
      _loadAssociatedChartAccount();
    } else {
      setState(() {
        _isChartAccountLoading = false;
      });
    }
  }

  Future<void> _loadAssociatedChartAccount() async {
    try {
      setState(() {
        _isChartAccountLoading = true;
      });

      if (isEditing && widget.creditCard!.chartAccountId > 0) {
        final chartAccount = await _chartAccountUseCases.getChartAccountById(widget.creditCard!.chartAccountId);
        
        setState(() {
          _associatedChartAccount = chartAccount;
          _isChartAccountLoading = false;
        });
      } else {
        setState(() {
          _isChartAccountLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error al cargar cuenta contable: $e';
        _isChartAccountLoading = false;
      });
    }
  }

  void _initializeFormData() {
    if (isEditing) {
      final creditCard = widget.creditCard!;
      _nameController.text = creditCard.name;
      _descriptionController.text = creditCard.description ?? '';
      _quotaController.text = creditCard.quota.toString();
      _cutoffDay = creditCard.closingDay; // ✅ CORREGIDO: Usar nombres correctos
      _paymentDay = creditCard.paymentDueDay;
      _interestRateController.text = creditCard.interestRate.toString();
      _selectedCurrency = creditCard.currencyId;
      // ✅ AGREGADO: Cargar color de tarjeta (temporal hasta que esté en entidad)
      _selectedColor = CardColorType.blue; // Default
    } else {
      _cutoffDay = 15; // ✅ CORREGIDO: Valores por defecto del HTML
      _paymentDay = 10;
      _interestRateController.text = '0.0';
    }
  }

  String get _selectedCurrencyName {
    final currency = _currencies.firstWhere(
      (c) => c['id'] == _selectedCurrency,
      orElse: () => {'id': 'USD', 'name': 'US Dollar'},
    );
    return currency['name']!;
  }

  Future<void> _saveCreditCard() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      try {
        final name = _nameController.text.trim();
        final description = _descriptionController.text.trim().isNotEmpty 
            ? _descriptionController.text.trim() 
            : null;
        final quota = double.parse(_quotaController.text);
        final interestRate = double.tryParse(_interestRateController.text) ?? 0.0;

        if (isEditing) {
          await _creditCardUseCases.updateCreditCard(CreditCard(
            id: widget.creditCard!.id,
            name: name,
            description: description,
            currencyId: _selectedCurrency,
            chartAccountId: widget.creditCard!.chartAccountId,
            quota: quota,
            closingDay: _cutoffDay, // ✅ CORREGIDO: Usar variables correctas
            paymentDueDay: _paymentDay,
            interestRate: interestRate,
            active: widget.creditCard!.active,
            createdAt: widget.creditCard!.createdAt,
            updatedAt: DateTime.now(),
            deletedAt: widget.creditCard!.deletedAt,
          ));
        } else {
          await _creditCardUseCases.createCreditCardWithAccount(
            name: name,
            description: description,
            currencyId: _selectedCurrency,
            quota: quota,
            closingDay: _cutoffDay,
            paymentDueDay: _paymentDay,
            interestRate: interestRate,
          );
        }

        if (mounted) {
          NavigationService.goBack(true);
        }
      } catch (e) {
        setState(() {
          _error = 'Error al guardar: $e';
          _isLoading = false;
        });
      }
    }
  }

  void _showCurrencyDialog() async {
    // ✅ CORREGIDO: Implementar diálogo real en lugar de placeholder
    final result = await CurrencySelectionDialog.show(
      context: context,
      selectedCurrency: _selectedCurrency,
    );

    if (result != null) {
      setState(() {
        _selectedCurrency = result.id;
        // Actualizar el nombre también basado en la selección
        final currency = _currencies.firstWhere(
          (c) => c['id'] == result.id,
          orElse: () => {'id': result.id, 'name': result.name},
        );
        if (!_currencies.any((c) => c['id'] == result.id)) {
          _currencies.add({'id': result.id, 'name': result.name});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // HTML: bg-slate-50
      appBar: AppAppBar(
        title: isEditing ? 'Edit credit card' : 'New credit card',
        type: AppAppBarType.blur, // HTML: bg-slate-50/80 backdrop-blur-md
        leading: AppAppBarLeading.close, // HTML: close button
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16), // HTML: px-4 py-4
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_error != null) ...[
                    ErrorMessageCard(message: _error!),
                    const SizedBox(height: 24),
                  ],
                  
                  AppFloatingLabelField(
                    label: 'Card name',
                    controller: _nameController,
                    placeholder: 'Enter card name',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Card name is required';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  AppFloatingLabelField(
                    label: 'Description',
                    controller: _descriptionController,
                    placeholder: 'Optional description for this card',
                    maxLines: 3,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  Container(
                    height: 68, // Misma altura que AppFloatingLabelField
                    child: CurrencySelectorButton(
                      label: 'Currency',
                      selectedCurrency: _selectedCurrency,
                      selectedCurrencyName: _selectedCurrencyName,
                      onPressed: _showCurrencyDialog,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  _buildCreditLimitField(),
                  
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      'Maximum credit available on this card',
                      style: TextStyle(
                        fontSize: 12, // HTML: text-xs
                        color: Color(0xFF64748B), // HTML: text-slate-500
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  PaymentDatesRow(
                    cutoffDay: _cutoffDay,
                    paymentDay: _paymentDay,
                    onCutoffChanged: (day) {
                      setState(() {
                        _cutoffDay = day;
                      });
                    },
                    onPaymentChanged: (day) {
                      setState(() {
                        _paymentDay = day;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  _buildInterestRateField(),
                  
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      'APR for this credit card',
                      style: TextStyle(
                        fontSize: 12, // HTML: text-xs
                        color: Color(0xFF64748B), // HTML: text-slate-500
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  CardColorPalette(
                    selectedColor: _selectedColor,
                    onColorChanged: (color) {
                      setState(() {
                        _selectedColor = color;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 24), // ✅ REDUCIDO: de 100 a 24 - solo espacio mínimo necesario
                ],
              ),
            ),
          ),
        ),
        
        StickyFormFooter(
          onCancel: () => Navigator.of(context).pop(),
          onSave: _saveCreditCard,
          isLoading: _isLoading,
          isSaveEnabled: true,
        ),
      ],
    );
  }

  /// ✅ AGREGADO: Campo personalizado para Credit Limit con prefijo $
  Widget _buildCreditLimitField() {
    return Container(
      height: 68, // Misma altura que AppFloatingLabelField
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Campo de texto principal
          Positioned(
            top: 12,
            left: 0,
            right: 0,
            bottom: 0,
            child: TextFormField(
              controller: _quotaController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Credit limit is required';
                }
                if (double.tryParse(value) == null) {
                  return 'Enter a valid number';
                }
                return null;
              },
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0F172A),
                height: 1.25,
              ),
              decoration: InputDecoration(
                hintText: '0.00',
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF94A3B8),
                ),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFCBD5E1),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFCBD5E1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF3B82F6),
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFEF4444),
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFEF4444),
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.fromLTRB(32, 18, 16, 18), // Espacio extra a la izquierda para $
              ),
            ),
          ),
          
          // Prefijo $ 
          Positioned(
            left: 16,
            top: 30, // Centrado en el campo de 56px altura (12 + 56/2 - 8 = 30)
            child: const Text(
              '\$',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF64748B),
              ),
            ),
          ),
          
          // Label flotante
          Positioned(
            left: 12,
            top: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              color: const Color(0xFFF8FAFC),
              child: const Text(
                'Credit limit',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ AGREGADO: Campo personalizado para Interest Rate con sufijo %
  Widget _buildInterestRateField() {
    return Container(
      height: 68, // Misma altura que AppFloatingLabelField
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Campo de texto principal
          Positioned(
            top: 12,
            left: 0,
            right: 0,
            bottom: 0,
            child: TextFormField(
              controller: _interestRateController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return null; // Optional field
                }
                if (double.tryParse(value) == null) {
                  return 'Enter a valid number';
                }
                return null;
              },
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0F172A),
                height: 1.25,
              ),
              decoration: InputDecoration(
                hintText: '0.00',
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF94A3B8),
                ),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFCBD5E1),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFCBD5E1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF3B82F6),
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFEF4444),
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFEF4444),
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 18, 32, 18), // Espacio extra a la derecha para %
              ),
            ),
          ),
          
          // Sufijo %
          Positioned(
            right: 16,
            top: 30, // Centrado en el campo
            child: const Text(
              '%',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF64748B),
              ),
            ),
          ),
          
          // Label flotante
          Positioned(
            left: 12,
            top: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              color: const Color(0xFFF8FAFC),
              child: const Text(
                'Annual interest rate',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

