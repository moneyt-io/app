import 'package:flutter/material.dart';
import '../../../../core/utils/number_formatter.dart';
import '../../../core/l10n/generated/strings.g.dart';

class Dashboard2IncomeExpense extends StatelessWidget {
  final double income;
  final double expenses;

  const Dashboard2IncomeExpense({
    super.key,
    required this.income,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFE2F9F0), // green light
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFBBF7E1).withValues(alpha: 0.2)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x05000000),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  t.v2.dashboard.incomeExpense.income,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Color(0x9900714D), // 60% opacity
                    letterSpacing: 2.0, // tracking-widest
                    fontFamily: 'Manrope',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "+${NumberFormatter.formatCurrency(income)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF00714D),
                    fontFamily: 'Manrope',
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1F1), // red light
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFEE2E2).withValues(alpha: 0.2)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x05000000),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  t.v2.dashboard.incomeExpense.expenses,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Color(0x9993000A), // 60% opacity
                    letterSpacing: 2.0,
                    fontFamily: 'Manrope',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "-${NumberFormatter.formatCurrency(expenses)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF93000A),
                    fontFamily: 'Manrope',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
