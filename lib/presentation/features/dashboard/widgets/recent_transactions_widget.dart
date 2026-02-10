import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entities/transaction_entry.dart';
import '../../../core/atoms/widget_card_header.dart';
import '../../../navigation/app_routes.dart';
import '../../../navigation/navigation_service.dart';
import '../../transactions/transaction_provider.dart';
import '../../../core/l10n/generated/strings.g.dart';

/// Widget de transacciones recientes para dashboard basado en dashboard_main.html
///
/// HTML Reference:
/// ```html
/// <div class="bg-white rounded-2xl shadow-sm border border-slate-200 widget-card">
///   <div class="flex items-center justify-between p-4 border-b border-slate-100">
/// ```
class RecentTransactionsWidget extends StatelessWidget {

  const RecentTransactionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    final transactions = provider.transactions;
    final categoriesMap = provider.categoriesMap;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16), // HTML: mx-4
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // HTML: rounded-2xl
        border: Border.all(
          color: const Color(0xFFE2E8F0), // HTML: border-slate-200
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000), // HTML: shadow-sm
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          WidgetCardHeader(
            icon: Icons.receipt_long,
            title: t.dashboard.transactions.title,
            subtitle: t.dashboard.transactions.subtitle,
            onTap: () => NavigationService.navigateTo(AppRoutes.transactions),
            iconColor: const Color(0xFF7C3AED), // HTML: text-violet-600
            iconBackgroundColor: const Color(0xFFEDE9FE), // HTML: bg-violet-100
          ),

          // Transactions list
          if (transactions.isEmpty)
            _buildEmptyState()
          else
            Container(
              padding: const EdgeInsets.all(16), // HTML: p-4
              child: Column(
                children: [
                  // First 5 transactions
                  ...transactions
                      .take(5)
                      .map((transaction) =>
                          _buildTransactionItem(transaction, categoriesMap)),

                  // More transactions indicator
                  if (transactions.length > 5) ...[
                    const SizedBox(height: 8), // HTML: pt-2
                    Center(
                      child: Text(
                        t.dashboard.transactions.more(n: transactions.length - 5),
                        style: const TextStyle(
                          fontSize: 12, // HTML: text-xs
                          color: Color(0xFF64748B), // HTML: text-slate-500
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
      TransactionEntry transaction, Map<int, String> categoriesMap) {
    final isIncome = transaction.isIncome;
    final isTransfer = transaction.documentTypeId == 'T';

    final categoryName = transaction.mainCategoryId != null
        ? categoriesMap[transaction.mainCategoryId]
        : null;

    final title = transaction.description?.isNotEmpty == true
        ? transaction.description!
        : (categoryName ?? 'Transaction');

    // Determine colors and icons based on transaction type
    Color iconColor;
    Color iconBackgroundColor;
    IconData icon;

    if (isTransfer) {
      iconColor = const Color(0xFF2563EB); // HTML: text-blue-600
      iconBackgroundColor = const Color(0xFFDBEAFE); // HTML: bg-blue-100
      icon = Icons.swap_horiz;
    } else if (isIncome) {
      iconColor = const Color(0xFF16A34A); // HTML: text-green-600
      iconBackgroundColor = const Color(0xFFDCFCE7); // HTML: bg-green-100
      icon = Icons.trending_up;
    } else {
      iconColor = const Color(0xFFDC2626); // HTML: text-red-600
      iconBackgroundColor = const Color(0xFFFEE2E2); // HTML: bg-red-100
      icon = Icons.trending_down;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12), // HTML: space-y-3
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => NavigationService.navigateTo(
            AppRoutes.transactionDetail,
            arguments: transaction,
          ),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                // Transaction icon
                Container(
                  width: 32, // HTML: h-8 w-8
                  height: 32,
                  decoration: BoxDecoration(
                    color: iconBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 16, // HTML: text-sm
                    color: iconColor,
                  ),
                ),

                const SizedBox(width: 12), // HTML: gap-3

                // Transaction details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14, // HTML: text-sm
                          fontWeight: FontWeight.w500, // HTML: font-medium
                          color: Color(0xFF374151), // HTML: text-slate-700
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        DateFormat.yMMMd().format(transaction.date),
                        style: const TextStyle(
                          fontSize: 12, // HTML: text-xs
                          color: Color(0xFF64748B), // HTML: text-slate-500
                        ),
                      ),
                    ],
                  ),
                ),

                // Amount
                Text(
                  '${isIncome ? '+' : isTransfer ? '' : '-'}\$${_formatAmount(transaction.amount)}',
                  style: const TextStyle(
                    fontSize: 14, // HTML: text-sm
                    fontWeight: FontWeight.bold, // HTML: font-bold
                    color: Color(0xFF0F172A), // HTML: text-slate-900
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFFF1F5F9), // HTML: bg-slate-100
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.receipt_long,
                size: 24,
                color: Color(0xFF64748B), // HTML: text-slate-500
              ),
            ),
            const SizedBox(height: 16),
            Text(
              t.dashboard.transactions.empty,
              style: const TextStyle(
                fontSize: 14, // HTML: text-sm
                fontWeight: FontWeight.w500, // HTML: font-medium
                color: Color(0xFF374151), // HTML: text-slate-700
              ),
            ),
            const SizedBox(height: 4),
            Text(
              t.dashboard.transactions.emptySubtitle,
              style: const TextStyle(
                fontSize: 12, // HTML: text-xs
                color: Color(0xFF64748B), // HTML: text-slate-500
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Formatea montos con comas
  String _formatAmount(double amount) {
    return amount.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
