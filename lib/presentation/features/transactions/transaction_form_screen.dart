import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import '../../navigation/app_routes.dart';
import '../../navigation/navigation_service.dart';
import '../../../domain/entities/transaction.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/entities/credit_card.dart';
import '../../../domain/entities/transaction_entry.dart';

import '../../../domain/usecases/wallet_usecases.dart';
import '../../../domain/usecases/category_usecases.dart';
import '../../../domain/usecases/contact_usecases.dart';
import '../../../domain/usecases/credit_card_usecases.dart';

import '../../core/atoms/app_app_bar.dart';

import '../../core/atoms/app_floating_label_field.dart';
import '../../core/molecules/date_selection_dialog.dart';
import '../../core/organisms/account_selector_modal.dart'
    show SelectableAccount;
import '../../core/molecules/form_action_bar.dart';
import '../../core/atoms/app_floating_label_selector.dart';
import 'widgets/transaction_type_toggle.dart';
import 'widgets/account_selection_dialog.dart';
import 'package:collection/collection.dart';
import '../../core/formatters/currency_input_formatter.dart';
import '../categories/widgets/category_selection_dialog.dart' as cat_dialog;
import '../contacts/widgets/contact_selection_dialog.dart' as contact_dialog;
import 'transaction_provider.dart';
import 'transaction_share_screen.dart';
import '../../core/l10n/generated/strings.g.dart';

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

