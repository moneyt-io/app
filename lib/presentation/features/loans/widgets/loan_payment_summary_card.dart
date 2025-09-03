import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/loan_entry.dart';
import '../../../../domain/entities/contact.dart';

class LoanPaymentSummaryCard extends StatelessWidget {
  final LoanEntry loan;
  final Contact? contact;
  final String currencySymbol;

  const LoanPaymentSummaryCard({
    Key? key,
    required this.loan,
    this.contact,
    this.currencySymbol = '\$',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final remainingAmount = loan.outstandingBalance;
    final originalAmount = loan.amount;
    final paidAmount = originalAmount - remainingAmount;
    final progressPercentage = originalAmount > 0 ? (paidAmount / originalAmount) * 100 : 0.0;
    
    // Calculate next due date (placeholder logic)
    final nextDueDate = DateTime.now().add(const Duration(days: 30));
    
    final isLent = loan.documentTypeId == 'L';
    final loanDescription = loan.description ?? 'Loan';
    final contactName = contact?.name ?? 'Unknown Contact';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED), // bg-orange-50
        border: Border.all(color: const Color(0xFFFED7AA)), // border-orange-200
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Header with icon and loan info
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFED7AA), // bg-orange-100
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isLent ? Icons.call_made : Icons.call_received,
                  color: const Color(0xFFEA580C), // text-orange-600
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$loanDescription to $contactName',
                      style: const TextStyle(
                        color: Color(0xFF9A3412), // text-orange-800
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$currencySymbol${NumberFormat('#,##0.00').format(originalAmount)} total',
                      style: const TextStyle(
                        color: Color(0xFFEA580C), // text-orange-600
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Progress info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Paid: $currencySymbol${NumberFormat('#,##0.00').format(paidAmount)}',
                style: const TextStyle(
                  color: Color(0xFFC2410C), // text-orange-700
                  fontSize: 12,
                ),
              ),
              Text(
                'Remaining: $currencySymbol${NumberFormat('#,##0.00').format(remainingAmount)}',
                style: const TextStyle(
                  color: Color(0xFFC2410C), // text-orange-700
                  fontSize: 12,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 4),
          
          // Progress bar
          Container(
            width: double.infinity,
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFFFED7AA), // bg-orange-200
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progressPercentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF97316), // bg-orange-500
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 4),
          
          // Progress percentage and due date
          Text(
            '${progressPercentage.toStringAsFixed(0)}% paid • Due: ${DateFormat('MMM d, yyyy').format(nextDueDate)}',
            style: const TextStyle(
              color: Color(0xFFEA580C), // text-orange-600
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
