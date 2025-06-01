import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/credit_card.dart';
import '../../../domain/entities/chart_account.dart';
import '../../../domain/usecases/credit_card_usecases.dart';
import '../../../domain/usecases/chart_account_usecases.dart';
import '../../core/atoms/app_button.dart';
import '../../core/design_system/theme/app_dimensions.dart';
import '../../core/molecules/error_message_card.dart';
import '../../core/molecules/form_field_container.dart';
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
  final _closingDayController = TextEditingController();
  final _paymentDueDayController = TextEditingController();
  final _interestRateController = TextEditingController();
  
  String _selectedCurrency = 'USD';
  bool _isLoading = false;
  bool _isChartAccountLoading = false;
  String? _error;
  ChartAccount? _associatedChartAccount;

  bool get isEditing => widget.creditCard != null;
  late final CreditCardUseCases _creditCardUseCases;
  late final ChartAccountUseCases _chartAccountUseCases;

  final List<Map<String, String>> _currencies = [
    {'id': 'USD', 'name': 'Dólar estadounidense'},
    {'id': 'EUR', 'name': 'Euro'},
    {'id': 'COP', 'name': 'Peso colombiano'},
    {'id': 'MXN', 'name': 'Peso mexicano'},
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
      _closingDayController.text = creditCard.closingDay.toString();
      _paymentDueDayController.text = creditCard.paymentDueDay.toString();
      _interestRateController.text = creditCard.interestRate.toString();
      _selectedCurrency = creditCard.currencyId;
    } else {
      _closingDayController.text = '1';
      _paymentDueDayController.text = '15';
      _interestRateController.text = '0.0';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _quotaController.dispose();
    _closingDayController.dispose();
    _paymentDueDayController.dispose();
    _interestRateController.dispose();
    super.dispose();
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
        final closingDay = int.parse(_closingDayController.text);
        final paymentDueDay = int.parse(_paymentDueDayController.text);
        final interestRate = double.tryParse(_interestRateController.text) ?? 0.0;

        if (isEditing) {
          await _creditCardUseCases.updateCreditCard(CreditCard(
            id: widget.creditCard!.id,
            name: name,
            description: description,
            currencyId: _selectedCurrency,
            chartAccountId: widget.creditCard!.chartAccountId,
            quota: quota,
            closingDay: closingDay,
            paymentDueDay: paymentDueDay,
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
            closingDay: closingDay,
            paymentDueDay: paymentDueDay,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Tarjeta' : 'Nueva Tarjeta'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final colorScheme = Theme.of(context).colorScheme;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spacing16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: AppDimensions.spacing24),
                child: ErrorMessageCard(message: _error!),
              ),
              
            _buildSectionHeader('Información General', colorScheme),
            
            const SizedBox(height: AppDimensions.spacing16),
            
            // Name field with proper decoration
            FormFieldContainer(
              child: TextFormField(
                controller: _nameController,
                decoration: FormFieldContainer.getOutlinedDecoration(
                  context,
                  labelText: 'Nombre',
                  prefixIcon: Icon(
                    Icons.credit_card,
                    color: colorScheme.primary,
                  ),
                  hintText: 'Ej: Tarjeta Principal',
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
            
            // Description field with proper decoration
            FormFieldContainer(
              child: TextFormField(
                controller: _descriptionController,
                maxLines: 2,
                decoration: FormFieldContainer.getOutlinedDecoration(
                  context,
                  labelText: 'Descripción (opcional)',
                  prefixIcon: Icon(
                    Icons.description_outlined,
                    color: colorScheme.primary,
                  ),
                  hintText: 'Descripción adicional...',
                ),
              ),
            ),
            
            const SizedBox(height: AppDimensions.spacing16),
            
            // Currency field with proper decoration
            FormFieldContainer(
              child: DropdownButtonFormField<String>(
                value: _selectedCurrency,
                decoration: FormFieldContainer.getOutlinedDecoration(
                  context,
                  labelText: 'Moneda',
                  prefixIcon: Icon(
                    Icons.currency_exchange,
                    color: colorScheme.primary,
                  ),
                ),
                items: _currencies.map((currency) {
                  return DropdownMenuItem(
                    value: currency['id'],
                    child: Text('${currency['name']} (${currency['id']})'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCurrency = value!;
                  });
                },
              ),
            ),
            
            const SizedBox(height: AppDimensions.spacing24),
            
            _buildSectionHeader('Detalles Financieros', colorScheme),
            
            const SizedBox(height: AppDimensions.spacing16),
            
            FormFieldContainer(
              child: TextFormField(
                controller: _quotaController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: FormFieldContainer.getOutlinedDecoration(
                  context,
                  labelText: 'Límite de Crédito',
                  prefixIcon: Icon(
                    Icons.attach_money,
                    color: colorScheme.primary,
                  ),
                  hintText: 'Ej: 5000.00',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El límite es requerido';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Ingrese un valor numérico válido';
                  }
                  return null;
                },
              ),
            ),
            
            const SizedBox(height: AppDimensions.spacing16),
            
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FormFieldContainer(
                    child: TextFormField(
                      controller: _closingDayController,
                      keyboardType: TextInputType.number,
                      decoration: FormFieldContainer.getOutlinedDecoration(
                        context,
                        labelText: 'Día de Corte',
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: colorScheme.primary,
                        ),
                        hintText: 'Ej: 15',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Requerido';
                        }
                        final day = int.tryParse(value);
                        if (day == null || day < 1 || day > 31) {
                          return 'Día inválido';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                
                const SizedBox(width: AppDimensions.spacing16),
                
                Expanded(
                  child: FormFieldContainer(
                    child: TextFormField(
                      controller: _paymentDueDayController,
                      keyboardType: TextInputType.number,
                      decoration: FormFieldContainer.getOutlinedDecoration(
                        context,
                        labelText: 'Día de Pago',
                        prefixIcon: Icon(
                          Icons.payment,
                          color: colorScheme.primary,
                        ),
                        hintText: 'Ej: 20',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Requerido';
                        }
                        final day = int.tryParse(value);
                        if (day == null || day < 1 || day > 31) {
                          return 'Día inválido';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppDimensions.spacing16),
            
            FormFieldContainer(
              child: TextFormField(
                controller: _interestRateController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: FormFieldContainer.getOutlinedDecoration(
                  context,
                  labelText: 'Tasa de Interés (%)',
                  prefixIcon: Icon(
                    Icons.percent,
                    color: colorScheme.primary,
                  ),
                  hintText: 'Ej: 2.5',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return null;
                  }
                  if (double.tryParse(value) == null) {
                    return 'Ingrese un valor numérico válido';
                  }
                  return null;
                },
              ),
            ),
            
            const SizedBox(height: AppDimensions.spacing24),
            
            _buildSectionHeader('Información Contable', colorScheme),
            
            const SizedBox(height: AppDimensions.spacing16),
            
            if (_isChartAccountLoading)
              const Center(child: CircularProgressIndicator())
            else if (_associatedChartAccount != null)
              Container(
                padding: const EdgeInsets.all(AppDimensions.spacing16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cuenta Contable Asociada:',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppDimensions.spacing8),
                    Text(
                      '${_associatedChartAccount!.code} - ${_associatedChartAccount!.name}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              )
            else if (isEditing)
              Text(
                'No hay cuenta contable asociada',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.error,
                ),
              )
            else
              Text(
                'Se creará una cuenta contable automáticamente',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            
            const SizedBox(height: AppDimensions.spacing32),
            
            AppButton(
              text: isEditing ? 'Actualizar' : 'Crear',
              onPressed: _isLoading ? null : _saveCreditCard,
              isLoading: _isLoading,
              type: AppButtonType.filled,
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSectionHeader(String title, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.spacing4),
        Divider(color: colorScheme.primary.withOpacity(0.2)),
      ],
    );
  }
}
