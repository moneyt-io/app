import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/loan_entry.dart';

class LoanHistoryItemCard extends StatelessWidget {
  final LoanEntry loan;
  final VoidCallback onTap;

  const LoanHistoryItemCard({
    Key? key,
    required this.loan,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2);
    final dateFormat = DateFormat('MMM dd, yyyy');

    final statusDetails = _getStatusDetails(loan.status);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                _buildStatusIcon(statusDetails['icon']!, statusDetails['color']!),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context, currencyFormat),
                      const SizedBox(height: 4),
                      _buildDetails(context, dateFormat),
                      const SizedBox(height: 6),
                      _buildFooter(context, dateFormat, statusDetails),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(IconData icon, Color color) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  Widget _buildHeader(BuildContext context, NumberFormat currencyFormat) {
    final amountColor = loan.isLend ? Colors.orange.shade700 : Colors.purple.shade700;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            loan.description ?? 'Loan',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          currencyFormat.format(loan.amount),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: amountColor),
        ),
      ],
    );
  }

  Widget _buildDetails(BuildContext context, DateFormat dateFormat) {
    return Row(
      children: [
        Icon(Icons.calendar_today, size: 12, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Text(
          'Date: ${dateFormat.format(loan.date)}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade700),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, DateFormat dateFormat, Map<String, dynamic> statusDetails) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: statusDetails['color']!.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            statusDetails['text']!,
            style: TextStyle(color: statusDetails['color']!, fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ),
        const Spacer(),
        Text(
          loan.isLend ? 'Lent' : 'Borrowed',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade500),
        ),
      ],
    );
  }

  Map<String, dynamic> _getStatusDetails(LoanStatus status) {
    switch (status) {
      case LoanStatus.paid:
        return {'icon': Icons.check_circle, 'color': Colors.green.shade600, 'text': 'Completed'};
      case LoanStatus.active:
        return {'icon': Icons.hourglass_empty, 'color': Colors.blue.shade600, 'text': 'Active'};
      case LoanStatus.cancelled:
        return {'icon': Icons.cancel, 'color': Colors.red.shade600, 'text': 'Cancelled'};
      case LoanStatus.writtenOff:
        return {'icon': Icons.archive, 'color': Colors.orange.shade800, 'text': 'Written Off'};
    }
  }
}
