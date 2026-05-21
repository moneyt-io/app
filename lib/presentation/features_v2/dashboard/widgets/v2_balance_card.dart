import 'package:flutter/material.dart';
import '../../../../core/utils/number_formatter.dart';

class V2BalanceCard extends StatelessWidget {
  final double totalBalance;
  final double income;
  final double expenses;
  final String currencySymbol;

  const V2BalanceCard({
    super.key,
    required this.totalBalance,
    required this.income,
    required this.expenses,
    this.currencySymbol = '\$', // Se mantiene como fallback/compatibilidad, pero usamos NumberFormatter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D0F172A),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Total Balance",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF434655),
              fontFamily: 'Manrope',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            NumberFormatter.formatCurrency(totalBalance),
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              color: Color(0xFF131B2E),
              fontFamily: 'Manrope',
              letterSpacing: -0.02,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildMetricItem(
                  icon: Icons.arrow_downward,
                  iconColor: const Color(0xFF006C49), // Emerald Green
                  label: "Income",
                  amount: NumberFormatter.formatCurrency(income),
                ),
              ),
              Container(
                height: 32,
                width: 1,
                color: const Color(0xFFE2E8F0),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMetricItem(
                  icon: Icons.arrow_upward,
                  iconColor: const Color(0xFFBA1A1A), // Error Red
                  label: "Expenses",
                  amount: NumberFormatter.formatCurrency(expenses),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String amount,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 16),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF64748B),
                fontFamily: 'Manrope',
              ),
            ),
            const SizedBox(height: 2),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF131B2E),
                fontFamily: 'Manrope',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
