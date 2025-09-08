import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/loan_entry.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/usecases/contact_usecases.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../../domain/usecases/category_usecases.dart';
import 'loan_provider.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/atoms/app_floating_label_field.dart';
import '../../core/atoms/app_floating_label_selector.dart';
import '../../core/molecules/form_action_bar.dart';
import '../contacts/widgets/contact_selection_dialog.dart' as contact_dialog;
import '../categories/widgets/category_selection_dialog.dart' as cat_dialog;
import '../../core/molecules/date_selection_dialog.dart';
import '../transactions/widgets/account_selection_dialog.dart';
import '../../core/organisms/account_selector_modal.dart'
    show SelectableAccount;

class LoanFormScreen extends StatefulWidget {
  final LoanEntry? loan;
  final String? initialType;
  final Contact? contact;

  const LoanFormScreen({
    super.key,
    this.loan,
    this.initialType,
    this.contact,
  });

  @override
  State<LoanFormScreen> createState() => _LoanFormScreenState();
}

class _LoanFormScreenState extends State<LoanFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountFocusNode = FocusNode();

  String _documentType = 'L'; // L = Lend, B = Borrow
  Contact? _selectedContact;
  SelectableAccount? _selectedAccount;
  DateTime _selectedDate = DateTime.now();
  DateTime? _selectedDueDate;
  String _selectedCurrency = 'USD';
  bool _createTransaction = false;
  Category? _selectedCategory;

  List<Contact> _contacts = [];
  Map<int, SelectableAccount> _accountsMap = {};
  List<Category> _categories = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData().then((_) {
      _initializeForm();
      if (widget.loan == null) {
        // Use a post-frame callback to ensure the UI is built before showing dialogs
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _startInitialSelectionFlow();
          }
        });
      }
    });
  }

  Future<void> _startInitialSelectionFlow() async {
    // 1. Show contact selector only if not pre-selected.
    if (_selectedContact == null) {
      await _selectContact();
      if (!mounted || _selectedContact == null) return;
    }

    // 2. Show account selector.
    await _showAccountSelector();
    if (!mounted || _selectedAccount == null) return;

    // 3. Finally, focus the amount field.
    if (mounted) {
      FocusScope.of(context).requestFocus(_amountFocusNode);
    }
  }

  void _initializeForm() {
    if (widget.initialType != null) {
      _documentType = widget.initialType!;
    }

    if (widget.contact != null) {
      _selectedContact = widget.contact;
    }

    if (widget.loan != null) {
      final loan = widget.loan!;
      _documentType = loan.documentTypeId;
      _amountController.text = loan.amount.toString();
      _descriptionController.text = loan.description ?? '';
      _selectedDate = loan.date;
      _selectedCurrency = loan.currencyId;
      // TODO: Handle editing existing loans with transactions
    }
  }

  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);

    try {
      final contactUseCases = GetIt.instance<ContactUseCases>();
      final walletUseCases = GetIt.instance<WalletUseCases>();
      final categoryUseCases = GetIt.instance<CategoryUseCases>();

      final results = await Future.wait([
        contactUseCases.getAllContacts(),
        walletUseCases.getAllWallets(),
        categoryUseCases.getAllCategories(),
      ]);

      final contacts = results[0] as List<Contact>;
      final wallets = results[1] as List<Wallet>;
      final categories = results[2] as List<Category>;

      final Map<int, SelectableAccount> accountsMap = {};
      for (final wallet in wallets) {
        accountsMap[wallet.id] = SelectableAccount.fromWallet(wallet,
            balance: 0, accountNumber: '1234');
      }

      setState(() {
        _contacts = contacts;
        _accountsMap = accountsMap;
        _categories = categories;
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
    final isEditing = widget.loan != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // bg-slate-50
      appBar: AppAppBar(
        title: isEditing ? 'Edit Loan' : 'New loan',
        type: AppAppBarType.blur,
        leading: AppAppBarLeading.close,
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
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
                  onSave: _handleSubmit,
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
        // Loan Type Toggle
        _buildLoanTypeSection(),
        const SizedBox(height: 24),

        // Amount Field
        AppFloatingLabelField(
          controller: _amountController,
          focusNode: _amountFocusNode,
          label: 'Amount',
          placeholder: '0.00',
          prefixIcon: Icons.attach_money,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Amount is required';
            }
            final amount = double.tryParse(value);
            if (amount == null || amount <= 0) {
              return 'Please enter a valid amount';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),

        // Date Fields
        _buildDateFields(),
        const SizedBox(height: 24),

        // Contact Selector
        AppFloatingLabelSelector(
          label: 'Contact',
          icon: Icons.person_outline,
          value: _selectedContact?.name ?? 'Select contact',
          onTap: _selectContact,
          hasValue: _selectedContact != null,
          iconColor: const Color(0xFF64748B), // slate-500
          iconBackgroundColor: const Color(0xFFF1F5F9), // slate-100
        ),
        const SizedBox(height: 24),

        // Wallet Selector (conditional)
        if (!_createTransaction)
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: AppFloatingLabelSelector(
              label: 'Wallet',
              icon: Icons.account_balance_wallet_outlined,
              value: _selectedAccount?.name ?? 'Select wallet',
              onTap: _showAccountSelector,
              hasValue: _selectedAccount != null,
              iconColor: const Color(0xFF2563EB), // blue-600
              iconBackgroundColor: const Color(0xFFDBEAFE), // blue-100
            ),
          ),

        // Description
        AppFloatingLabelField(
          controller: _descriptionController,
          label: 'Description',
          placeholder: 'Add loan notes or reason',
          maxLines: 3,
          textInputAction: TextInputAction.newline,
        ),
        const SizedBox(height: 24),

        // Create Transaction Section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF), // bg-blue-50
            border:
                Border.all(color: const Color(0xFFBFDBFE)), // border-blue-200
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create transaction',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E40AF), // text-blue-800
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Record this loan as a transaction',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF2563EB), // text-blue-600
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _createTransaction,
                    onChanged: (bool value) {
                      setState(() {
                        _createTransaction = value;
                        if (value) {
                          _selectedAccount = null;
                        } else {
                          _selectedCategory = null;
                        }
                      });
                    },
                  ),
                ],
              ),
              if (_createTransaction) ...[
                const SizedBox(height: 12),
                _buildCategorySelector(),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySelector() {
    bool hasValue = _selectedCategory != null;

    // This is a simplified version of AppFloatingLabelSelector, styled specifically for this context.
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _selectCategory,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: double.infinity,
              height: 48, // h-12 from mockup
              padding: const EdgeInsets.symmetric(
                  horizontal: 12), // px-3 from mockup
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF), // bg-blue-50
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: const Color(0xFF93C5FD)), // border-blue-300
              ),
              child: Row(
                children: [
                  Container(
                    width: 24, // h-6 w-6
                    height: 24,
                    decoration: BoxDecoration(
                      // Colors taken from the 'Loan Given' category in the mockup
                      color: const Color(0xFFFFF7ED), // bg-orange-100
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.call_made, // Icon from mockup
                      color: Color(0xFFC2410C), // text-orange-600
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _selectedCategory?.name ?? 'Select category',
                      style: TextStyle(
                        fontSize: 14, // text-sm
                        fontWeight: FontWeight.w500,
                        color: hasValue
                            ? const Color(0xFF0F172A) // text-slate-900
                            : const Color(
                                0xFF64748B), // text-slate-500 for placeholder
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.expand_more,
                      color: Color(0xFF94A3B8)), // text-slate-400
                ],
              ),
            ),
          ),
        ),
        // Floating Label
        Positioned(
          top: -8,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            color: const Color(0xFFEFF6FF), // Match background to hide border
            child: const Text(
              'Transaction category',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1D4ED8), // text-blue-700
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoanTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Loan type',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF334155), // text-slate-700
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildLoanTypeButton(
                type: 'L',
                label: 'Lend Money',
                icon: Icons.call_made,
                isSelected: _documentType == 'L',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildLoanTypeButton(
                type: 'B',
                label: 'Borrowed Money',
                icon: Icons.call_received,
                isSelected: _documentType == 'B',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoanTypeButton({
    required String type,
    required String label,
    required IconData icon,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => setState(() => _documentType = type),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isSelected
              ? (type == 'L'
                  ? const Color(0xFFFED7AA)
                  : const Color(0xFFE9D5FF))
              : const Color(0xFFF1F5F9),
          border: Border.all(
            color: isSelected
                ? (type == 'L'
                    ? const Color(0xFFFDBA74)
                    : const Color(0xFFDDD6FE))
                : const Color(0xFFE2E8F0),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected
                  ? (type == 'L'
                      ? const Color(0xFFEA580C)
                      : const Color(0xFF9333EA))
                  : const Color(0xFF64748B),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? (type == 'L'
                        ? const Color(0xFFEA580C)
                        : const Color(0xFF9333EA))
                    : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateFields() {
    return Row(
      children: [
        Expanded(
          child: AppFloatingLabelSelector(
            label: 'Loan date',
            icon: Icons.calendar_today_outlined,
            value: DateFormat('MMM dd, yyyy').format(_selectedDate),
            onTap: () => _selectDate(isLoanDate: true),
            iconColor: const Color(0xFF2563EB),
            iconBackgroundColor: const Color(0xFFDBEAFE),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AppFloatingLabelSelector(
            label: 'Due date',
            icon: Icons.schedule_outlined,
            value: _selectedDueDate != null
                ? DateFormat('MMM dd, yyyy').format(_selectedDueDate!)
                : 'Select date',
            onTap: () => _selectDate(isLoanDate: false),
            hasValue: _selectedDueDate != null,
            iconColor: const Color(0xFF2563EB),
            iconBackgroundColor: const Color(0xFFDBEAFE),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate({required bool isLoanDate}) async {
    final picked = await DateSelectionDialog.show(
      context: context,
      initialDate:
          isLoanDate ? _selectedDate : (_selectedDueDate ?? DateTime.now()),
    );
    if (picked != null) {
      setState(() {
        if (isLoanDate) {
          _selectedDate = picked;
        } else {
          _selectedDueDate = picked;
        }
      });
    }
  }

  Future<void> _selectContact() async {
    final selectableContacts = _contacts.map((c) {
      return contact_dialog.SelectableContact(
        id: c.id.toString(),
        name: c.name,
        avatarUrl: null,
      );
    }).toList();

    final currentSelection = _selectedContact != null
        ? selectableContacts.firstWhere(
            (sc) => sc.id == _selectedContact!.id.toString(),
            orElse: () => selectableContacts.first,
          )
        : null;

    final result = await contact_dialog.ContactSelectionDialog.show(
      context,
      contacts: selectableContacts,
      initialSelection: currentSelection,
    );

    if (result != null) {
      setState(() {
        _selectedContact = _contacts.firstWhere(
          (c) => c.id.toString() == result.id,
        );
      });
    }
  }

  Future<void> _showAccountSelector() async {
    final result = await AccountSelectionDialog.show(
      context,
      accounts: _accountsMap.values.toList(),
      initialSelection: _selectedAccount,
    );
    if (result != null) {
      setState(() => _selectedAccount = result);
    }
  }

  Future<void> _selectCategory() async {
    final categoryType = _documentType == 'L' ? 'I' : 'E';
    final selectableCategories =
        _categories.where((c) => c.documentTypeId == categoryType).map((c) {
      return cat_dialog.SelectableCategory(
        id: c.id.toString(),
        name: c.name,
        parentId: c.parentId?.toString(),
        isIncome: c.documentTypeId == 'I',
        icon: _documentType == 'L' ? Icons.call_made : Icons.call_received,
        iconColor: _documentType == 'L'
            ? const Color(0xFFEA580C)
            : const Color(0xFF9333EA),
        iconBgColor: _documentType == 'L'
            ? const Color(0xFFFED7AA)
            : const Color(0xFFE9D5FF),
      );
    }).toList();

    final result = await cat_dialog.CategorySelectionDialog.show(
      context,
      categories: selectableCategories,
      initialSelection: _selectedCategory != null
          ? selectableCategories.firstWhere(
              (sc) => sc.id == _selectedCategory!.id.toString(),
              orElse: () => selectableCategories.first,
            )
          : null,
    );

    if (result != null) {
      setState(() {
        _selectedCategory = _categories.firstWhere(
          (c) => c.id.toString() == result.id,
        );
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedContact == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a contact')),
      );
      return;
    }

    // Validaciones condicionales
    if (_createTransaction) {
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a category')),
        );
        return;
      }
    } else {
      if (_selectedAccount == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a wallet')),
        );
        return;
      }
    }

    final amount = double.parse(_amountController.text);
    final description = _descriptionController.text.isEmpty
        ? null
        : _descriptionController.text;

    setState(() => _isLoading = true);

    try {
      final loanProvider = Provider.of<LoanProvider>(context, listen: false);
      LoanEntry? loan;

      if (_createTransaction) {
        // Crear préstamo desde categoría (tipo 'T')
        loan = await loanProvider.createLoan(
          documentTypeId: _documentType,
          contactId: _selectedContact!.id,
          amount: amount,
          currencyId: _selectedCurrency,
          date: _selectedDate,
          categoryId: _selectedCategory!.id,
          description: description,
        );
      } else {
        // Crear préstamo desde wallet (tipo 'W')
        loan = await loanProvider.createLoanFromWallet(
          documentTypeId: _documentType,
          contactId: _selectedContact!.id,
          amount: amount,
          currencyId: _selectedCurrency,
          date: _selectedDate,
          walletId: _selectedAccount!.id,
          description: description,
        );
      }

      if (loan != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Loan created successfully')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }
}
