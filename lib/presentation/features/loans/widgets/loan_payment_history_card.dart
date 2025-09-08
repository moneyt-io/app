import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/loan_detail.dart';
import '../../../core/molecules/info_card.dart';

class LoanPaymentHistoryCard extends StatelessWidget {
  final List<LoanDetail> payments;

  const LoanPaymentHistoryCard({Key? key, required this.payments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (payments.isEmpty) {
      return const SizedBox.shrink();
    }

    return InfoCard(
      title: 'Payment History',
      child: Column(
        children: payments.map((payment) {
          final isLast = payment == payments.last;
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
            child: _buildPaymentRow(payment),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPaymentRow(LoanDetail payment) {
    final currencyFormat =
        NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2);
    final dateFormat = DateFormat('MMMM d, yyyy');

    return Row(
      children: [
        // Icon
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9), // slate-100
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.receipt_long_outlined,
            color: Color(0xFF64748B), // slate-500
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        // Date and Description
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment on ${dateFormat.format(payment.createdAt)}',
                style: const TextStyle(
                  color: Color(0xFF111827), // slate-900
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Transaction ID: ${payment.transactionId}',
                style: const TextStyle(
                  color: Color(0xFF64748B), // slate-500
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Amount
        Text(
          currencyFormat.format(payment.amount),
          style: const TextStyle(
            color: Color(0xFF16A34A), // green-600
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
