// lib/presentation/screens/transaction_form.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/account.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../core/l10n/language_manager.dart';
import '../widgets/category_selection_modal.dart';
import '../widgets/account_selection_modal.dart';

class TransactionForm extends StatefulWidget {
  final TransactionEntity? transaction;
  final String type;
  final TransactionUseCases transactionUseCases;
  final GetAccounts getAccounts;
  final GetCategories getCategories;

  const TransactionForm({
    Key? key,
    this.transaction,
    required this.type,
    required this.transactionUseCases,
    required this.getAccounts,
    required this.getCategories,
  }) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _referenceController = TextEditingController();
  final _contactController = TextEditingController();

  late DateTime _selectedDate;
  late String _selectedType;
  late String _flow;
  AccountEntity? _selectedAccount;
  AccountEntity? _selectedToAccount;
  CategoryEntity? _selectedCategory;

  bool get isTransfer => _selectedType == 'T';
  bool get isExpense => _selectedType == 'E';
  bool get isIncome => _selectedType == 'I';

  @override
  void initState() {
    super.initState();
    _selectedType = widget.transaction?.type ?? widget.type;
    _flow = _selectedType == 'I' ? 'I' : 'O';
    _initializeForm();
    
    // Mostrar el modal de categorías al inicio para ingresos y gastos
    if (!isTransfer && widget.transaction == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showCategorySelectionModal(context);
      });
    }
  }

  void _initializeForm() {
    if (widget.transaction != null) {
      _amountController.text = widget.transaction!.amount.toString();
      _descriptionController.text = widget.transaction!.description ?? '';
      _referenceController.text = widget.transaction!.reference ?? '';
      _contactController.text = widget.transaction!.contact ?? '';
      _selectedDate = widget.transaction!.transactionDate;
    } else {
      _selectedDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _referenceController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  CategoryEntity findParentCategory(List<CategoryEntity> categories, CategoryEntity childCategory) {
    final translations = context.watch<LanguageManager>().translations;
    try {
      return categories.firstWhere((c) => c.id == childCategory.parentId);
    } catch (e) {
      return CategoryEntity(
        id: -1,
        name: translations.unknown,
        type: childCategory.type,
        createdAt: DateTime.now(),
        parentId: null,
        description: null,
        status: true,
      );
    }
  }

  void _showAccountSelectionModal(BuildContext context, {bool isToAccount = false}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StreamBuilder<List<AccountEntity>>(
        stream: widget.getAccounts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return AccountSelectionModal(
            accounts: snapshot.data!,
            excludeAccount: isToAccount ? _selectedAccount : null,
            transactionUseCases: widget.transactionUseCases,
            onAccountSelected: (account) {
              setState(() {
                if (isToAccount) {
                  _selectedToAccount = account;
                } else {
                  _selectedAccount = account;
                  // Limpiar la cuenta destino si es la misma que la cuenta origen
                  if (isTransfer && _selectedToAccount == account) {
                    _selectedToAccount = null;
                  }
                }
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildAccountSelector() {
    final colorScheme = Theme.of(context).colorScheme;
    final translations = context.watch<LanguageManager>().translations;

    return StreamBuilder<List<AccountEntity>>(
      stream: widget.getAccounts(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              color: colorScheme.primary,
            ),
          );
        }

        return InkWell(
          onTap: () => _showAccountSelectionModal(context),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: translations.account,
              prefixIcon: Icon(
                Icons.account_balance_rounded,
                color: colorScheme.onSurfaceVariant,
              ),
              suffixIcon: Icon(
                Icons.arrow_drop_down,
                color: colorScheme.onSurfaceVariant,
              ),
              filled: true,
              fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              errorText: _selectedAccount == null ? translations.selectAccount : null,
            ),
            child: Text(
              _selectedAccount?.name ?? '',
              style: TextStyle(
                color: colorScheme.onSurface,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildToAccountSelector() {
    if (!isTransfer) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;
    final translations = context.watch<LanguageManager>().translations;

    return StreamBuilder<List<AccountEntity>>(
      stream: widget.getAccounts(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              color: colorScheme.primary,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: InkWell(
            onTap: () => _showAccountSelectionModal(context, isToAccount: true),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: translations.toAccount,
                prefixIcon: Icon(
                  Icons.account_balance_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: colorScheme.onSurfaceVariant,
                ),
                filled: true,
                fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                errorText: isTransfer && _selectedToAccount == null ? translations.selectAccount : null,
              ),
              child: Text(
                _selectedToAccount?.name ?? '',
                style: TextStyle(
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategorySelector() {
    if (isTransfer) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;
    final translations = context.watch<LanguageManager>().translations;

    return StreamBuilder<List<CategoryEntity>>(
      stream: widget.getCategories(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              color: colorScheme.primary,
            ),
          );
        }

        final categories = snapshot.data!;
        final selectedCategoryName = _selectedCategory != null 
          ? categories
              .where((c) => c.id == _selectedCategory!.parentId)
              .map((parent) => '${parent.name} > ${_selectedCategory!.name}')
              .first
          : '';

        return InkWell(
          onTap: () => _showCategorySelectionModal(context),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: translations.category,
              prefixIcon: Icon(
                Icons.category_rounded,
                color: colorScheme.onSurfaceVariant,
              ),
              suffixIcon: Icon(
                Icons.arrow_drop_down,
                color: colorScheme.onSurfaceVariant,
              ),
              filled: true,
              fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              errorText: _selectedCategory == null ? translations.selectCategory : null,
            ),
            child: Text(
              selectedCategoryName,
              style: TextStyle(
                color: colorScheme.onSurface,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _onSave() async {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);
      
      try {
        if (isTransfer) {
          // Si es una transferencia, usar el método específico para transferencias
          if (_selectedAccount == null || _selectedToAccount == null) {
            throw Exception(context.watch<LanguageManager>().translations.selectAccount);
          }
          
          await widget.transactionUseCases.createTransfer(
            fromAccountId: _selectedAccount!.id,
            toAccountId: _selectedToAccount!.id,
            amount: amount,
            date: _selectedDate,
            description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
            reference: _referenceController.text.isEmpty ? null : _referenceController.text,
            contact: _contactController.text.isEmpty ? null : _contactController.text,
          );
        } else {
          // Si no es una transferencia, crear una transacción normal
          final transaction = TransactionEntity(
            id: widget.transaction?.id,
            type: _selectedType,
            flow: _flow,
            amount: amount,
            accountId: _selectedAccount!.id,
            categoryId: isTransfer ? null : _selectedCategory!.id,
            reference: _referenceController.text.isEmpty ? null : _referenceController.text,
            contact: _contactController.text.isEmpty ? null : _contactController.text,
            description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
            transactionDate: _selectedDate,
            createdAt: widget.transaction?.createdAt ?? DateTime.now(),
            status: true,
          );

          if (widget.transaction == null) {
            await widget.transactionUseCases.createTransaction(transaction);
          } else {
            await widget.transactionUseCases.updateTransaction(transaction);
          }
        }

        if (mounted) {
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: Theme.of(context).colorScheme.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }
  }

  void _showCategorySelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StreamBuilder<List<CategoryEntity>>(
        stream: widget.getCategories(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return CategorySelectionModal(
            categories: snapshot.data!,
            transactionType: _selectedType,
            onCategorySelected: (category) {
              setState(() {
                _selectedCategory = category;
              });
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    String title;
    switch (_selectedType) {
      case 'E':
        title = translations.newExpense;
        break;
      case 'I':
        title = translations.newIncome;
        break;
      case 'T':
        title = translations.newTransfer;
        break;
      default:
        title = translations.newTransaction;
    }

    if (widget.transaction != null) {
      title = translations.editTransaction;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Monto
            Card(
              elevation: 0,
              color: colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translations.amount,
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        labelText: translations.amount,
                        prefixIcon: Icon(
                          Icons.attach_money_rounded,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        filled: true,
                        fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return translations.invalidAmount;
                        }
                        if (double.tryParse(value) == null) {
                          return translations.invalidAmount;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Cuentas y Categoría
            Card(
              elevation: 0,
              color: colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translations.details,
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Categoría (no para transferencias)
                    _buildCategorySelector(),
                    if (!isTransfer) const SizedBox(height: 16),

                    // Cuenta origen
                    _buildAccountSelector(),
                    const SizedBox(height: 16),

                    // Cuenta destino (solo para transferencias)
                    _buildToAccountSelector(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Información adicional
            Card(
              elevation: 0,
              color: colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translations.additionalInformation,
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Fecha
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: translations.date,
                          prefixIcon: Icon(
                            Icons.calendar_today_rounded,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          filled: true,
                          fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          DateFormat('dd/MM/yyyy').format(_selectedDate),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Contacto
                    TextFormField(
                      controller: _contactController,
                      decoration: InputDecoration(
                        labelText: translations.contact,
                        prefixIcon: Icon(
                          Icons.person_rounded,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        filled: true,
                        fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Descripción
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: translations.description,
                        prefixIcon: Icon(
                          Icons.description_rounded,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        filled: true,
                        fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),

                    // Referencia
                    TextFormField(
                      controller: _referenceController,
                      decoration: InputDecoration(
                        labelText: translations.reference,
                        prefixIcon: Icon(
                          Icons.numbers_rounded,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        filled: true,
                        fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Botón guardar
            FilledButton(
              onPressed: _onSave,
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                widget.transaction == null ? translations.create : translations.update,
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}