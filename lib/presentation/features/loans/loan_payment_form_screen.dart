import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/loan_entry.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/usecases/contact_usecases.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../../domain/usecases/credit_card_usecases.dart';
import '../../../domain/usecases/transaction_usecases.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/molecules/date_selection_dialog.dart';
import '../../core/l10n/generated/strings.g.dart';
import '../transactions/widgets/account_selection_dialog.dart';
import '../../core/organisms/account_selector_modal.dart'
    show SelectableAccount;
import './loan_provider.dart';
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
  final _creditCardUseCases = GetIt.instance<CreditCardUseCases>();
  final _transactionUseCases = GetIt.instance<TransactionUseCases>();

  Contact? _contact;
  Map<int, SelectableAccount> _accountsMap = {};
  SelectableAccount? _selectedAccount;
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

      // Load wallets and credit cards
      final wallets = await _walletUseCases.getAllWallets();
      final creditCards = await _creditCardUseCases.getAllCreditCards();

      final accounts = <SelectableAccount>[
        ...wallets.map((w) => SelectableAccount.fromWallet(w)),
        ...creditCards.map((cc) => SelectableAccount.fromCreditCard(cc)),
      ];

      _accountsMap = {for (var acc in accounts) acc.id: acc};

      // --- NEW LOGIC: Select the source account of the loan as default ---
      int? sourceAccountId;
      String? sourceAccountType;

      // 1. Get transactionId and payment type from loan details
      if (widget.loan.details.isNotEmpty) {
        final loanDetail = widget.loan.details.first;
        final transactionId = loanDetail.transactionId;
        final transaction =
            await _transactionUseCases.getTransactionEntityById(transactionId);

        if (transaction != null) {
          sourceAccountId = transaction.accountId;
          sourceAccountType =
              loanDetail.paymentTypeId; // Use type from loan detail
        }
      }

      // 2. Find and select the source account
      if (sourceAccountId != null && sourceAccountType != null) {
        final isCreditCard = sourceAccountType == 'C';
        // Use a try-catch or a loop to avoid type errors with firstWhere's orElse
        try {
          _selectedAccount = accounts.firstWhere(
            (acc) =>
                acc.id == sourceAccountId && acc.isCreditCard == isCreditCard,
          );
        } catch (e) {
          _selectedAccount = null; // Not found
        }
      }

      // Fallback to first account if source is not found or no details exist
      if (_selectedAccount == null && accounts.isNotEmpty) {
        _selectedAccount = accounts.first;
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
    final picked = await DateSelectionDialog.show(
      context: context,
      initialDate: _selectedDate,
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectWallet() async {
    final result = await AccountSelectionDialog.show(
      context,
      accounts: _accountsMap.values.toList(),
      initialSelection: _selectedAccount,
    );
    if (result != null) {
      setState(() => _selectedAccount = result);
    }
  }

  Future<void> _recordPayment() async {
    if (!_formKey.currentState!.validate()) return;
    if (_paymentAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.loans.payment.errorAmount)),
      );
      return;
    }
    if (_selectedAccount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.loans.payment.errorAccount)),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final loanProvider = Provider.of<LoanProvider>(context, listen: false);
      await loanProvider.createLoanPayment(
        loanId: widget.loan.id,
        paymentAmount: _paymentAmount,
        date: _selectedDate, // Correct state variable for date
        description:
            _detailsController.text, // Correct state variable for description
        paymentTypeId: _selectedAccount!.isCreditCard
            ? 'C'
            : 'W', // Determine type from isCreditCard
        paymentId: _selectedAccount!.id,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.loans.payment.success)),
        );
        Navigator.of(context).pop(true); // Return true to indicate success
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(t.loans.payment.error(error: e.toString()))),
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
    final newProgressPercentage =
        originalAmount > 0 ? (newPaidAmount / originalAmount) * 100 : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // bg-slate-50
      appBar: AppAppBar(
        title: t.loans.payment.title,
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
                children: [
                  const SizedBox(height: 16),

                  // Loan Summary
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: LoanPaymentSummaryCard(
                      loan: widget.loan,
                      contact: _contact,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Payment Amount
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppFloatingLabelField(
                      controller: _amountController,
                      focusNode: _amountFocusNode,
                      label: t.loans.payment.amount,
                      placeholder: t.loans.payment.amountPlaceholder,
                      prefixIcon: Icons.attach_money,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [CurrencyInputFormatter()],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return t.loans.payment.amountRequired;
                        }
                        final amount =
                            double.tryParse(value.replaceAll(',', ''));
                        if (amount == null || amount <= 0) {
                          return t.loans.payment.invalidAmount;
                        }
                        if (amount > widget.loan.outstandingBalance) {
                          return t.loans.payment.exceedsBalance;
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Quick Amount Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: QuickAmountButtons(
                      remainingAmount: widget.loan.outstandingBalance,
                      onAmountSelected: _setQuickAmount,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Payment Date
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppFloatingLabelSelector(
                      label: t.loans.payment.date,
                      icon: Icons.calendar_today,
                      value: DateFormat.yMMMMd(TranslationProvider.of(context).flutterLocale.languageCode).format(_selectedDate),
                      onTap: _selectDate,
                      iconColor: const Color(0xFF2563EB),
                      iconBackgroundColor: const Color(0xFFDBEAFE),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Account Selector
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppFloatingLabelSelector(
                      label: t.loans.payment.account,
                      icon: Icons.account_balance,
                      value: _selectedAccount?.name ?? t.loans.payment.selectAccount,
                      onTap: _selectWallet,
                      hasValue: _selectedAccount != null,
                      iconColor: const Color(0xFF2563EB),
                      iconBackgroundColor: const Color(0xFFDBEAFE),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Payment Details
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppFloatingLabelField(
                      controller: _detailsController,
                      focusNode: _detailsFocusNode,
                      label: t.loans.payment.details,
                      placeholder: t.loans.payment.detailsPlaceholder,
                      maxLines: 3,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Payment Summary
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: PaymentSummaryInfoCard(
                      paymentAmount: _paymentAmount,
                      remainingBalance:
                          remainingBalance.clamp(0.0, double.infinity),
                      newProgressPercentage:
                          newProgressPercentage.clamp(0.0, 100.0),
                    ),
                  ),

                  const SizedBox(height: 16),
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
