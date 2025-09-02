import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/loan_entry.dart';
import '../../../core/molecules/info_card.dart';

class LoanPaymentInfoCard extends StatelessWidget {
  final LoanEntry loan;
  final String currencySymbol;

  const LoanPaymentInfoCard({
    Key? key,
    required this.loan,
    this.currencySymbol = '\$',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate payment information
    final monthlyPayment = _calculateMonthlyPayment();
    final nextPaymentDate = _getNextPaymentDate();
    final interestRate = _getInterestRate();
    final termMonths = _getTermMonths();
    final paymentsMade = _getPaymentsMade();

    return InfoCard(
      title: 'Payment Information',
      child: Column(
        children: [
          _buildInfoRow('Monthly Payment', '$currencySymbol${NumberFormat('#,##0.00').format(monthlyPayment)}', isBold: true),
          const SizedBox(height: 16),
          _buildInfoRow('Next Payment', DateFormat('MMMM d, yyyy').format(nextPaymentDate)),
          const SizedBox(height: 16),
          _buildInfoRow('Interest Rate', '${interestRate.toStringAsFixed(1)}% APR'),
          const SizedBox(height: 16),
          _buildInfoRow('Term', '$termMonths months'),
          const SizedBox(height: 16),
          _buildInfoRow('Payments Made', '$paymentsMade of $termMonths'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF64748B), // text-slate-600
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFF111827), // text-slate-900
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Helper methods to calculate/extract payment information
  double _calculateMonthlyPayment() {
    // For now, return a placeholder calculation
    // In a real app, this would be calculated based on loan terms
    return loan.amount * 0.02; // Placeholder: 2% of loan amount
  }

  DateTime _getNextPaymentDate() {
    // Calculate next payment date based on loan start date and payment frequency
    final now = DateTime.now();
    return DateTime(now.year, now.month + 1, 20); // Placeholder: 20th of next month
  }

  double _getInterestRate() {
    // Return interest rate - placeholder for now
    return 4.5; // 4.5% APR
  }

  int _getTermMonths() {
    // Calculate term in months - placeholder
    return 60; // 5 years
  }

  int _getPaymentsMade() {
    // Calculate payments made based on progress
    final originalAmount = loan.amount;
    final remainingAmount = loan.outstandingBalance;
    final paidAmount = originalAmount - remainingAmount;
    final progressPercentage = originalAmount > 0 ? (paidAmount / originalAmount) : 0.0;
    
    return (progressPercentage * _getTermMonths()).round();
  }
}
