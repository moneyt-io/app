import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/transaction_entry.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/contact.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../domain/usecases/wallet_usecases.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/contact_usecases.dart';
import '../atoms/app_button.dart';
import '../molecules/form_field_container.dart';
import '../routes/navigation_service.dart';

class TransactionFormScreen extends StatefulWidget {
  final TransactionEntry? transaction;
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
  
  final _transactionUseCases = GetIt.instance<TransactionUseCases>();
  final _walletUseCases = GetIt.instance<WalletUseCases>();
  final _categoryUseCases = GetIt.instance<CategoryUseCases>();
  final _contactUseCases = GetIt.instance<ContactUseCases>();
  
  late TabController _typeTabController;
  
  late String _selectedType;
  DateTime _selectedDate = DateTime.now();
  
  List<Wallet> _wallets = [];
  List<Category> _categories = [];
  List<Contact> _contacts = [];
  
  int? _selectedWalletId;
  int? _selectedTargetWalletId;
  int? _selectedCategoryId;
  int? _selectedContactId;
  String _selectedCurrencyId = 'USD'; // Default, will be updated from wallet
  
  bool _isLoading = true;
  String? _error;

  bool get isTransfer => _selectedType == 'T';
  bool get isExpense => _selectedType == 'E';
  bool get isIncome => _selectedType == 'I';
  bool get isEditing => widget.transaction != null;

  @override
  void initState() {
    super.initState();
    
    // Inicializar tipo de transacción
    _selectedType = widget.transaction?.documentTypeId ?? 
                   (widget.initialType == 'all' ? 'E' : widget.initialType);
    
    // Inicializar TabController
    _typeTabController = TabController(
      length: 3, 
      vsync: this,
      initialIndex: _selectedType == 'E' ? 0 : _selectedType == 'I' ? 1 : 2,
    );
    
    _typeTabController.addListener(_handleTabChange);
    _loadData();
  }

  void _handleTabChange() {
    if (!_typeTabController.indexIsChanging) return;
    
    setState(() {
      switch (_typeTabController.index) {
        case 0:
          _selectedType = 'E'; // Gasto
          break;
        case 1:
          _selectedType = 'I'; // Ingreso
          break;
        case 2:
          _selectedType = 'T'; // Transferencia
          break;
      }
      
      // Actualizar categoría según el tipo
      _updateCategoryForType();
      
      // Resetear categoría si cambiamos a transferencia
      if (isTransfer) {
        _selectedCategoryId = null;
      }
    });
  }

