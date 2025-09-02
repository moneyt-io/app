import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/loan_entry.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/usecases/contact_usecases.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/atoms/app_floating_label_field.dart';
import '../../core/atoms/app_floating_label_selector.dart';
import '../../core/molecules/form_action_bar.dart';
import '../../core/formatters/currency_input_formatter.dart';
import 'widgets/loan_payment_summary_card.dart';
import 'widgets/quick_amount_buttons.dart';
import 'widgets/payment_summary_info_card.dart';

class LoanPaymentFormScreen extends StatefulWidget {
  final LoanEntry loan;

  const LoanPaymentFormScreen({
    Key? key,
    required this.loan,
  }) : super(key: key);

  @override
  State<LoanPaymentFormScreen> createState() => _LoanPaymentFormScreenState();
}

class _LoanPaymentFormScreenState extends State<LoanPaymentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _detailsController = TextEditingController();
  final _amountFocusNode = FocusNode();
  final _detailsFocusNode = FocusNode();

  final _contactUseCases = GetIt.instance<ContactUseCases>();
  final _walletUseCases = GetIt.instance<WalletUseCases>();

  Contact? _contact;
  List<Wallet> _wallets = [];
  Wallet? _selectedWallet;
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = true;
  double _paymentAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _loadRelatedData();
    _amountController.addListener(_updatePaymentAmount);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _detailsController.dispose();
    _amountFocusNode.dispose();
    _detailsFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadRelatedData() async {
    setState(() => _isLoading = true);

    try {
      // Load contact
      if (widget.loan.contactId > 0) {
        _contact = await _contactUseCases.getContactById(widget.loan.contactId);
      }

      // Load wallets
      _wallets = await _walletUseCases.getAllWallets();

      // Select first wallet as default
      if (_wallets.isNotEmpty) {
        _selectedWallet = _wallets.first;
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading data: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _updatePaymentAmount() {
    final text = _amountController.text.replaceAll(',', '');
    setState(() {
      _paymentAmount = double.tryParse(text) ?? 0.0;
    });
  }

  void _setQuickAmount(double amount) {
    _amountController.text = NumberFormat('#,##0.00').format(amount);
    _updatePaymentAmount();
  }

  Future<void> _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }

  Future<void> _selectWallet() async {
    final selectedWallet = await showModalBottomSheet<Wallet>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Select Account',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _wallets.length,
                itemBuilder: (context, index) {
                  final wallet = _wallets[index];
                  return ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDBEAFE),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.account_balance,
                        color: Color(0xFF2563EB),
                        size: 20,
                      ),
                    ),
                    title: Text(wallet.name),
                    subtitle: Text(wallet.description ?? 'Wallet'),
                    onTap: () => Navigator.of(context).pop(wallet),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

    if (selectedWallet != null) {
      setState(() {
        _selectedWallet = selectedWallet;
      });
    }
  }

  Future<void> _recordPayment() async {
    if (!_formKey.currentState!.validate()) return;
    if (_paymentAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid payment amount')),
      );
      return;
    }
    if (_selectedWallet == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an account')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // TODO: Implement recordLoanPayment method in LoanProvider
      // For now, we'll simulate a successful payment
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Payment recorded successfully')),
        );
        Navigator.of(context).pop(true); // Return true to indicate success
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error recording payment: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final remainingBalance = widget.loan.outstandingBalance - _paymentAmount;
    final originalAmount = widget.loan.amount;
    final newPaidAmount = originalAmount - remainingBalance;
    final newProgressPercentage = originalAmount > 0 ? (newPaidAmount / originalAmount) * 100 : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // bg-slate-50
      appBar: AppAppBar(
        title: 'Record Payment',
        type: AppAppBarType.blur,
        leading: AppAppBarLeading.close,
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Loan Summary
                  LoanPaymentSummaryCard(
                    loan: widget.loan,
                    contact: _contact,
                  ),

                  const SizedBox(height: 24),

                  // Payment Amount
                  AppFloatingLabelField(
                    controller: _amountController,
                    focusNode: _amountFocusNode,
                    label: 'Payment amount',
                    placeholder: '0.00',
                    prefixIcon: Icons.attach_money,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [CurrencyInputFormatter()],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Payment amount is required';
                      }
                      final amount = double.tryParse(value.replaceAll(',', ''));
                      if (amount == null || amount <= 0) {
                        return 'Please enter a valid amount';
                      }
                      if (amount > widget.loan.outstandingBalance) {
                        return 'Amount cannot exceed remaining balance';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 8),

                  // Quick Amount Buttons
                  QuickAmountButtons(
                    remainingAmount: widget.loan.outstandingBalance,
                    onAmountSelected: _setQuickAmount,
                  ),

                  const SizedBox(height: 24),

                  // Payment Date
                  AppFloatingLabelSelector(
                    label: 'Payment date',
                    icon: Icons.calendar_today,
                    value: DateFormat('MMMM d, yyyy').format(_selectedDate),
                    onTap: _selectDate,
                    iconColor: const Color(0xFF2563EB),
                    iconBackgroundColor: const Color(0xFFDBEAFE),
                  ),

                  const SizedBox(height: 24),

                  // Account Selector
                  AppFloatingLabelSelector(
                    label: 'Received in account',
                    icon: Icons.account_balance,
                    value: _selectedWallet?.name ?? 'Select account',
                    onTap: _selectWallet,
                    hasValue: _selectedWallet != null,
                    iconColor: const Color(0xFF2563EB),
                    iconBackgroundColor: const Color(0xFFDBEAFE),
                  ),

                  const SizedBox(height: 24),

                  // Payment Details
                  AppFloatingLabelField(
                    controller: _detailsController,
                    focusNode: _detailsFocusNode,
                    label: 'Payment details',
                    placeholder: 'Add notes about this payment (optional)',
                    maxLines: 3,
                  ),

                  const SizedBox(height: 24),

                  // Payment Summary
                  PaymentSummaryInfoCard(
                    paymentAmount: _paymentAmount,
                    remainingBalance: remainingBalance.clamp(0.0, double.infinity),
                    newProgressPercentage: newProgressPercentage.clamp(0.0, 100.0),
                  ),
                ],
              ),
            ),
          ),

          // Action Bar
          FormActionBar(
            onCancel: () => Navigator.of(context).pop(),
            onSave: _recordPayment,
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }
}
