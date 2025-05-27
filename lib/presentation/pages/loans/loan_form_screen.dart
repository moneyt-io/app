import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/presentation/app_dimensions.dart';
import '../../providers/loan_provider.dart';
import '../../molecules/currency_selector.dart';
import '../../routes/navigation_service.dart';

class LoanFormScreen extends StatefulWidget {
  final String loanType; // 'L' para Lend, 'B' para Borrow
  final dynamic editingLoan; // Para editar préstamos existentes

  const LoanFormScreen({
    super.key,
    required this.loanType,
    this.editingLoan,
  });

  @override
  State<LoanFormScreen> createState() => _LoanFormScreenState();
}

class _LoanFormScreenState extends State<LoanFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contactController = TextEditingController(); // AGREGADO para el contacto temporal
  
  // Form state
  String _selectedCurrencyId = 'USD';
  DateTime _selectedDate = DateTime.now();
  
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.editingLoan != null) {
      _populateFormForEditing();
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _contactController.dispose(); // AGREGADO
    super.dispose();
  }

  void _populateFormForEditing() {
    final loan = widget.editingLoan;
    _amountController.text = loan.amount.toString();
    _descriptionController.text = loan.description ?? '';
    _selectedCurrencyId = loan.currencyId;
    _selectedDate = loan.date;
    // TODO: Cargar otros campos cuando tengamos la estructura completa
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.editingLoan != null;
    final isLending = widget.loanType == 'L';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing 
            ? 'Editar Préstamo'
            : isLending 
                ? 'Prestar Dinero' 
                : 'Pedir Prestado'),
        actions: [
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Información del tipo de préstamo
              _buildLoanTypeCard(isLending),
              const SizedBox(height: AppDimensions.spacing16),

              // Selector de contacto (simplificado)
              _buildContactSection(),
              const SizedBox(height: AppDimensions.spacing16),

              // Monto y moneda
              _buildAmountAndCurrencySection(),
              const SizedBox(height: AppDimensions.spacing16),

              // Fecha
              _buildDateSelector(),
              const SizedBox(height: AppDimensions.spacing16),

              // Descripción
              _buildDescriptionField(),
              const SizedBox(height: AppDimensions.spacing24),

              // Preview del impacto
              _buildImpactPreview(),
              const SizedBox(height: AppDimensions.spacing24),

              // Botones de acción
              _buildActionButtons(isEditing),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoanTypeCard(bool isLending) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Row(
          children: [
            Icon(
              isLending ? Icons.trending_up : Icons.trending_down,
              color: isLending ? Colors.blue : Colors.orange,
              size: 32,
            ),
            const SizedBox(width: AppDimensions.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isLending ? 'Préstamo Otorgado' : 'Préstamo Recibido',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    isLending 
                        ? 'Dinero que prestas a otros'
                        : 'Dinero que recibes de otros',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contacto',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: AppDimensions.spacing8),
        TextFormField(
          controller: _contactController, // CAMBIADO para usar el controller
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nombre del contacto',
            prefixIcon: Icon(Icons.person),
            hintText: 'Ej: Juan Pérez',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Debe ingresar un contacto';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildAmountAndCurrencySection() {
    return Row(
      children: [
        // Campo de monto
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Monto',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: AppDimensions.spacing8),
              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '0.00',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese un monto';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Monto debe ser mayor a 0';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: AppDimensions.spacing12),
        // Selector de moneda
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Moneda',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: AppDimensions.spacing8),
              CurrencySelector(
                selectedCurrencyId: _selectedCurrencyId,
                onCurrencyChanged: (currencyId) {
                  setState(() {
                    _selectedCurrencyId = currencyId;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fecha',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: AppDimensions.spacing8),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: _selectedDate,
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              setState(() {
                _selectedDate = date;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.spacing12),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: AppDimensions.spacing8),
                Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Descripción (Opcional)',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: AppDimensions.spacing8),
        TextFormField(
          controller: _descriptionController,
          maxLines: 3,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Detalles adicionales sobre el préstamo...',
          ),
        ),
      ],
    );
  }

  Widget _buildImpactPreview() {
    if (_amountController.text.isEmpty) {
      return const SizedBox.shrink();
    }

    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      return const SizedBox.shrink();
    }

    final isLending = widget.loanType == 'L';
    
    return Card(
      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vista Previa del Impacto',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppDimensions.spacing8),
            _buildImpactLine(
              isLending ? 'Cuentas por Cobrar' : 'Cuentas por Pagar',
              '+\$${amount.toStringAsFixed(2)}',
              isLending ? Colors.green : Colors.orange,
            ),
            _buildImpactLine(
              'Wallet por Determinar',
              isLending ? '-\$${amount.toStringAsFixed(2)}' : '+\$${amount.toStringAsFixed(2)}',
              isLending ? Colors.red : Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImpactLine(String account, String amount, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            account,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            amount,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(bool isEditing) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: _isLoading ? null : _submitForm,
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(isEditing ? 'Actualizar Préstamo' : 'Crear Préstamo'),
          ),
        ),
        const SizedBox(height: AppDimensions.spacing8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
        ),
      ],
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final loanProvider = Provider.of<LoanProvider>(context, listen: false);
      final amount = double.parse(_amountController.text);
      
      // Por ahora usar contactId dummy
      final result = await loanProvider.createSimpleLoan(
        documentTypeId: widget.loanType,
        contactId: 1, // TODO: Usar contacto real cuando tengamos ContactProvider
        amount: amount,
        currencyId: _selectedCurrencyId,
        date: _selectedDate,
        description: _descriptionController.text.isNotEmpty 
            ? _descriptionController.text 
            : null,
      );

      if (result != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.loanType == 'L' 
                  ? 'Préstamo otorgado creado exitosamente'
                  : 'Préstamo recibido creado exitosamente'
            ),
            backgroundColor: Colors.green,
          ),
        );
        NavigationService.goBack(result);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loanProvider.errorMessage ?? 'Error al crear préstamo'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
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
}
