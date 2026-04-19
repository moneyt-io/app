import 'package:flutter/material.dart';
import '../molecules/transaction_summary_card.dart';
import '../l10n/generated/strings.g.dart';

class TransactionsSummary extends StatelessWidget {
  final double totalIncome;
  final double totalExpense;
  final double totalTransfer;
  final String currencyId;

  const TransactionsSummary({
    Key? key,
    required this.totalIncome,
    required this.totalExpense,
    required this.totalTransfer,
    this.currencyId = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> summaryWidgets = [];

    if (totalIncome > 0) {
      summaryWidgets.add(
        Expanded(
          child: TransactionSummaryCard(
            title: t.transactions.types.income,
            icon: Icons.trending_up,
            amount: totalIncome,
            backgroundColor: const Color(0xFF22C55E),
            currencyId: currencyId,
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
            title: t.transactions.types.expense,
            icon: Icons.trending_down,
            amount: totalExpense,
            backgroundColor: const Color(0xFFEF4444),
            currencyId: currencyId,
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
            title: t.transactions.types.transfer,
            icon: Icons.swap_horiz,
            amount: totalTransfer,
            backgroundColor: const Color(0xFF3B82F6),
            currencyId: currencyId,
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
