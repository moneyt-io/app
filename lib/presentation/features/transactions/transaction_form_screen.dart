import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../domain/entities/transaction.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/entities/credit_card.dart';

import '../../../domain/usecases/wallet_usecases.dart';
import '../../../domain/usecases/category_usecases.dart';
import '../../../domain/usecases/contact_usecases.dart';
import '../../../domain/usecases/transaction_usecases.dart';
import '../../../domain/usecases/credit_card_usecases.dart';

import '../../core/atoms/app_button.dart';
import '../../core/molecules/form_field_container.dart';
import '../../core/molecules/error_message_card.dart';
import '../../core/organisms/account_selector_modal.dart';

import '../../core/theme/app_dimensions.dart';

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
  
  int? _selectedCategoryId;
  int? _selectedContactId;
  
  bool _isLoading = true;
  String? _error;
  
  // Datos reales
  List<Wallet> _wallets = [];
  List<Category> _categories = [];
  List<Contact> _contacts = [];
  List<CreditCard> _creditCards = [];
  Map<int, SelectableAccount> _accountsMap = {}; // Para mapear IDs a cuentas seleccionables
  SelectableAccount? _selectedAccount;
  SelectableAccount? _selectedToAccount; // Para transferencias
  
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
      final creditCardResult = await GetIt.instance<CreditCardUseCases>().getAllCreditCards();

      // Crear el mapa de cuentas seleccionables
      final Map<int, SelectableAccount> accountsMap = {};
      
      // Agregar wallets al mapa
      for (final wallet in walletsResult) {
        accountsMap[wallet.id] = SelectableAccount.fromWallet(wallet);
      }
      
      // Agregar tarjetas de crédito al mapa
      for (final card in creditCardResult) {
        accountsMap[-card.id] = SelectableAccount.fromCreditCard(card); // Usamos ID negativo para distinguir
      }

      setState(() {
        _wallets = walletsResult;
        _categories = categoriesResult;
        _contacts = contactsResult;
        _creditCards = creditCardResult;
        _accountsMap = accountsMap;
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
      
      // Asignar la cuenta seleccionada según el tipo y ID
      if (transaction.accountId != null) {
        if (_accountsMap.containsKey(transaction.accountId)) {
          // Es una wallet
          _selectedAccount = _accountsMap[transaction.accountId];
        } else if (_accountsMap.containsKey(-transaction.accountId!)) {
          // Es una tarjeta de crédito
          _selectedAccount = _accountsMap[-transaction.accountId!];
        }
      }
      
      _selectedCategoryId = transaction.categoryId;
      _selectedContactId = transaction.contactId;
      
      // Para transferencias, buscar la cuenta destino usando la referencia
      if (isTransfer && transaction.reference != null) {
        for (final wallet in _wallets) {
          if (wallet.name == transaction.reference) {
            _selectedToAccount = SelectableAccount.fromWallet(wallet);
            break;
          }
        }
      }
    } else {
      _selectedDate = DateTime.now();
      _selectedContactId = null; // Asegurar que el contacto sea nulo por defecto
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

  Future<void> _showAccountSelector({bool isSource = true}) async {
    // Recopilar todas las cuentas disponibles
    List<SelectableAccount> availableAccounts = [];
    
    // Agregar wallets
    for (final wallet in _wallets) {
      availableAccounts.add(SelectableAccount.fromWallet(wallet));
    }
    
    // Agregar tarjetas de crédito solo para gastos (no para ingresos ni transferencias)
    if (isExpense && isSource) {
      for (final card in _creditCards) {
        availableAccounts.add(SelectableAccount.fromCreditCard(card));
      }
    }
    
    // En transferencias, no mostrar la cuenta origen como destino
    if (isTransfer && !isSource && _selectedAccount != null) {
      availableAccounts = availableAccounts.where((acc) => 
        acc.id != _selectedAccount!.id || acc.isCreditCard != _selectedAccount!.isCreditCard
      ).toList();
    }
    
    final result = await AccountSelectorModal.show(
      context: context,
      accounts: availableAccounts,
      title: isSource ? 'Seleccionar cuenta' : 'Seleccionar cuenta destino',
      confirmButtonText: 'Seleccionar',
      initialSelection: isSource ? _selectedAccount : _selectedToAccount,
    );
    
    if (result != null) {
      setState(() {
        if (isSource) {
          _selectedAccount = result;
        } else {
          _selectedToAccount = result;
        }
      });
    }
  }

  void _saveTransaction() async {
    if (!_formKey.currentState!.validate()) return;
    
    // Validaciones adicionales
    if (_selectedAccount == null) {
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

    if (isTransfer && _selectedToAccount == null) {
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

      // Obtener el ID real de la cuenta y el tipo (wallet o tarjeta)
      int paymentId;
      String paymentTypeId;
      
      if (_selectedAccount!.isCreditCard) {
        paymentId = _selectedAccount!.id;
        paymentTypeId = 'C'; // Tarjeta de crédito
      } else {
        paymentId = _selectedAccount!.id;
        paymentTypeId = 'W'; // Wallet normal
      }

      if (isEditing) {
        // Implementar edición si es necesario
      } else {
        // Crear nueva transacción
        if (isExpense) {
          await _transactionUseCases.createExpense(
            date: _selectedDate,
            description: _descriptionController.text,
            amount: amount.abs(),
            currencyId: _selectedAccount!.currencyId,
            paymentId: paymentId,
            paymentTypeId: paymentTypeId,
            categoryId: _selectedCategoryId!,
            contactId: _selectedContactId,
          );
        } else if (isIncome) {
          await _transactionUseCases.createIncome(
            date: _selectedDate,
            description: _descriptionController.text,
            amount: amount,
            currencyId: _selectedAccount!.currencyId,
            walletId: paymentId, // Asumimos que ingresos solo con wallets
            categoryId: _selectedCategoryId!,
            contactId: _selectedContactId,
          );
        } else if (isTransfer) {
          await _transactionUseCases.createTransfer(
            date: _selectedDate,
            description: _descriptionController.text,
            amount: amount,
            currencyId: _selectedAccount!.currencyId,
            sourcePaymentId: paymentId, // ← CORREGIDO: Parámetro faltante
            targetPaymentId: _selectedToAccount!.id, // ← CORREGIDO: Parámetro faltante
            targetPaymentTypeId: 'W', // ← NUEVO: Tipo de pago destino (Wallet)
            targetCurrencyId: _selectedToAccount!.currencyId,
            targetAmount: amount, // Simplificado
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
          tabs: [
            Tab(
              icon: Icon(
                Icons.arrow_downward, 
                color: _selectedType == 'E' ? colorScheme.error : null,
                size: AppDimensions.iconSizeMedium,
              ),
              text: 'GASTO',
            ),
            Tab(
              icon: Icon(
                Icons.arrow_upward, 
                color: _selectedType == 'I' ? colorScheme.primary : null,
                size: AppDimensions.iconSizeMedium,
              ),
              text: 'INGRESO',
            ),
            Tab(
              icon: Icon(
                Icons.swap_horiz, 
                color: _selectedType == 'T' ? colorScheme.tertiary : null,
                size: AppDimensions.iconSizeMedium,
              ),
              text: 'TRANSFERENCIA',
            ),
          ],
          labelColor: _getTabColor(colorScheme),
          indicatorColor: _getTabColor(colorScheme),
          unselectedLabelColor: colorScheme.onSurfaceVariant,
          labelStyle: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
        ) : null,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: TabBarView(
                          controller: _typeTabController,
                          physics: isEditing ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
                          children: List.generate(3, (_) => _buildFormContent(context, colorScheme, textTheme)),
                        ),
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: AppDimensions.spacing16,
          right: AppDimensions.spacing16,
          bottom: MediaQuery.of(context).padding.bottom + AppDimensions.spacing16,
          top: AppDimensions.spacing16,
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
  
  Color _getTabColor(ColorScheme colorScheme) {
    switch (_selectedType) {
      case 'E': return colorScheme.error;
      case 'I': return colorScheme.primary;
      case 'T': return colorScheme.tertiary;
      default: return colorScheme.primary;
    }
  }
  
  Widget _buildFormContent(BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return ListView(
      padding: EdgeInsets.all(AppDimensions.spacing16),
      children: [
        FormFieldContainer(
          child: TextFormField(
            controller: _amountController,
            decoration: FormFieldContainer.getOutlinedDecoration(
              context,
              labelText: 'Monto',
              prefixIcon: Icon(
                Icons.attach_money,
                color: colorScheme.primary,
              ),
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
        SizedBox(height: AppDimensions.spacing16),
        
        FormFieldContainer(
          child: InkWell(
            onTap: _selectDate,
            child: InputDecorator(
              decoration: FormFieldContainer.getOutlinedDecoration(
                context,
                labelText: 'Fecha',
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: colorScheme.primary,
                ),
              ),
              child: Text(
                DateFormat('dd/MM/yyyy').format(_selectedDate),
                style: textTheme.bodyLarge,
              ),
            ),
          ),
        ),
        SizedBox(height: AppDimensions.spacing16),

        FormFieldContainer(
          child: InkWell(
            onTap: () => _showAccountSelector(isSource: true),
            child: InputDecorator(
              decoration: FormFieldContainer.getOutlinedDecoration(
                context,
                labelText: 'Cuenta',
                prefixIcon: Icon(
                  _selectedAccount?.isCreditCard ?? false 
                    ? Icons.credit_card
                    : Icons.account_balance_wallet,
                  color: colorScheme.primary,
                ),
                suffixIcon: Icon(Icons.arrow_drop_down, color: colorScheme.primary),
              ),
              child: _selectedAccount == null 
                ? Text('Seleccione una cuenta', style: textTheme.bodyLarge)
                : Text(
                    _selectedAccount?.name ?? '',
                    style: textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
            ),
          ),
        ),

        if (isTransfer) ...[
          SizedBox(height: AppDimensions.spacing16),
          FormFieldContainer(
            child: InkWell(
              onTap: () => _showAccountSelector(isSource: false),
              child: InputDecorator(
                decoration: FormFieldContainer.getOutlinedDecoration(
                  context,
                  labelText: 'Cuenta destino',
                  prefixIcon: Icon(
                    Icons.account_balance_wallet,
                    color: colorScheme.primary,
                  ),
                  suffixIcon: Icon(Icons.arrow_drop_down, color: colorScheme.primary),
                ),
                child: _selectedToAccount == null 
                  ? Text('Seleccione cuenta destino', style: textTheme.bodyLarge)
                  : Text(
                      _selectedToAccount?.name ?? '',
                      style: textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
            ),
          ),
        ],

        if (!isTransfer) ...[
          SizedBox(height: AppDimensions.spacing16),
          FormFieldContainer(
            child: DropdownButtonFormField<int>(
              value: _selectedCategoryId,
              isExpanded: true,
              alignment: AlignmentDirectional.centerStart,
              hint: Text('Seleccione una categoría'),
              itemHeight: 60,
              decoration: FormFieldContainer.getOutlinedDecoration(
                context,
                labelText: 'Categoría',
                prefixIcon: Icon(
                  Icons.category,
                  color: colorScheme.primary,
                ),
              ),
              items: _categories
                  .where((cat) => cat.documentTypeId == _selectedType)
                  .map((category) {
                return DropdownMenuItem<int>(
                  value: category.id,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    category.name,
                    overflow: TextOverflow.ellipsis,
                  ),
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

        if (!isTransfer) ...[
          SizedBox(height: AppDimensions.spacing16),
          FormFieldContainer(
            child: DropdownButtonFormField<int?>(
              value: _selectedContactId,
              isExpanded: true,
              alignment: AlignmentDirectional.centerStart,
              hint: Text('Seleccione un contacto (opcional)'),
              itemHeight: 60,
              decoration: FormFieldContainer.getOutlinedDecoration(
                context,
                labelText: 'Contacto (opcional)',
                prefixIcon: Icon(
                  Icons.person,
                  color: colorScheme.primary,
                ),
              ),
              items: _contacts.map((contact) {
                return DropdownMenuItem<int?>(
                  value: contact.id,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    contact.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedContactId = value;
                });
              },
            ),
          ),
        ],

        SizedBox(height: AppDimensions.spacing16),
        FormFieldContainer(
          child: TextFormField(
            controller: _descriptionController,
            decoration: FormFieldContainer.getOutlinedDecoration(
              context,
              labelText: 'Descripción (opcional)',
              prefixIcon: Icon(
                Icons.description,
                color: colorScheme.primary,
              ),
            ),
            maxLines: 3,
          ),
        ),
        
        SizedBox(height: AppDimensions.spacing32),
      ],
    );
  }
}
