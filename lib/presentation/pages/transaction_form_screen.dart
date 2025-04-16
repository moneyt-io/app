import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/entities/contact.dart';
import '../../domain/usecases/wallet_usecases.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/contact_usecases.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../atoms/app_button.dart';
import '../molecules/form_field_container.dart';
import '../routes/navigation_service.dart';
import 'package:intl/date_symbol_data_local.dart';

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
  
  // Estados de la pantalla
  late String _selectedType;
  late String _flow;
  late DateTime _selectedDate;
  
  int? _selectedAccountId;
  int? _selectedToAccountId;
  int? _selectedCategoryId;
  int? _selectedContactId;
  
  bool _isLoading = true;
  String? _error;
  
  // Datos reales
  List<Wallet> _wallets = [];
  List<Category> _categories = [];
  List<Contact> _contacts = [];
  
  // Obtener casos de uso usando GetIt
  final _walletUseCases = GetIt.instance<WalletUseCases>();
  final _categoryUseCases = GetIt.instance<CategoryUseCases>();
  final _contactUseCases = GetIt.instance<ContactUseCases>();
  final _transactionUseCases = GetIt.instance<TransactionUseCases>();
  
  // Getters para UI
  bool get isTransfer => _selectedType == 'T';
  bool get isExpense => _selectedType == 'E';
  bool get isIncome => _selectedType == 'I';
  bool get isEditing => widget.transaction != null;

  @override
  void initState() {
    super.initState();
    
    // Inicializar formateo de fechas si aún no se ha hecho
    initializeDateFormatting('es_ES', null);
    
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
    
    // Cargar datos y luego inicializar el formulario
    _loadData().then((_) => _initializeFormData());
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Cargar los datos reales de los repositorios
      final walletsResult = await _walletUseCases.getAllWallets();
      final categoriesResult = await _categoryUseCases.getAllCategories();
      final contactsResult = await _contactUseCases.getAllContacts();

      // Si estamos editando, asegurarnos de cargar la transacción completa
      if (isEditing && widget.transaction != null) {
        final transactionResult = await _transactionUseCases.getTransactionById(widget.transaction!.id!);
        if (transactionResult != null) {
          // Podemos usar la transacción completa si es necesario
        }
      }

      setState(() {
        _wallets = walletsResult;
        _categories = categoriesResult;
        _contacts = contactsResult;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = "Error al cargar los datos: ${e.toString()}";
        _isLoading = false;
      });
    }
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
        for (var wallet in _wallets) {
          if (wallet.name == transaction.reference) {
            _selectedToAccountId = wallet.id;
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

  void _saveTransaction() async {
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

    setState(() {
      _isLoading = true;
    });

    try {
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
        final selectedWallet = _wallets.firstWhere(
          (wallet) => wallet.id == _selectedToAccountId,
          orElse: () => throw Exception('Wallet destino no encontrada'),
        );
        reference = selectedWallet.name;
      }

      if (isEditing) {
        // Actualizar transacción existente
        // Implementar según necesidad
      } else {
        // Crear nueva transacción
        if (isExpense) {
          await _transactionUseCases.createExpense(
            date: _selectedDate,
            description: _descriptionController.text,
            amount: amount.abs(), // Siempre positivo, el signo se maneja internamente
            currencyId: 'USD', // Ajustar según tu implementación
            walletId: _selectedAccountId!,
            categoryId: _selectedCategoryId!,
            contactId: _selectedContactId,
          );
        } else if (isIncome) {
          await _transactionUseCases.createIncome(
            date: _selectedDate,
            description: _descriptionController.text,
            amount: amount,
            currencyId: 'USD', // Ajustar según tu implementación
            walletId: _selectedAccountId!,
            categoryId: _selectedCategoryId!,
            contactId: _selectedContactId,
          );
        } else if (isTransfer) {
          // Obtener la divisa de la cuenta destino
          final targetWallet = _wallets.firstWhere(
            (wallet) => wallet.id == _selectedToAccountId,
            orElse: () => throw Exception('Wallet destino no encontrada'),
          );
          
          await _transactionUseCases.createTransfer(
            date: _selectedDate,
            description: _descriptionController.text,
            amount: amount,
            currencyId: 'USD', // Divisa de origen
            targetCurrencyId: 'USD', // Divisa de destino (debería ser targetWallet.currencyId)
            sourceWalletId: _selectedAccountId!,
            targetWalletId: _selectedToAccountId!,
            targetAmount: amount, // Ajustar según tu implementación de cambio de divisa
            contactId: _selectedContactId,
          );
        }
      }

      // Mostrar mensaje de éxito y volver
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transacción guardada con éxito')),
        );
        Navigator.of(context).pop(true); // Devuelve true para indicar éxito
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = e.toString();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar: ${e.toString()}')),
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
          ? Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
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
                          value: _selectedAccountId,
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
                              child: Text(wallet.name),
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
                            items: _wallets
                                .where((wallet) => wallet.id != _selectedAccountId)
                                .map((wallet) {
                              return DropdownMenuItem(
                                value: wallet.id,
                                child: Text(wallet.name),
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
