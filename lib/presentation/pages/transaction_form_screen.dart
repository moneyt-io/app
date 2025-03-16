import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/transaction.dart';
import '../atoms/app_button.dart';
import '../molecules/form_field_container.dart';
import '../routes/navigation_service.dart';

// Datos simulados para los selectores
final mockAccounts = [
  {'id': 1, 'name': 'Efectivo'},
  {'id': 2, 'name': 'Cuenta Principal'},
  {'id': 3, 'name': 'Tarjeta de Débito'},
];

final mockCategories = [
  {'id': 1, 'name': 'Alimentación', 'type': 'E'},
  {'id': 2, 'name': 'Transporte', 'type': 'E'},
  {'id': 3, 'name': 'Entretenimiento', 'type': 'E'},
  {'id': 4, 'name': 'Salud', 'type': 'E'},
  {'id': 5, 'name': 'Salario', 'type': 'I'},
  {'id': 6, 'name': 'Inversiones', 'type': 'I'},
];

final mockContacts = [
  {'id': 1, 'name': 'Ana García'},
  {'id': 2, 'name': 'Juan Pérez'},
];

class TransactionFormScreen extends StatefulWidget {
  final TransactionEntity? transaction;
  final String initialType;

  const TransactionFormScreen({
    Key? key,
    this.transaction,
    required this.initialType,
  }) : super(key: key);

  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  late TabController _typeTabController;
  
  late String _selectedType;
  late String _flow;
  late DateTime _selectedDate;
  
  int? _selectedAccountId;
  int? _selectedToAccountId;
  int? _selectedCategoryId;
  int? _selectedContactId;

  bool get isTransfer => _selectedType == 'T';
  bool get isExpense => _selectedType == 'E';
  bool get isIncome => _selectedType == 'I';
  bool get isEditing => widget.transaction != null;

  @override
  void initState() {
    super.initState();
    
    // Inicializar tipo de transacción
    _selectedType = widget.transaction?.type ?? 
                   (widget.initialType == 'all' ? 'E' : widget.initialType);
    _flow = _selectedType == 'I' ? 'I' : _selectedType == 'T' ? 'T' : 'O';
    
    // Inicializar TabController
    _typeTabController = TabController(
      length: 3, 
      vsync: this,
      initialIndex: _selectedType == 'E' ? 0 : _selectedType == 'I' ? 1 : 2,
    );
    
    _typeTabController.addListener(_handleTabChange);
    _initializeFormData();
  }

  void _handleTabChange() {
    if (!_typeTabController.indexIsChanging) return;
    
    setState(() {
      switch (_typeTabController.index) {
        case 0:
          _selectedType = 'E'; // Gasto
          _flow = 'O';
          break;
        case 1:
          _selectedType = 'I'; // Ingreso
          _flow = 'I';
          break;
        case 2:
          _selectedType = 'T'; // Transferencia
          _flow = 'T';
          break;
      }
      
      // Resetear categoría si cambiamos a transferencia
      if (isTransfer) {
        _selectedCategoryId = null;
      }
    });
  }

  void _initializeFormData() {
    if (isEditing) {
      final transaction = widget.transaction!;
      _amountController.text = transaction.amount.toString();
      _descriptionController.text = transaction.description ?? '';
      _selectedDate = transaction.transactionDate;
      _selectedAccountId = transaction.accountId;
      _selectedCategoryId = transaction.categoryId;
      _selectedContactId = transaction.contactId;
      
      // Para transferencias, buscar la cuenta destino usando la referencia
      if (isTransfer && transaction.reference != null) {
        for (var account in mockAccounts) {
          if (account['name'] == transaction.reference) {
            _selectedToAccountId = account['id'] as int;
            break;
          }
        }
      }
    } else {
      _selectedDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _typeTabController.removeListener(_handleTabChange);
    _typeTabController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime now = DateTime.now();
    
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year + 1, 12, 31),
    );
    
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _saveTransaction() {
    if (!_formKey.currentState!.validate()) return;
    
    // Validaciones adicionales
    if (_selectedAccountId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor seleccione una cuenta')),
      );
      return;
    }

