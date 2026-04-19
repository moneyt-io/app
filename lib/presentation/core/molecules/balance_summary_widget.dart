import 'package:flutter/material.dart';
import '../../../core/utils/number_formatter.dart';
import '../l10n/generated/strings.g.dart';

class BalanceSummaryWidget extends StatelessWidget {
  const BalanceSummaryWidget({
    Key? key,
    required this.totalBalance,
    required this.income,
    required this.expenses,
    required this.currencyId,
    this.isBalanceVisible = true,
    this.onVisibilityToggle,
  }) : super(key: key);

  final double totalBalance;
  final double income;
  final double expenses;
  final String currencyId;
  final bool isBalanceVisible;
  final VoidCallback? onVisibilityToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.dashboard.balance.total,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFFBFDBFE),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isBalanceVisible
                          ? NumberFormatter.formatCurrencyWithCode(
                              totalBalance, currencyId: currencyId)
                          : '••••••',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  if (onVisibilityToggle != null) ...[
                    const SizedBox(width: 8),
                    Material(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        onTap: onVisibilityToggle,
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(
                            isBalanceVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.dashboard.balance.income,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFBFDBFE),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isBalanceVisible
                          ? '+${NumberFormatter.formatCurrencyWithCode(income, currencyId: currencyId)}'
                          : '••••••',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF86EFAC),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.dashboard.balance.expenses,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFBFDBFE),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isBalanceVisible
                          ? '-${NumberFormatter.formatCurrencyWithCode(expenses, currencyId: currencyId)}'
                          : '••••••',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFCA5A5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
