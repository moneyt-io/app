import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum LoanSummaryType { lent, borrowed }

class LoanSummaryGridCard extends StatelessWidget {
  final LoanSummaryType type;
  final double amount;
  final int activeCount;
  final String currencySymbol;
  final VoidCallback? onTap;

  const LoanSummaryGridCard({
    Key? key,
    required this.type,
    required this.amount,
    required this.activeCount,
    this.currencySymbol = '\$',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLent = type == LoanSummaryType.lent;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isLent 
              ? const Color(0xFFF97316) // bg-orange-500
              : const Color(0xFF8B5CF6), // bg-purple-500
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and label
            Row(
              children: [
                Icon(
                  isLent ? Icons.call_made : Icons.call_received,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  isLent ? 'You Lent' : 'You Borrowed',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Amount
            Text(
              '$currencySymbol${NumberFormat('#,##0.00').format(amount)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            const SizedBox(height: 4),
            
            // Active count
            Text(
              '$activeCount active',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoanSummaryGrid extends StatelessWidget {
  final double lentAmount;
  final double borrowedAmount;
  final int lentActiveCount;
  final int borrowedActiveCount;
  final String currencySymbol;
  final VoidCallback? onLentTap;
  final VoidCallback? onBorrowedTap;

  const LoanSummaryGrid({
    Key? key,
    required this.lentAmount,
    required this.borrowedAmount,
    required this.lentActiveCount,
    required this.borrowedActiveCount,
    this.currencySymbol = '\$',
    this.onLentTap,
    this.onBorrowedTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: LoanSummaryGridCard(
              type: LoanSummaryType.lent,
              amount: lentAmount,
              activeCount: lentActiveCount,
              currencySymbol: currencySymbol,
              onTap: onLentTap,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: LoanSummaryGridCard(
              type: LoanSummaryType.borrowed,
              amount: borrowedAmount,
              activeCount: borrowedActiveCount,
              currencySymbol: currencySymbol,
              onTap: onBorrowedTap,
            ),
          ),
        ],
      ),
    );
  }
}