  void _updateCategoryForType() {
    // Seleccionar categoría adecuada al tipo
    if (!isTransfer && _categories.isNotEmpty) {
      final filteredCategories = _categories.where((c) => 
        (isIncome && c.documentTypeId == 'I') || 
        (isExpense && c.documentTypeId == 'E')
      ).toList();
      
      if (filteredCategories.isNotEmpty && _selectedCategoryId == null) {
        _selectedCategoryId = filteredCategories.first.id;
      } else if (filteredCategories.isEmpty) {
        _selectedCategoryId = null;
      } else {
        // Verificar si la categoría actual es del tipo correcto
        final currentCategoryType = _categories
            .where((c) => c.id == _selectedCategoryId)
            .map((c) => c.documentTypeId)
            .firstOrNull;
        
        if (currentCategoryType != _selectedType) {
          _selectedCategoryId = filteredCategories.first.id;
        }
      }
    }
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });
      
      // Cargar wallets
      final wallets = await _walletUseCases.getAllWallets();
      
      // Cargar categorías
      final categories = await _categoryUseCases.getAllCategories();
      
      // Cargar contactos
      final contacts = await _contactUseCases.getAllContacts();
      
      setState(() {
        _wallets = wallets;
        _categories = categories;
        _contacts = contacts;
        _isLoading = false;
      });
      
      _initializeFormData();
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _initializeFormData() {
    if (isEditing) {
      final transaction = widget.transaction!;
      _amountController.text = transaction.amount.toString();
      _descriptionController.text = transaction.description ?? '';
      _selectedDate = transaction.date;
      _selectedCurrencyId = transaction.currencyId;
      
      // Configurar wallet y categoría desde los detalles
      final detail = transaction.mainDetail;
      if (detail != null) {
        _selectedWalletId = detail.paymentId;
        _selectedCategoryId = detail.categoryId > 0 ? detail.categoryId : null;
      }
      
      _selectedContactId = transaction.contactId;
      
      // Para transferencias, buscar la cuenta destino usando el detalle de destino
      if (isTransfer && transaction.details.length > 1) {
        final targetDetail = transaction.targetDetail;
        if (targetDetail != null) {
          _selectedTargetWalletId = targetDetail.paymentId;
        }
      }
    } else {
      // Establecer valores iniciales para nueva transacción
      if (_wallets.isNotEmpty) {
        _selectedWalletId = _wallets.first.id;
        // Actualizar moneda según wallet seleccionada
        final wallet = _wallets.firstWhere((w) => w.id == _selectedWalletId, 
                                           orElse: () => _wallets.first);
        _selectedCurrencyId = wallet.currencyId;
      }
      
      _updateCategoryForType();
      
      // Para transferencias, seleccionar wallet destino
      if (isTransfer && _wallets.length > 1) {
        // Seleccionar wallet destino diferente al origen
        for (final wallet in _wallets) {
          if (wallet.id != _selectedWalletId) {
            _selectedTargetWalletId = wallet.id;
            break;
          }
        }
      }
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

  Future<void> _saveTransaction() async {
    if (!_formKey.currentState!.validate()) return;
    
    // Validaciones adicionales
    if (_selectedWalletId == null) {
      _showErrorMessage('Por favor seleccione una cuenta');
      return;
    }

    if (!isTransfer && _selectedCategoryId == null) {
      _showErrorMessage('Por favor seleccione una categoría');
      return;
    }

    if (isTransfer && _selectedTargetWalletId == null) {
      _showErrorMessage('Por favor seleccione una cuenta destino');
      return;
    }

    if (isTransfer && _selectedWalletId == _selectedTargetWalletId) {
      _showErrorMessage('Las cuentas de origen y destino no pueden ser la misma');
      return;
    }

    // Crear objeto de transacción
    double amount = double.tryParse(_amountController.text.replaceAll(',', '.')) ?? 0.0;
    
    if (amount <= 0) {
      _showErrorMessage('El monto debe ser mayor a cero');
      return;
    }
    
    try {
      setState(() {
        _isLoading = true;
      });
      
      // Obtener el wallet y su moneda
      final wallet = _wallets.firstWhere((w) => w.id == _selectedWalletId);
      final currencyId = wallet.currencyId;
      
      TransactionEntry result;
      
      if (isEditing) {
        // Implementar actualización
        _showErrorMessage('La edición de transacciones no está implementada');
        setState(() {
          _isLoading = false;
        });
        return;
      } else {
        // Crear nueva transacción según el tipo
        if (isIncome) {
          result = await _transactionUseCases.createIncome(
            date: _selectedDate,
            description: _descriptionController.text,
            amount: amount,
            currencyId: currencyId,
            walletId: _selectedWalletId!,
            categoryId: _selectedCategoryId!,
            contactId: _selectedContactId,
          );
        } else if (isExpense) {
          result = await _transactionUseCases.createExpense(
            date: _selectedDate,
            description: _descriptionController.text,
            amount: amount,
            currencyId: currencyId,
            walletId: _selectedWalletId!,
            categoryId: _selectedCategoryId!,
            contactId: _selectedContactId,
          );
        } else {
          // Es transferencia
          final targetWallet = _wallets.firstWhere((w) => w.id == _selectedTargetWalletId);
          final targetCurrencyId = targetWallet.currencyId;
          
          // Si las monedas son diferentes, la cantidad destino sería diferente
          double targetAmount = amount;
          double rateExchange = 1.0;
          
          if (currencyId != targetCurrencyId) {
            // En una implementación real, obtendríamos la tasa de cambio de un servicio
            rateExchange = 1.1; // Ejemplo: 1 USD = 1.1 EUR
            targetAmount = amount * rateExchange;
          }
          
          result = await _transactionUseCases.createTransfer(
            date: _selectedDate,
            description: _descriptionController.text,
            amount: amount,
            currencyId: currencyId,
            sourceWalletId: _selectedWalletId!,
            targetWalletId: _selectedTargetWalletId!,
            targetCurrencyId: targetCurrencyId,
            targetAmount: targetAmount,
            rateExchange: rateExchange,
            contactId: _selectedContactId,
          );
        }
      }
      
      // Volver a la pantalla anterior con el resultado
      setState(() {
        _isLoading = false;
      });
      
      _showSuccessMessage('Transacción guardada correctamente');
      
      // Agregar un pequeño retraso para que el usuario vea el mensaje
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          NavigationService.goBack(result); // Corregido: era NavigationService.goBack(value)
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorMessage('Error al guardar: ${e.toString()}');
    }
  }

  void _showErrorMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void _showSuccessMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
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
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator()) 
        : _error != null
          ? _buildErrorState()
          : Form(
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
                      value: _selectedWalletId,
                      decoration: InputDecoration(
                        labelText: 'Cuenta',
                        prefixIcon: Icon(
                          Icons.account_balance_wallet,
                          color: colorScheme.primary,
                        ),
                        border: InputBorder.none,
                      ),
                      items: _wallets.map((wallet) {
                        return DropdownMenuItem(
                          value: wallet.id,
                          child: Text('${wallet.name} (${wallet.currencyId})'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedWalletId = value;
                          
                          // Actualizar moneda según wallet seleccionada
                          if (value != null) {
                            final wallet = _wallets.firstWhere((w) => w.id == value);
                            _selectedCurrencyId = wallet.currencyId;
                          }
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
                        value: _selectedTargetWalletId,
                        decoration: InputDecoration(
                          labelText: 'Cuenta destino',
                          prefixIcon: Icon(
                            Icons.account_balance_wallet,
                            color: colorScheme.primary,
                          ),
                          border: InputBorder.none,
                        ),
                        items: _wallets
                            .where((wallet) => wallet.id != _selectedWalletId)
                            .map((wallet) {
                          return DropdownMenuItem(
                            value: wallet.id,
                            child: Text('${wallet.name} (${wallet.currencyId})'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedTargetWalletId = value;
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
                        items: _categories
                            .where((cat) => cat.documentTypeId == _selectedType)
                            .map((category) {
                          return DropdownMenuItem(
                            value: category.id,
                            child: Text(category.name),
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
                  const SizedBox(height: 16),
                  FormFieldContainer(
                    child: DropdownButtonFormField<int?>(
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
                        ..._contacts.map((contact) {
                          return DropdownMenuItem(
                            value: contact.id,
                            child: Text(contact.name),
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
          onPressed: _isLoading ? null : _saveTransaction,
          type: AppButtonType.primary,
          isFullWidth: true,
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            const Text(
              'Error al cargar los datos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(_error ?? 'Error desconocido'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadData,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