class _TransactionFormScreenState extends State<TransactionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  // Screen state
  late TransactionToggleType _selectedToggleType;
  late String _selectedType;
  late DateTime _selectedDate;

  int? _selectedCategoryId;
  int? _selectedContactId;

  bool _isLoading = true;
  String? _error;

  // Data
  List<Category> _categories = [];
  List<Contact> _contacts = [];
  List<CreditCard> _creditCards = [];
  Map<int, SelectableAccount> _accountsMap = {};
  SelectableAccount? _selectedAccount;
  SelectableAccount? _selectedToAccount;

  // Use cases
  final _walletUseCases = GetIt.instance<WalletUseCases>();
  final _categoryUseCases = GetIt.instance<CategoryUseCases>();
  final _contactUseCases = GetIt.instance<ContactUseCases>();

  // UI Getters
  bool get isTransfer => _selectedType == 'T';
  bool get isExpense => _selectedType == 'E';
  bool get isIncome => _selectedType == 'I';
  bool get isEditing => widget.transaction != null;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting(t.$meta.locale.languageCode, null);

    _selectedType = widget.transaction?.type ??
        (widget.initialType == 'all' ? 'E' : widget.initialType);
    _updateFlowAndToggleType();

    _amountFocusNode.addListener(() => setState(() {}));
    _descriptionFocusNode.addListener(() => setState(() {}));

    _loadData().then((_) {
      _initializeFormData();
      if (!isEditing) {
        // Use a post-frame callback to ensure the UI is built before showing dialogs
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _startInitialSelectionFlow();
        });
      }
    });
  }

  Future<void> _startInitialSelectionFlow() async {
    // 1. Show source account selector.
    await _showAccountSelector(isSource: true);
    if (!mounted || _selectedAccount == null) return;

    // 2. If it's a transfer, show the destination account selector.
    if (isTransfer) {
      await _showAccountSelector(isSource: false);
      if (!mounted || _selectedToAccount == null) return;
    } else {
      // 3. If it's an income/expense, show the category selector.
      await _selectCategory();
      if (!mounted || _selectedCategoryId == null) return;
    }

    // 4. Finally, focus the amount field.
    if (mounted) {
      FocusScope.of(context).requestFocus(_amountFocusNode);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _amountFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  void _updateFlowAndToggleType() {
    switch (_selectedType) {
      case 'I':
        _selectedToggleType = TransactionToggleType.income;
        break;
      case 'T':
        _selectedToggleType = TransactionToggleType.transfer;
        break;
      case 'E':
      default:
        _selectedToggleType = TransactionToggleType.expense;
        break;
    }
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final walletsResult = await _walletUseCases.getAllWallets();
      final categoriesResult = await _categoryUseCases.getAllCategories();
      final contactsResult = await _contactUseCases.getAllContacts();
      final creditCardResult =
          await GetIt.instance<CreditCardUseCases>().getAllCreditCards();

      final Map<int, SelectableAccount> accountsMap = {};
      // TODO: Fetch real balance and account numbers from use cases
      for (final wallet in walletsResult) {
        // Filter out archived wallets, UNLESS it's the wallet of the transaction being edited
        // Note: TransactionEntity uses accountId for the wallet ID
        final isTransactionWallet = widget.transaction?.accountId == wallet.id;
        if (wallet.active || (isEditing && isTransactionWallet)) {
          accountsMap[wallet.id] = SelectableAccount.fromWallet(wallet,
              balance: 0, accountNumber: '1234');
        }
      }
      for (final card in creditCardResult) {
        // The key for credit cards should be unique and not overlap with wallets.
        // Using a negative ID is a common pattern if wallet IDs are always positive.
        accountsMap[-card.id] = SelectableAccount.fromCreditCard(card,
            balance: 0, availableCredit: 0, cardNumber: '5678');
      }

      if (mounted) {
        setState(() {
          _categories = categoriesResult;
          _contacts = contactsResult;
          _creditCards = creditCardResult;
          _accountsMap = accountsMap;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        print('Error loading transaction form data: $e');
        setState(() {
          _error = "Error: ${e.toString()}";
          _isLoading = false;
        });
      }
    }
  }

  void _handleTypeChange(TransactionToggleType newType) {
    setState(() {
      _selectedToggleType = newType;
      switch (newType) {
        case TransactionToggleType.income:
          _selectedType = 'I';
          break;
        case TransactionToggleType.expense:
          _selectedType = 'E';
          break;
        case TransactionToggleType.transfer:
          _selectedType = 'T';
          break;
      }
      _updateFlowAndToggleType();
      if (isTransfer) {
        _selectedCategoryId = null;
      }
    });
  }

  void _initializeFormData() {
    if (isEditing) {
      final t = widget.transaction!;
      _amountController.text = t.amount.abs().toString();
      _descriptionController.text = t.description ?? '';
      _selectedDate = t.transactionDate;
      _selectedCategoryId = t.categoryId;
      _selectedContactId = t.contactId;

      // For expenses, the account could be a wallet or a credit card.
      // We try to find it first as a wallet (positive key) and then as a card (negative key).
      _selectedAccount =
          _accountsMap[t.accountId] ?? _accountsMap[-t.accountId];

      // For transfers, the target account is found by its name in the reference field.
      if (isTransfer && t.reference != null) {
        // Find the wallet ID from the name, then get the SelectableAccount from the map.
        final targetEntry = _accountsMap.entries.firstWhere(
          (entry) =>
              entry.value.name == t.reference && !entry.value.isCreditCard,
          orElse: () => const MapEntry(
              0,
              SelectableAccount(
                  id: 0,
                  name: '',
                  currencyId: '',
                  isCreditCard: false,
                  last4Digits: '')), // Return a dummy entry to avoid null
        );
        if (targetEntry.key != 0) {
          _selectedToAccount = targetEntry.value;
        }
      }
    } else {
      _selectedDate = DateTime.now();
    }
  }

  Future<void> _selectDate() async {
    final picked = await DateSelectionDialog.show(
      context: context,
      initialDate: _selectedDate,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _showAccountSelector({bool isSource = true}) async {
    List<SelectableAccount> accounts = _accountsMap.values.toList();
    if (isTransfer && !isSource && _selectedAccount != null) {
      accounts = accounts
          .where((acc) =>
              acc.id != _selectedAccount!.id ||
              (acc.isCreditCard != _selectedAccount!.isCreditCard))
          .toList();
    }
    final result = await AccountSelectionDialog.show(
      context,
      accounts: accounts,
      initialSelection: isSource ? _selectedAccount : _selectedToAccount,
    );
    if (result != null) {
      setState(() =>
          isSource ? _selectedAccount = result : _selectedToAccount = result);
    }
  }

  Future<void> _selectContact() async {
    final selectableContacts = _contacts.map((c) {
      return contact_dialog.SelectableContact(
        id: c.id.toString(),
        name: c.name,
        avatarUrl: null, // Contact entity doesn't have avatar
      );
    }).toList();

    final currentSelection = _selectedContactId != null
        ? selectableContacts.firstWhereOrNull(
            (sc) => sc.id == _selectedContactId.toString(),
          )
        : null;

    final result = await contact_dialog.ContactSelectionDialog.show(
      context,
      contacts: selectableContacts,
      initialSelection: currentSelection,
    );

    if (result != null) {
      setState(() {
        _selectedContactId = int.tryParse(result.id);
      });
    }
  }

  Future<void> _selectCategory() async {
    if (_categories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No categories loaded. Please check for errors.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }
    // 1. Filter and map domain categories to selectable categories for the dialog
    final selectableCategories = _categories
        .where((c) =>
            (isIncome && c.documentTypeId == 'I') ||
            (!isIncome && c.documentTypeId == 'E'))
        .map((c) {
      final isIncomeCategory = c.documentTypeId == 'I';
      return cat_dialog.SelectableCategory(
        id: c.id.toString(),
        name: c.name,
        parentId: c.parentId?.toString(),
        isIncome: isIncomeCategory,
        icon: isIncomeCategory ? Icons.arrow_upward : Icons.arrow_downward,
        iconColor:
            isIncomeCategory ? Colors.green.shade600 : Colors.red.shade600,
        iconBgColor:
            isIncomeCategory ? Colors.green.shade100 : Colors.red.shade100,
      );
    }).toList();

    final currentSelection = _selectedCategoryId != null
        ? selectableCategories.firstWhere(
            (sc) => sc.id == _selectedCategoryId.toString(),
            orElse: () => selectableCategories.first)
        : null;

    // 2. Show the dialog
    final result = await cat_dialog.CategorySelectionDialog.show(
      context,
      categories: selectableCategories,
      initialSelection: currentSelection,
    );

    // 3. Update state with the result
    if (result != null) {
      setState(() {
        _selectedCategoryId = int.parse(result.id);
      });
    }
  }

  void _saveTransaction() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedAccount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.transactions.form.selectAccount),
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    if (!isTransfer && _selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.transactions.form.selectCategory),
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    if (isTransfer && _selectedToAccount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(t.transactions.form.selectDestination),
            duration: const Duration(seconds: 3)),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      double amount =
          double.tryParse(_amountController.text.replaceAll(',', '')) ?? 0.0;

      if (isTransfer) {
        amount = amount.abs();
      }

      if (isExpense && amount > 0) {
        amount = -amount;
      }

      int paymentId;
      String paymentTypeId;

      if (_selectedAccount!.isCreditCard) {
        paymentId = _selectedAccount!.id;
        paymentTypeId = 'C';
      } else {
        paymentId = _selectedAccount!.id;
        paymentTypeId = 'W';
      }

      if (isEditing) {
        final updatedTransaction = TransactionEntity(
          id: widget.transaction!.id,
          type: _selectedType,
          flow: isIncome ? 'T' : 'F', // To or From
          amount: amount.abs(),
          accountId: paymentId,
          categoryId: _selectedCategoryId,
          contactId: _selectedContactId,
          description: _descriptionController.text,
          transactionDate: _selectedDate,
          createdAt:
              widget.transaction!.createdAt, // Keep original creation date
          updatedAt: DateTime.now(),
          reference: isTransfer ? _selectedToAccount?.name : null,
        );

        await context
            .read<TransactionProvider>()
            .updateTransaction(updatedTransaction);
      } else {
        final transactionProvider = context.read<TransactionProvider>();
        TransactionEntry? newTransaction;

        if (isExpense) {
          newTransaction = await transactionProvider.createExpense(
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
          newTransaction = await transactionProvider.createIncome(
            date: _selectedDate,
            description: _descriptionController.text,
            amount: amount,
            currencyId: _selectedAccount!.currencyId,
            walletId: paymentId,
            categoryId: _selectedCategoryId!,
            contactId: _selectedContactId,
          );
        } else if (isTransfer) {
          newTransaction = await transactionProvider.createTransfer(
            date: _selectedDate,
            description: _descriptionController.text,
            amount: amount,
            currencyId: _selectedAccount!.currencyId,
            sourcePaymentId: paymentId,
            targetPaymentId: _selectedToAccount!.id,
            targetPaymentTypeId: 'W',
            targetCurrencyId: _selectedToAccount!.currencyId,
            targetAmount: amount,
            contactId: _selectedContactId,
          );
        }

        if (mounted && newTransaction != null) {
          final messenger = ScaffoldMessenger.of(context);
          messenger.clearSnackBars();
          messenger.showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 3), // Show for 3 seconds
              content: Text(t.transactions.form.created),
              action: SnackBarAction(
                label: t.transactions.form.share,
                onPressed: () {
                  // Use the global navigation service to avoid using the unmounted context
                  NavigationService.navigateTo(
                    AppRoutes.transactionShare,
                    arguments: newTransaction!,
                  );
                },
              ),
            ),
          );
          Navigator.of(context).pop(); // Go back to the list

          // Force hide after 3 seconds to workaround potential OS/Accessibility overrides 
          // that keep SnackBars with actions visible indefinitely.
          Future.delayed(const Duration(seconds: 3), () {
            try {
              messenger.hideCurrentSnackBar();
            } catch (_) {}
          });
        } else if (mounted) {
          // Fallback in case transaction is null
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
               content: Text(t.transactions.form.saveError),
               duration: const Duration(seconds: 3),
             ),
          );
          Navigator.of(context).pop();
        }
        return;
      }

      // This part will now only be reached for updates
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            content: Text(t.transactions.form.updateSuccess),
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = e.toString();
        });
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
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // slate-50
      appBar: AppAppBar(
        title: isEditing ? t.transactions.form.editTitle : t.transactions.form.newTitle,
        type: AppAppBarType.blur,
        leading: AppAppBarLeading.close,
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : Column(
                  children: [
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: _buildFormContent(),
                      ),
                    ),
                    FormActionBar(
                      onCancel: () => Navigator.of(context).pop(),
                      onSave: _saveTransaction,
                      isLoading: _isLoading,
                    ),
                  ],
                ),
    );
  }

  Widget _buildFormContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Transaction Type
        Text(t.transactions.form.type,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF334155))),
        const SizedBox(height: 8),
        TransactionTypeToggle(
            selectedType: _selectedToggleType,
            onTypeChanged: _handleTypeChange),
        const SizedBox(height: 24),

        // Amount
        AppFloatingLabelField(
          controller: _amountController,
          focusNode: _amountFocusNode, // This was missing
          label: t.transactions.form.amount,
          placeholder: '0.00',
          prefixIcon: Icons.attach_money,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [CurrencyInputFormatter()],
          validator: (value) =>
              (value == null || value.isEmpty) ? t.transactions.form.amountRequired : null,
        ),
        const SizedBox(height: 24),

        // Date
        AppFloatingLabelSelector(
            label: t.transactions.form.date,
            icon: Icons.calendar_today_outlined,
            value: DateFormat.yMMMMd(t.$meta.locale.languageCode).format(_selectedDate),
            onTap: _selectDate,
            iconColor: const Color(0xFF2563EB), // blue-600
            iconBackgroundColor: const Color(0xFFDBEAFE)), // blue-100
        const SizedBox(height: 24),

        // Account
        AppFloatingLabelSelector(
            label: t.transactions.form.account,
            icon: Icons.account_balance_wallet_outlined,
            value: _selectedAccount?.name ?? t.components.accountSelection.selectAccount,
            onTap: () => _showAccountSelector(),
            hasValue: _selectedAccount != null,
            iconColor: const Color(0xFF2563EB), // blue-600
            iconBackgroundColor: const Color(0xFFDBEAFE)), // blue-100

        // To Account (for transfers)
        if (isTransfer) ...[
          const SizedBox(height: 24),
          AppFloatingLabelSelector(
              label: t.transactions.form.toAccount,
              icon: Icons.account_balance_wallet_outlined,
              value: _selectedToAccount?.name ?? t.components.accountSelection.selectAccount,
              onTap: () => _showAccountSelector(isSource: false),
              hasValue: _selectedToAccount != null,
              iconColor: const Color(0xFF2563EB), // blue-600
              iconBackgroundColor: const Color(0xFFDBEAFE)), // blue-100
        ],

        // Category (for income/expense)
        if (!isTransfer) ...[
          const SizedBox(height: 24),
          AppFloatingLabelSelector(
              label: t.transactions.form.category,
              icon: isIncome ? Icons.trending_up : Icons.trending_down,
              value: _selectedCategoryId != null
                  ? _categories
                      .firstWhere((c) => c.id == _selectedCategoryId)
                      .name
                  : t.components.categorySelection.title,
              onTap: _selectCategory,
              hasValue: _selectedCategoryId != null,
              iconColor: isIncome
                  ? const Color(0xFF16A34A)
                  : const Color(0xFFDC2626), // green-600 or red-600
              iconBackgroundColor: isIncome
                  ? const Color(0xFFDCFCE7)
                  : const Color(0xFFFEE2E2)), // green-100 or red-100
        ],

        const SizedBox(height: 24),

        // Contact
        AppFloatingLabelSelector(
            label: t.transactions.form.contactOptional,
            icon: Icons.person_outline,
            value: _selectedContactId != null
                ? _contacts
                        .firstWhereOrNull((c) => c.id == _selectedContactId)
                        ?.name ??
                    t.components.contactSelection.title
                : t.components.contactSelection.title,
            onTap: _selectContact,
            hasValue: _selectedContactId != null,
            iconColor: const Color(0xFF64748B), // slate-500
            iconBackgroundColor: const Color(0xFFF1F5F9)), // slate-100

        const SizedBox(height: 24),

        // Description
        AppFloatingLabelField(
          controller: _descriptionController,
          label: t.transactions.form.description,
          placeholder: t.transactions.form.descriptionOptional,
          maxLines: 3,
          textInputAction: TextInputAction.newline,
        ),
      ],
    );
  }
}
