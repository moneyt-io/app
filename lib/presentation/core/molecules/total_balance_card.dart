import 'package:flutter/material.dart';
import '../../../core/utils/number_formatter.dart';
import '../l10n/generated/strings.g.dart';

/// Card de balance total con gradiente basado en wallet_list.html
/// 
/// HTML Reference:
/// ```html
/// <div class="bg-gradient-to-r from-blue-600 to-purple-600 mx-4 mt-4 rounded-2xl p-6 text-white">
///   <div class="flex items-center justify-between mb-2">
///     <h2 class="text-white/80 text-sm font-medium">Total Balance</h2>
///     <button class="flex items-center justify-center h-8 w-8 rounded-full bg-white/20 hover:bg-white/30">
///       <span class="material-symbols-outlined text-lg">visibility</span>
///     </button>
///   </div>
/// ```
class TotalBalanceCard extends StatelessWidget {
  const TotalBalanceCard({
    Key? key,
    required this.totalBalance,
    required this.monthlyGrowth,
    required this.currencyId,
    this.isBalanceVisible = true,
    this.onVisibilityToggle,
  }) : super(key: key);

  final double totalBalance;
  final double monthlyGrowth;
  final String currencyId;
  final bool isBalanceVisible;
  final VoidCallback? onVisibilityToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0), // HTML: mx-4 mt-4
      padding: const EdgeInsets.all(24), // HTML: p-6
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF2563EB), // HTML: from-blue-600
            Color(0xFF9333EA), // HTML: to-purple-600
          ],
        ),
        borderRadius: BorderRadius.circular(16), // HTML: rounded-2xl
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.dashboard.balance.total,
                style: TextStyle(
                  fontSize: 14, // HTML: text-sm
                  fontWeight: FontWeight.w500, // HTML: font-medium
                  color: Colors.white.withOpacity(0.8), // HTML: text-white/80
                ),
              ),
              if (onVisibilityToggle != null)
                Material(
                  color: Colors.white.withOpacity(0.2), // HTML: bg-white/20
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: onVisibilityToggle,
                    borderRadius: BorderRadius.circular(16),
                    splashColor: Colors.white.withOpacity(0.3), // HTML: hover:bg-white/30
                    child: Container(
                      width: 32, // HTML: h-8 w-8
                      height: 32,
                      child: Icon(
                        isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                        size: 18, // HTML: text-lg
                      ),
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: 8), // HTML: mb-2
          
          // Balance amount
          Text(
            isBalanceVisible
                ? NumberFormatter.formatCurrencyWithCode(totalBalance, currencyId: currencyId)
                : '••••••',
            style: const TextStyle(
              fontSize: 30, // HTML: text-3xl
              fontWeight: FontWeight.bold, // HTML: font-bold
              color: Colors.white,
              height: 1.1, // HTML: mb-1
            ),
          ),
          
          const SizedBox(height: 4),
          
          // Growth indicator
          Text(
            _formatGrowthText(),
            style: TextStyle(
              fontSize: 14, // HTML: text-sm
              color: Colors.white.withOpacity(0.8), // HTML: text-white/80
            ),
          ),
        ],
      ),
    );
  }

  String _formatGrowthText() {
    final prefix = monthlyGrowth >= 0 ? '+' : '';
    return '$prefix${NumberFormatter.formatCurrencyWithCode(monthlyGrowth.abs(), currencyId: currencyId)} ${t.dashboard.balance.thisMonth}';
  }
}
