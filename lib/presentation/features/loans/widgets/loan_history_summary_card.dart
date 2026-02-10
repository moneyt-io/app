import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/loan_entry.dart';
import '../../../core/l10n/generated/strings.g.dart';

class LoanHistorySummaryCard extends StatefulWidget {
  final List<LoanEntry> loans;

  const LoanHistorySummaryCard({Key? key, required this.loans}) : super(key: key);

  @override
  _LoanHistorySummaryCardState createState() => _LoanHistorySummaryCardState();
}

class _LoanHistorySummaryCardState extends State<LoanHistorySummaryCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final summary = _calculateSummary(widget.loans);
    final currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
      ),
      child: Column(
        children: [
          _buildHeader(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildEssentialSummary(summary, currencyFormat),
                if (_isExpanded) _buildDetailedSummary(summary, currencyFormat),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))), // slate-100
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            t.loans.history.summary.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
          ),
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Row(
              children: [
                Text(
                  _isExpanded ? t.loans.history.summary.hideDetails : t.loans.history.summary.viewDetails,
                  style: const TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 4),
                Icon(_isExpanded ? Icons.expand_less : Icons.expand_more, size: 18, color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEssentialSummary(Map<String, double> summary, NumberFormat format) {
    final netPosition = summary['outstandingLent']! - summary['outstandingBorrowed']!;
    return Column(
      children: [
        _buildStatRow(t.loans.history.summary.outstandingLent, summary['outstandingLent']!, const Color(0xFFEA580C), format),
        const SizedBox(height: 12),
        _buildStatRow(t.loans.history.summary.outstandingBorrowed, summary['outstandingBorrowed']!, const Color(0xFF9333EA), format),
        const SizedBox(height: 16),
        Container(height: 1, color: const Color(0xFFE2E8F0)), // Divider
        const SizedBox(height: 16),
        _buildNetPositionRow(t.loans.history.summary.netPosition, netPosition, format),
      ],
    );
  }

  Widget _buildDetailedSummary(Map<String, double> summary, NumberFormat format) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Container(height: 1, color: const Color(0xFFE2E8F0)), // Divider
          const SizedBox(height: 16),
          _buildStatRow(t.loans.history.summary.totalLent, summary['totalLent']!, const Color(0xFFEA580C), format),
          const SizedBox(height: 12),
          _buildStatRow(t.loans.history.summary.totalBorrowed, summary['totalBorrowed']!, const Color(0xFF9333EA), format),
          const SizedBox(height: 12),
          _buildStatRow(t.loans.history.summary.totalRepaidToYou, summary['totalRepaidToYou']!, const Color(0xFF16A34A), format),
          const SizedBox(height: 12),
          _buildStatRow(t.loans.history.summary.totalYouRepaid, summary['totalYouRepaid']!, const Color(0xFF16A34A), format),
          const SizedBox(height: 16),
          Container(height: 1, color: const Color(0xFFE2E8F0)), // Divider
          const SizedBox(height: 16),
          _buildStatRow(t.loans.history.summary.totalLoans, summary['totalLoans']!, const Color(0xFF0F172A), format, isInt: true),
          const SizedBox(height: 12),
          _buildStatRow(t.loans.history.summary.completedLoans, summary['completedLoans']!, const Color(0xFF16A34A), format, isInt: true),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, double amount, Color amountColor, NumberFormat format, {bool isInt = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Color(0xFF64748B))),
        Text(
          isInt ? amount.toInt().toString() : format.format(amount),
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: amountColor),
        ),
      ],
    );
  }

  Widget _buildNetPositionRow(String label, double amount, NumberFormat format) {
    final isPositive = amount >= 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF374151))),
        Text(
          '${isPositive ? '+' : ''}${format.format(amount)}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isPositive ? const Color(0xFFEA580C) : const Color(0xFF9333EA),
          ),
        ),
      ],
    );
  }

  Map<String, double> _calculateSummary(List<LoanEntry> loans) {
    double totalLent = 0;
    double totalBorrowed = 0;
    double outstandingLent = 0;
    double outstandingBorrowed = 0;
    double totalRepaidToYou = 0;
    double totalYouRepaid = 0;
    int completedLoans = 0;

    for (final loan in loans) {
      if (loan.isLend) {
        totalLent += loan.amount;
        totalRepaidToYou += loan.totalPaid;
        if (loan.status == LoanStatus.active) {
          outstandingLent += loan.outstandingBalance;
        }
      } else {
        totalBorrowed += loan.amount;
        totalYouRepaid += loan.totalPaid;
        if (loan.status == LoanStatus.active) {
          outstandingBorrowed += loan.outstandingBalance;
        }
      }

      if (loan.status == LoanStatus.paid) {
        completedLoans++;
      }
    }

    return {
      'totalLent': totalLent,
      'totalBorrowed': totalBorrowed,
      'outstandingLent': outstandingLent,
      'outstandingBorrowed': outstandingBorrowed,
      'totalRepaidToYou': totalRepaidToYou,
      'totalYouRepaid': totalYouRepaid,
      'totalLoans': loans.length.toDouble(),
      'completedLoans': completedLoans.toDouble(),
    };
  }
}