    if (!isTransfer && _selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor seleccione una categoría')),
      );
      return;
    }

    if (isTransfer && _selectedToAccountId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor seleccione una cuenta destino')),
      );
      return;
    }

    // Crear objeto de transacción
    double amount = double.tryParse(_amountController.text.replaceAll(',', '.')) ?? 0.0;
    
    // En una transferencia, asegurar que el monto sea positivo
    if (isTransfer) {
      amount = amount.abs();
    }
    
    // Para gastos, el monto debe ser negativo en la UI
    if (isExpense && amount > 0) {
      amount = -amount;
    }

    // Obtener referencia para transferencias
    String? reference;
    if (isTransfer && _selectedToAccountId != null) {
      for (var account in mockAccounts) {
        if (account['id'] == _selectedToAccountId) {
          reference = account['name'] as String;
          break;
        }
      }
    }

    final TransactionEntity transaction = TransactionEntity(
      id: isEditing ? widget.transaction!.id : DateTime.now().millisecondsSinceEpoch,
      type: _selectedType,
      flow: _flow,
      amount: amount,
      accountId: _selectedAccountId!,
      categoryId: isTransfer ? null : _selectedCategoryId,
      contactId: _selectedContactId,
      description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
      reference: reference,
      transactionDate: _selectedDate,
      createdAt: isEditing ? widget.transaction!.createdAt : DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Mostrar mensaje de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isEditing ? 'Transacción actualizada' : 'Transacción creada'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );

    // Devolver la transacción a la pantalla anterior
    //NavigationService.goBack(result: transaction);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Determinar el título según el tipo de transacción
    String title;
    switch (_selectedType) {
      case 'E':
        title = isEditing ? 'Editar Gasto' : 'Nuevo Gasto';
        break;
      case 'I':
        title = isEditing ? 'Editar Ingreso' : 'Nuevo Ingreso';
        break;
      case 'T':
        title = isEditing ? 'Editar Transferencia' : 'Nueva Transferencia';
        break;
      default:
        title = isEditing ? 'Editar Transacción' : 'Nueva Transacción';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        bottom: !isEditing ? TabBar(
          controller: _typeTabController,
          tabs: const [
            Tab(text: 'GASTO'),
            Tab(text: 'INGRESO'),
            Tab(text: 'TRANSFERENCIA'),
          ],
          labelColor: colorScheme.primary,
        ) : null,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Monto
            FormFieldContainer(
              child: TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Monto',
                  prefixIcon: Icon(
                    Icons.attach_money,
                    color: colorScheme.primary,
                  ),
                  border: InputBorder.none,
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un monto';
                  }
                  final amount = double.tryParse(value.replaceAll(',', '.'));
                  if (amount == null || amount <= 0) {
                    return 'Ingrese un monto válido';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            const SizedBox(height: 16),
            
            // Fecha
            FormFieldContainer(
              child: InkWell(
                onTap: _selectDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Fecha',
                    prefixIcon: Icon(
                      Icons.calendar_today,
                      color: colorScheme.primary,
                    ),
                    border: InputBorder.none,
                  ),
                  child: Text(
                    DateFormat('dd/MM/yyyy').format(_selectedDate),
                    style: textTheme.bodyLarge,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Cuenta origen
            FormFieldContainer(
              child: DropdownButtonFormField<int>(
                value: _selectedAccountId,
                decoration: InputDecoration(
                  labelText: 'Cuenta',
                  prefixIcon: Icon(
                    Icons.account_balance_wallet,
                    color: colorScheme.primary,
                  ),
                  border: InputBorder.none,
                ),
                items: mockAccounts.map((account) {
                  return DropdownMenuItem(
                    value: account['id'] as int,
                    child: Text(account['name'] as String),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedAccountId = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Por favor seleccione una cuenta';
                  }
                  return null;
                },
              ),
            ),

            // Cuenta destino (solo para transferencias)
            if (isTransfer) ...[
              const SizedBox(height: 16),
              FormFieldContainer(
                child: DropdownButtonFormField<int>(
                  value: _selectedToAccountId,
                  decoration: InputDecoration(
                    labelText: 'Cuenta destino',
                    prefixIcon: Icon(
                      Icons.account_balance_wallet,
                      color: colorScheme.primary,
                    ),
                    border: InputBorder.none,
                  ),
                  items: mockAccounts
                      .where((account) => account['id'] != _selectedAccountId)
                      .map((account) {
                    return DropdownMenuItem(
                      value: account['id'] as int,
                      child: Text(account['name'] as String),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedToAccountId = value;
                    });
                  },
                  validator: (value) {
                    if (isTransfer && value == null) {
                      return 'Por favor seleccione una cuenta destino';
                    }
                    return null;
                  },
                ),
              ),
            ],

            // Categoría (solo para ingresos y gastos)
            if (!isTransfer) ...[
              const SizedBox(height: 16),
              FormFieldContainer(
                child: DropdownButtonFormField<int>(
                  value: _selectedCategoryId,
                  decoration: InputDecoration(
                    labelText: 'Categoría',
                    prefixIcon: Icon(
                      Icons.category,
                      color: colorScheme.primary,
                    ),
                    border: InputBorder.none,
                  ),
                  items: mockCategories
                      .where((cat) => cat['type'] == _selectedType)
                      .map((category) {
                    return DropdownMenuItem(
                      value: category['id'] as int,
                      child: Text(category['name'] as String),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategoryId = value;
                    });
                  },
                  validator: (value) {
                    if (!isTransfer && value == null) {
                      return 'Por favor seleccione una categoría';
                    }
                    return null;
                  },
                ),
              ),
            ],

            // Contacto (opcional)
            if (!isTransfer) ...[
              const SizedBox(height: 16),
              FormFieldContainer(
                child: DropdownButtonFormField<int>(
                  value: _selectedContactId,
                  decoration: InputDecoration(
                    labelText: 'Contacto (opcional)',
                    prefixIcon: Icon(
                      Icons.person,
                      color: colorScheme.primary,
                    ),
                    border: InputBorder.none,
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('Ninguno'),
                    ),
                    ...mockContacts.map((contact) {
                      return DropdownMenuItem(
                        value: contact['id'] as int,
                        child: Text(contact['name'] as String),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedContactId = value;
                    });
                  },
                ),
              ),
            ],

            // Descripción
            const SizedBox(height: 16),
            FormFieldContainer(
              child: TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descripción (opcional)',
                  prefixIcon: Icon(
                    Icons.description,
                    color: colorScheme.primary,
                  ),
                  border: InputBorder.none,
                ),
                maxLines: 3,
              ),
            ),
            
            const SizedBox(height: 32),
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
          onPressed: _saveTransaction,
          type: AppButtonType.primary,
          isFullWidth: true,
        ),
      ),
    );
  }
}
