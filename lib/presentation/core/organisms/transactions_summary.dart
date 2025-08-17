import 'package:flutter/material.dart';
import '../molecules/transaction_summary_card.dart';

class TransactionsSummary extends StatelessWidget {
  final double totalIncome;
  final double totalExpense;
  final double totalTransfer;

  const TransactionsSummary({
    Key? key,
    required this.totalIncome,
    required this.totalExpense,
    required this.totalTransfer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> summaryWidgets = [];

    if (totalIncome > 0) {
      summaryWidgets.add(
        Expanded(
          child: TransactionSummaryCard(
            title: 'Income',
            icon: Icons.trending_up,
            amount: totalIncome,
            backgroundColor: const Color(0xFF22C55E), // green-500
          ),
        ),
      );
    }

    if (totalExpense > 0) {
      if (summaryWidgets.isNotEmpty) {
        summaryWidgets.add(const SizedBox(width: 12));
      }
      summaryWidgets.add(
        Expanded(
          child: TransactionSummaryCard(
            title: 'Expense',
            icon: Icons.trending_down,
            amount: totalExpense,
            backgroundColor: const Color(0xFFEF4444), // red-500
          ),
        ),
      );
    }

    if (totalTransfer > 0) {
      if (summaryWidgets.isNotEmpty) {
        summaryWidgets.add(const SizedBox(width: 12));
      }
      summaryWidgets.add(
        Expanded(
          child: TransactionSummaryCard(
            title: 'Transfer',
            icon: Icons.swap_horiz,
            amount: totalTransfer,
            backgroundColor: const Color(0xFF3B82F6), // blue-500
          ),
        ),
      );
    }

    if (summaryWidgets.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      children: summaryWidgets,
    );
  }
}
