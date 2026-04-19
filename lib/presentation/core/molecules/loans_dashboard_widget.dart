import 'package:flutter/material.dart';
import '../../../core/utils/number_formatter.dart';
import '../atoms/widget_card_header.dart';

class LoansDashboardWidget extends StatelessWidget {
  const LoansDashboardWidget({
    Key? key,
    required this.youLent,
    required this.youBorrowed,
    required this.currencyId,
    required this.activeLoansCount,
    required this.onHeaderTap,
    this.isVisible = true,
  }) : super(key: key);

  final double youLent;
  final double youBorrowed;
  final String currencyId;
  final int activeLoansCount;
  final VoidCallback onHeaderTap;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    final netPosition = youLent - youBorrowed;
    final isPositive = netPosition >= 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          WidgetCardHeader(
            icon: Icons.handshake,
            title: 'Loans',
            subtitle: '$activeLoansCount active',
            onTap: onHeaderTap,
            iconColor: const Color(0xFFEA580C),
            iconBackgroundColor: const Color(0xFFFED7AA),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            NumberFormatter.formatCurrencyWithCode(
                                youLent, currencyId: currencyId),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFEA580C),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'You Lent',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            NumberFormatter.formatCurrencyWithCode(
                                youBorrowed, currencyId: currencyId),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7C3AED),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'You Borrowed',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isPositive
                        ? const Color(0xFFF0FDF4)
                        : const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Net Position: ${isPositive ? '+' : ''}${NumberFormatter.formatCurrencyWithCode(netPosition.abs(), currencyId: currencyId)}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isPositive
                              ? const Color(0xFF16A34A)
                              : const Color(0xFFDC2626),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isPositive ? 'You are owed' : 'You owe',
                        style: const TextStyle(
                            fontSize: 12, color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
