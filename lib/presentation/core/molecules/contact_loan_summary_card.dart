import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/contact.dart';
import '../../../domain/entities/loan_entry.dart';
import '../l10n/generated/strings.g.dart';

class ContactLoanSummaryCard extends StatelessWidget {
  final Contact contact;
  final List<LoanEntry> activeLoans;
  final double netBalance;
  final double totalLent;
  final double totalBorrowed;
  final DateTime generationDate;

  const ContactLoanSummaryCard({
    Key? key,
    required this.contact,
    required this.activeLoans,
    required this.netBalance,
    required this.totalLent,
    required this.totalBorrowed,
    required this.generationDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = TranslationProvider.of(context).flutterLocale.languageCode;
    final currencyFormat =
        NumberFormat.currency(locale: locale, symbol: '\$', decimalDigits: 2);
    final dateFormat = DateFormat.yMMMd(locale);

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
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildContactHeader(),
                  const SizedBox(height: 16),
                  _buildNetBalance(currencyFormat),
                  const SizedBox(height: 16),
                  _buildLoanBreakdown(currencyFormat),
                  const SizedBox(height: 24),
                  _buildActiveLoansList(dateFormat, currencyFormat),
                  const SizedBox(height: 16),
                  _buildGenerationTimestamp(dateFormat),
                ],
              ),
            ),
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
          colors: [
            Color(0xFF475569),
            Color(0xFF334155)
          ], // slate-600 to slate-700
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
            t.loans.share.loanSummary,
            style: TextStyle(
              color: Colors.grey.shade300,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactHeader() {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      decoration: const BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xFFF1F5F9))), // slate-100
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24,
            child: Text(
                contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '?'),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contact.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A), // slate-900
                ),
              ),
              Text(
                t.loans.share.loanSummary,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF64748B), // slate-500
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildNetBalance(NumberFormat currencyFormat) {
    final isOwed = netBalance >= 0;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isOwed
            ? const Color(0xFFFFF7ED)
            : const Color(0xFFF5F3FF), // orange-50 or purple-50
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
           Text(
            t.loans.share.netBalanceLabel,
            style:
                const TextStyle(color: Color(0xFF475569), fontSize: 14), // slate-600
          ),
          const SizedBox(height: 4),
          Text(
            '${isOwed ? "+" : ""}${currencyFormat.format(netBalance)}',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: isOwed
                  ? const Color(0xFFEA580C)
                  : const Color(0xFF9333EA), // orange-600 or purple-600
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isOwed ? t.loans.share.owed : t.loans.share.owe,
            style: const TextStyle(
                color: Color(0xFF64748B), fontSize: 14), // slate-500
          ),
        ],
      ),
    );
  }

  Widget _buildLoanBreakdown(NumberFormat currencyFormat) {
    final lentLoans = activeLoans.where((l) => l.documentTypeId == 'L').length;
    final borrowedLoans =
        activeLoans.where((l) => l.documentTypeId == 'B').length;

    return Row(
      children: [
        Expanded(
            child: _buildBreakdownCard(
                t.loans.share.lentLabel, totalLent, lentLoans, true, currencyFormat)),
        const SizedBox(width: 12),
        Expanded(
            child: _buildBreakdownCard(t.loans.share.borrowedLabel, totalBorrowed,
                borrowedLoans, false, currencyFormat)),
      ],
    );
  }

  Widget _buildBreakdownCard(String title, double amount, int count,
      bool isLent, NumberFormat currencyFormat) {
    final color = isLent
        ? const Color(0xFFEA580C)
        : const Color(0xFF9333EA); // orange-600 or purple-600
    final bgColor = isLent
        ? const Color(0xFFFFF7ED)
        : const Color(0xFFF5F3FF); // orange-100 or purple-100
    final icon = isLent ? Icons.call_made : Icons.call_received;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 4),
              Text(title,
                  style: TextStyle(
                      color: color, fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 4),
          Text(currencyFormat.format(amount),
              style: TextStyle(
                  color: color, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text('$count ${t.loans.share.active}', style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildActiveLoansList(
      DateFormat dateFormat, NumberFormat currencyFormat) {
    if (activeLoans.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.loans.share.activeLoans(n: activeLoans.length),
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF334155)), // slate-700
        ),
        const SizedBox(height: 12),
        ...activeLoans.map(
            (loan) => _buildLoanListItem(loan, dateFormat, currencyFormat)),
      ],
    );
  }

  Widget _buildLoanListItem(
      LoanEntry loan, DateFormat dateFormat, NumberFormat currencyFormat) {
    final isLent = loan.documentTypeId == 'L';
    final color = isLent ? const Color(0xFFEA580C) : const Color(0xFF9333EA);
    final bgColor = isLent ? const Color(0xFFFFF7ED) : const Color(0xFFF5F3FF);
    final icon = isLent ? Icons.call_made : Icons.call_received;
    final percentPaid = (loan.totalPaid / loan.amount * 100).clamp(0, 100);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(loan.description ?? t.loans.share.personalLoan,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1E293B))), // slate-800
                      Text(currencyFormat.format(loan.amount),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: color)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${t.loans.share.dateLabel}: ${dateFormat.format(loan.date)}',
                          style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B))), // slate-500
                      Text('${percentPaid.toStringAsFixed(0)}% ${t.loans.share.paidSuffix}',
                          style: TextStyle(fontSize: 12, color: color)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenerationTimestamp(DateFormat dateFormat) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFF1F5F9))), // slate-100
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              t.loans.share.totalActive(n: activeLoans.length),
              style: const TextStyle(
                  color: Color(0xFF64748B), fontSize: 12), // slate-500
            ),
            const SizedBox(height: 4),
            Text(
              t.loans.share.generated(date: dateFormat.format(generationDate)),
              style: const TextStyle(
                  color: Color(0xFF94A3B8), fontSize: 12), // slate-400
            ),
          ],
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
      child: Center(
        child: Text(
          t.loans.share.poweredBy,
          style: const TextStyle(
            color: Color(0xFF64748B), // slate-500
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
