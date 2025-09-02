import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/loan_entry.dart';
import '../../../core/molecules/info_card.dart';

class LoanDetailsInfoCard extends StatelessWidget {
  final LoanEntry loan;

  const LoanDetailsInfoCard({
    Key? key,
    required this.loan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: 'Loan Details',
      child: Column(
        children: [
          _buildDetailRow('Loan Type', _getLoanType()),
          const SizedBox(height: 12),
          _buildDetailRow('Vehicle', _getVehicleInfo()),
          const SizedBox(height: 12),
          _buildDetailRow('Loan Start', _formatDate(loan.date)),
          const SizedBox(height: 12),
          _buildDetailRow('Maturity Date', _getMaturityDate()),
          const SizedBox(height: 12),
          _buildDetailRow('Account Number', _getAccountNumber()),
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
      return 'Personal Loan';
    } else if (loan.documentTypeId == 'B') {
      return 'Borrowed Loan';
    }
    
    // Try to infer from description
    final description = loan.description?.toLowerCase() ?? '';
    if (description.contains('car') || description.contains('auto') || description.contains('vehicle')) {
      return 'Auto Loan';
    } else if (description.contains('house') || description.contains('home') || description.contains('mortgage')) {
      return 'Mortgage';
    } else if (description.contains('student') || description.contains('education')) {
      return 'Student Loan';
    }
    
    return 'Personal Loan';
  }

  String _getVehicleInfo() {
    // Extract vehicle info from description or return placeholder
    final description = loan.description ?? '';
    if (description.toLowerCase().contains('honda')) {
      return '2022 Honda Civic';
    } else if (description.toLowerCase().contains('toyota')) {
      return '2023 Toyota Camry';
    } else if (description.toLowerCase().contains('car') || description.toLowerCase().contains('auto')) {
      return 'Vehicle Information';
    }
    
    return description.isNotEmpty ? description : 'N/A';
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMMM d, yyyy').format(date);
  }

  String _getMaturityDate() {
    // Calculate maturity date (placeholder: 5 years from start date)
    final maturityDate = loan.date.add(const Duration(days: 365 * 5));
    return DateFormat('MMMM d, yyyy').format(maturityDate);
  }

  String _getAccountNumber() {
    // Generate a masked account number based on loan ID
    final loanIdStr = loan.id.toString();
    final lastFour = loanIdStr.length >= 4 
        ? loanIdStr.substring(loanIdStr.length - 4)
        : loanIdStr.padLeft(4, '0');
    return '****-$lastFour';
  }
}
