import 'package:flutter/material.dart';

/// Widget de resumen de balance basado en dashboard_main.html
/// 
/// HTML Reference:
/// ```html
/// <div class="bg-gradient-to-r from-blue-600 to-blue-700 rounded-2xl p-6 text-white mt-4">
///   <div class="flex items-center justify-between mb-4">
///     <div>
///       <p class="text-blue-100 text-sm">Total Balance</p>
///       <p class="text-3xl font-bold">$24,567.80</p>
///     </div>
///   </div>
/// </div>
/// ```
class BalanceSummaryWidget extends StatelessWidget {
  const BalanceSummaryWidget({
    Key? key,
    required this.totalBalance,
    required this.income,
    required this.expenses,
    this.isBalanceVisible = true,
    this.onVisibilityToggle,
  }) : super(key: key);

  final double totalBalance;
  final double income;
  final double expenses;
  final bool isBalanceVisible;
  final VoidCallback? onVisibilityToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16), // HTML: mx-4
      padding: const EdgeInsets.all(24), // HTML: p-6
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF2563EB), // HTML: from-blue-600
            Color(0xFF1D4ED8), // HTML: to-blue-700
          ],
        ),
        borderRadius: BorderRadius.circular(16), // HTML: rounded-2xl
      ),
      child: Column(
        children: [
          // Header with balance and visibility toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Balance',
                      style: const TextStyle(
                        fontSize: 14, // HTML: text-sm
                        color: Color(0xFFBFDBFE), // HTML: text-blue-100
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isBalanceVisible 
                          ? '\$${_formatAmount(totalBalance)}'
                          : '••••••',
                      style: const TextStyle(
                        fontSize: 32, // HTML: text-3xl
                        fontWeight: FontWeight.bold, // HTML: font-bold
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Icon and visibility toggle
              Row(
                children: [
                  Container(
                    width: 48, // HTML: h-12 w-12
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2), // HTML: bg-white/20
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet,
                      color: Colors.white,
                      size: 24, // HTML: text-2xl
                    ),
                  ),
                  
                  if (onVisibilityToggle != null) ...[
                    const SizedBox(width: 8),
                    Material(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        onTap: onVisibilityToggle,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
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
          
          const SizedBox(height: 24), // HTML: mb-4
          
          // Income and Expenses grid
          Row(
            children: [
              // Income
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'INCOME',
                      style: const TextStyle(
                        fontSize: 12, // HTML: text-xs
                        color: Color(0xFFBFDBFE), // HTML: text-blue-200
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5, // HTML: uppercase tracking-wide
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isBalanceVisible 
                          ? '+\$${_formatAmount(income)}'
                          : '••••••',
                      style: const TextStyle(
                        fontSize: 18, // HTML: text-lg
                        fontWeight: FontWeight.w600, // HTML: font-semibold
                        color: Color(0xFF86EFAC), // HTML: text-green-300
                      ),
                    ),
                  ],
                ),
              ),
              
              // Expenses
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EXPENSES',
                      style: const TextStyle(
                        fontSize: 12, // HTML: text-xs
                        color: Color(0xFFBFDBFE), // HTML: text-blue-200
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5, // HTML: uppercase tracking-wide
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isBalanceVisible 
                          ? '-\$${_formatAmount(expenses)}'
                          : '••••••',
                      style: const TextStyle(
                        fontSize: 18, // HTML: text-lg
                        fontWeight: FontWeight.w600, // HTML: font-semibold
                        color: Color(0xFFFCA5A5), // HTML: text-red-300
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

  /// Formatea montos con comas para miles
  String _formatAmount(double amount) {
    return amount.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
