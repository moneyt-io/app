import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoanStatementCard extends StatelessWidget {
  final String loanDescription;
  final double remainingBalance;
  final double originalAmount;
  final double percentPaid;
  final DateTime loanDate;
  final DateTime? dueDate;
  final String contactName;
  final DateTime generationDate;

  const LoanStatementCard({
    Key? key,
    required this.loanDescription,
    required this.remainingBalance,
    required this.originalAmount,
    required this.percentPaid,
    required this.loanDate,
    this.dueDate,
    required this.contactName,
    required this.generationDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'es_PE', symbol: 'S/', decimalDigits: 2);
    final dateFormat = DateFormat('MMM dd, yyyy');
    final generationTimeFormat = DateFormat('MMM dd, yyyy \'at\' hh:mm a');

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE2E8F0)), // slate-200
        borderRadius: BorderRadius.circular(16), // rounded-2xl
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            // Header
            _buildHeader(),

            // Body
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildLoanTitle(),
                  const SizedBox(height: 16),
                  _buildBalanceInfo(currencyFormat),
                  const SizedBox(height: 16),
                  _buildProgressBar(),
                  const SizedBox(height: 24),
                  _buildKeyInfo(dateFormat),
                  const SizedBox(height: 16),
                  _buildGenerationTimestamp(generationTimeFormat),
                ],
              ),
            ),

            // Footer
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE53935), Color(0xFFC62828)], // red-600 to red-700
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.account_balance, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text(
                'MoneyT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Loan Statement',
            style: TextStyle(
              color: Colors.red.shade100,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoanTitle() {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))), // slate-100
      ),
      child: Column(
        children: [
          Text(
            loanDescription,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A), // slate-900
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Personal Loan',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B), // slate-500
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceInfo(NumberFormat currencyFormat) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC), // slate-50
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Text(
            'Remaining Balance',
            style: TextStyle(
              color: Color(0xFF475569), // slate-600
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            currencyFormat.format(remainingBalance),
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xFFEA580C), // orange-600
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'of ${currencyFormat.format(originalAmount)} original',
            style: const TextStyle(
              color: Color(0xFF64748B), // slate-500
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Payment Progress',
              style: TextStyle(
                color: Color(0xFF475569), // slate-600
                fontSize: 14,
              ),
            ),
            Text(
              '${(percentPaid * 100).toStringAsFixed(0)}% Paid',
              style: const TextStyle(
                color: Color(0xFF0F172A), // slate-900
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: percentPaid,
            minHeight: 12, // h-3
            backgroundColor: const Color(0xFFE2E8F0), // slate-200
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF16A34A)), // green-600
          ),
        ),
      ],
    );
  }

  Widget _buildKeyInfo(DateFormat dateFormat) {
    return Column(
      children: [
        _buildInfoRow('Loan Date', dateFormat.format(loanDate)),
        const SizedBox(height: 12),
        _buildInfoRow('Contact', contactName),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF475569), // slate-600
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF0F172A), // slate-900
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

  Widget _buildGenerationTimestamp(DateFormat generationTimeFormat) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFF1F5F9))), // slate-100
      ),
      child: Center(
        child: Text(
          'Generated on ${generationTimeFormat.format(generationDate)}',
          style: const TextStyle(
            color: Color(0xFF94A3B8), // slate-400
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC), // slate-50
        border: Border(top: BorderSide(color: Color(0xFFF1F5F9))), // slate-100
      ),
      child: const Center(
        child: Text(
          'Powered by MoneyT • moneyt.app',
          style: TextStyle(
            color: Color(0xFF64748B), // slate-500
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
