import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/loan_entry.dart';
import '../../../../domain/usecases/credit_card_usecases.dart';
import '../../../../domain/usecases/wallet_usecases.dart';

class DetailedLoanCard extends StatefulWidget {
  final LoanEntry loan;
  final String currencySymbol;
  final VoidCallback onTap;

  const DetailedLoanCard({
    Key? key,
    required this.loan,
    this.currencySymbol = '\$',
    required this.onTap,
  }) : super(key: key);

  @override
  State<DetailedLoanCard> createState() => _DetailedLoanCardState();
}

class _DetailedLoanCardState extends State<DetailedLoanCard> {
  final _walletUseCases = GetIt.instance<WalletUseCases>();
  final _creditCardUseCases = GetIt.instance<CreditCardUseCases>();
  String _paymentMethodName = '...';

  @override
  void initState() {
    super.initState();
    _loadPaymentMethodName();
  }

  Future<void> _loadPaymentMethodName() async {
    if (widget.loan.details.isEmpty) {
      if (mounted) setState(() => _paymentMethodName = 'N/A');
      return;
    }

    final detail = widget.loan.details.first;
    String name = 'Unknown';

    try {
      if (detail.paymentTypeId == 'W') {
        final wallet = await _walletUseCases.getWalletById(detail.paymentId);
        name = wallet?.name ?? 'Wallet not found';
      } else if (detail.paymentTypeId == 'C') {
        final card = await _creditCardUseCases.getCreditCardById(detail.paymentId);
        name = card?.name ?? 'Card not found';
      }
    } catch (e) {
      name = 'Error';
    }

    if (mounted) {
      setState(() {
        _paymentMethodName = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLent = widget.loan.documentTypeId == 'L';
    final paidAmount = widget.loan.amount - widget.loan.outstandingBalance;
    final progressPercentage =
        widget.loan.amount > 0 ? (paidAmount / widget.loan.amount) : 0.0;
    final dueDate = DateTime(widget.loan.date.year, widget.loan.date.month + 1, widget.loan.date.day);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFE2E8F0), // border-slate-200
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: isLent
                      ? const Color(0xFFFED7AA) // bg-orange-100
                      : const Color(0xFFE9D5FF), // bg-purple-100
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  isLent ? Icons.call_made : Icons.call_received,
                  color: isLent
                      ? const Color(0xFFEA580C) // text-orange-600
                      : const Color(0xFF9333EA), // text-purple-600
                  size: 24,
                ),
              ),

              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Amount Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.loan.description ??
                                (isLent ? 'Loan Given' : 'Loan Received'),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E293B), // text-slate-800
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '${widget.currencySymbol}${NumberFormat('#,##0.00').format(widget.loan.amount)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isLent
                                ? const Color(0xFFEA580C) // text-orange-600
                                : const Color(0xFF9333EA), // text-purple-600
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Wallet and Due Date Row
                    Row(
                      children: [
                        const Icon(
                          Icons.account_balance_wallet,
                          size: 14,
                          color: Color(0xFF64748B), // text-slate-500
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            _paymentMethodName,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF64748B), // text-slate-500
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '•',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF64748B), // text-slate-500
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.schedule,
                          size: 14,
                          color: Color(0xFF64748B), // text-slate-500
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Due: ${DateFormat('MMM dd, yyyy').format(dueDate)}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF64748B), // text-slate-500
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Progress Section
                    Column(
                      children: [
                        // Progress Labels
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Paid: ${widget.currencySymbol}${NumberFormat('#,##0.00').format(paidAmount)}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF475569), // text-slate-600
                              ),
                            ),
                            Text(
                              'Remaining: ${widget.currencySymbol}${NumberFormat('#,##0.00').format(widget.loan.outstandingBalance)}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF475569), // text-slate-600
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        // Progress Bar
                        Container(
                          width: double.infinity,
                          height: 8,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2E8F0), // bg-slate-200
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: progressPercentage.clamp(0.0, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isLent
                                    ? const Color(0xFFF97316) // bg-orange-500
                                    : const Color(0xFF8B5CF6), // bg-purple-500
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Progress Percentage
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${(progressPercentage * 100).round()}% paid',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B), // text-slate-500
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Status and Date Row
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isLent
                                ? const Color(0xFFFED7AA) // bg-orange-100
                                : const Color(0xFFE9D5FF), // bg-purple-100
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            isLent ? 'You Lent' : 'You Borrowed',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isLent
                                  ? const Color(0xFFC2410C) // text-orange-700
                                  : const Color(0xFF7C3AED), // text-purple-700
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('MMM dd, yyyy').format(widget.loan.date),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF9CA3AF), // text-slate-400
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Chevron
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF9CA3AF), // text-slate-400
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
