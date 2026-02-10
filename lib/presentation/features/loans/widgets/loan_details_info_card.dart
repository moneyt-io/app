import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/loan_entry.dart';
import '../../../core/molecules/info_card.dart';
import '../../../core/l10n/generated/strings.g.dart';

class LoanDetailsInfoCard extends StatelessWidget {
  final LoanEntry loan;

  const LoanDetailsInfoCard({
    Key? key,
    required this.loan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: t.loans.detail.info,
      child: Column(
        children: [
          _buildDetailRow(t.loans.detail.type.label, _getLoanType()),
          const SizedBox(height: 12),
          _buildDetailRow(t.loans.detail.startDate, _formatDate(loan.date)),
          const SizedBox(height: 12),
          _buildDetailRow(t.loans.detail.dueDate, _getDueDate()),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF64748B), // text-slate-600
            fontSize: 14,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xFF111827), // text-slate-900
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  String _getLoanType() {
    // Determine loan type based on document type or description
    if (loan.documentTypeId == 'L') {
      return t.loans.detail.type.personal;
    } else if (loan.documentTypeId == 'B') {
      return t.loans.detail.type.borrowed;
    }
    
    // Try to infer from description
    final description = loan.description?.toLowerCase() ?? '';
    if (description.contains('car') || description.contains('auto') || description.contains('vehicle')) {
      return t.loans.detail.type.auto;
    } else if (description.contains('house') || description.contains('home') || description.contains('mortgage')) {
      return t.loans.detail.type.mortgage;
    } else if (description.contains('student') || description.contains('education')) {
      return t.loans.detail.type.student;
    }
    
    return t.loans.detail.type.personal;
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMMM d, yyyy', LocaleSettings.currentLocale.languageCode).format(date);
  }

  String _getDueDate() {
    final dueDate = DateTime(loan.date.year, loan.date.month + 1, loan.date.day);
    return _formatDate(dueDate);
  }
}
