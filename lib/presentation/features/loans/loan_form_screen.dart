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

class LoanFormScreen extends StatefulWidget {
  final LoanEntry? loan;

  const LoanFormScreen({
    super.key,
    this.loan,
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
  Wallet? _selectedWallet;
  DateTime _selectedDate = DateTime.now();
  DateTime? _selectedDueDate;
  String _selectedCurrency = 'USD';
  bool _createTransaction = true;
  Category? _selectedCategory;

  List<Contact> _contacts = [];
  List<Wallet> _wallets = [];
  List<Category> _categories = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _initializeForm();
  }

  void _initializeForm() {
    if (widget.loan != null) {
      final loan = widget.loan!;
      _documentType = loan.documentTypeId;
      _amountController.text = loan.amount.toString();
      _descriptionController.text = loan.description ?? '';
      _selectedDate = loan.date;
      _selectedCurrency = loan.currencyId;
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

      setState(() {
        _contacts = results[0] as List<Contact>;
        _wallets = results[1] as List<Wallet>;
        _categories = results[2] as List<Category>;
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

        // Wallet Selector
        AppFloatingLabelSelector(
          label: 'Wallet',
          icon: Icons.account_balance_wallet_outlined,
          value: _selectedWallet?.name ?? 'Select wallet',
          onTap: _selectWallet,
          hasValue: _selectedWallet != null,
          iconColor: const Color(0xFF2563EB), // blue-600
          iconBackgroundColor: const Color(0xFFDBEAFE), // blue-100
        ),
        const SizedBox(height: 24),

        // Description
        AppFloatingLabelField(
          controller: _descriptionController,
          label: 'Description',
          placeholder: 'Add loan notes or reason',
          maxLines: 3,
          textInputAction: TextInputAction.newline,
        ),
        const SizedBox(height: 24),

        // Create Transaction Toggle
        _buildTransactionSection(),
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
              ? (type == 'L' ? const Color(0xFFFED7AA) : const Color(0xFFE9D5FF))
              : const Color(0xFFF1F5F9),
          border: Border.all(
            color: isSelected 
                ? (type == 'L' ? const Color(0xFFFDBA74) : const Color(0xFFDDD6FE))
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
                  ? (type == 'L' ? const Color(0xFFEA580C) : const Color(0xFF9333EA))
                  : const Color(0xFF64748B),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected 
                    ? (type == 'L' ? const Color(0xFFEA580C) : const Color(0xFF9333EA))
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

  Widget _buildTransactionSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF), // bg-blue-50
        border: Border.all(color: const Color(0xFFBFDBFE)), // border-blue-200
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
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
                  Text(
                    'Record this loan as a transaction',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF2563EB), // text-blue-600
                    ),
                  ),
                ],
              ),
              Switch(
                value: _createTransaction,
                onChanged: (value) => setState(() => _createTransaction = value),
                activeColor: const Color(0xFF2563EB),
              ),
            ],
          ),
          if (_createTransaction) ...[
            const SizedBox(height: 16),
            AppFloatingLabelSelector(
              label: 'Transaction category',
              icon: _documentType == 'L' ? Icons.call_made : Icons.call_received,
              value: _selectedCategory?.name ?? 'Select category',
              onTap: _selectCategory,
              hasValue: _selectedCategory != null,
              iconColor: _documentType == 'L' 
                  ? const Color(0xFFEA580C) 
                  : const Color(0xFF9333EA),
              iconBackgroundColor: _documentType == 'L' 
                  ? const Color(0xFFFED7AA) 
                  : const Color(0xFFE9D5FF),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _selectDate({required bool isLoanDate}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isLoanDate ? _selectedDate : (_selectedDueDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
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

  Future<void> _selectWallet() async {
    // Simple wallet selection - could be enhanced with a proper dialog
    if (_wallets.isEmpty) return;
    
    await showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Wallet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            ..._wallets.map((wallet) => ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: Text(wallet.name),
              subtitle: Text(wallet.description ?? 'No description'),
              onTap: () {
                setState(() => _selectedWallet = wallet);
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
    );
  }

  Future<void> _selectCategory() async {
    final selectableCategories = _categories
        .where((c) => 
            (_documentType == 'L' && c.documentTypeId == 'I') ||
            (_documentType == 'B' && c.documentTypeId == 'E'))
        .map((c) {
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

    if (_selectedWallet == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a wallet')),
      );
      return;
    }

    final amount = double.parse(_amountController.text);
    final description = _descriptionController.text.isEmpty 
        ? null 
        : _descriptionController.text;

    setState(() => _isLoading = true);

    try {
      final loanProvider = Provider.of<LoanProvider>(context, listen: false);
      
      final loan = await loanProvider.createLoan(
        documentTypeId: _documentType,
        contactId: _selectedContact!.id,
        amount: amount,
        currencyId: _selectedCurrency,
        date: _selectedDate,
        description: description,
      );

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
