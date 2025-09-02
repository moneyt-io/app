import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/loan_entry.dart';

class LoanProgressCard extends StatelessWidget {
  final LoanEntry loan;
  final String currencySymbol;

  const LoanProgressCard({
    Key? key,
    required this.loan,
    this.currencySymbol = '\$',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final remainingAmount = loan.outstandingBalance;
    final originalAmount = loan.amount;
    final paidAmount = originalAmount - remainingAmount;
    final progressPercentage = originalAmount > 0 ? (paidAmount / originalAmount) * 100 : 0.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Loan Progress',
                style: TextStyle(
                  color: Color(0xFF374151), // text-slate-700
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${progressPercentage.toStringAsFixed(1)}%',
                style: const TextStyle(
                  color: Color(0xFF111827), // text-slate-900
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Progress Bar
          Container(
            width: double.infinity,
            height: 12,
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8F0), // bg-slate-200
              borderRadius: BorderRadius.circular(6),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progressPercentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF22C55E), Color(0xFF16A34A)], // green-500 to green-600
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Amount Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$currencySymbol${NumberFormat('#,##0').format(paidAmount)} paid',
                style: const TextStyle(
                  color: Color(0xFF64748B), // text-slate-500
                  fontSize: 12,
                ),
              ),
              Text(
                '$currencySymbol${NumberFormat('#,##0').format(remainingAmount)} remaining',
                style: const TextStyle(
                  color: Color(0xFF64748B), // text-slate-500
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
