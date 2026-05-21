import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entities/transaction_entry.dart';
import '../../../../core/utils/icon_to_emoji_mapper.dart';

import '../../../../domain/entities/category.dart';
import '../../transactions/new_transactions_screen.dart';
import '../../../../core/utils/number_formatter.dart';

class Dashboard2ActivityList extends StatelessWidget {
  final List<TransactionEntry> transactions;
  final double totalExpenses;
  final Map<int, Category> categoriesDataMap;

  const Dashboard2ActivityList({
    super.key,
    required this.transactions,
    required this.totalExpenses,
    required this.categoriesDataMap,
  });

  @override
  Widget build(BuildContext context) {
    // Agrupar gastos por categoría
    final expenses = transactions.where((t) => t.documentTypeId == 'E');
    final Map<String, double> categorySums = {};
    final Map<String, Category?> categoryMap = {};
    
    for (final t in expenses) {
      final cat = t.category ?? (t.mainCategoryId != null ? categoriesDataMap[t.mainCategoryId!] : null);
      final catId = cat?.id.toString() ?? 'otros';
      categorySums[catId] = (categorySums[catId] ?? 0) + t.amount.abs();
      categoryMap[catId] = cat;
    }

    final sortedCategories = categorySums.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Gastos por categoría",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF131B2E),
                fontFamily: 'Manrope',
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NewTransactionsScreen()),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF004AC6),
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Manrope',
                ),
              ),
              child: const Text("Ver todo"),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (sortedCategories.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Text(
                "No hay gastos recientes",
                style: TextStyle(
                  color: Color(0xFF737686),
                  fontFamily: 'Manrope',
                  fontSize: 14,
                ),
              ),
            ),
          )
        else
          ...sortedCategories.take(5).map((entry) {
            final catId = entry.key;
            final sum = entry.value;
            final category = categoryMap[catId];

            double progress = 0.0;
            if (totalExpenses > 0) {
              progress = (sum / totalExpenses).clamp(0.0, 1.0);
            }

            // Asignar color consistente
            final hash = catId.hashCode;
            final colors = [
              const Color(0xFF004AC6), // blue
              const Color(0xFF6CF8BB), // green
              const Color(0xFFFFB95F), // orange
              const Color(0xFFBA1A1A), // red
            ];
            final progressColor = colors[hash % colors.length];

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildActivityItem(
                title: category?.name ?? 'Otros',
                category: "${(progress * 100).toInt()}% del total",
                date: "", // Ya no mostramos la fecha porque es un agrupado
                amount: -sum,
                emoji: (category != null && category.icon.isNotEmpty) 
                    ? IconToEmojiMapper.getEmoji(category.icon) 
                    : '🏷️',
                progress: progress,
                progressColor: progressColor,
              ),
            );
          }),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0 && now.day == date.day) {
      return "Hoy";
    } else if (difference.inDays == 1 || (difference.inDays == 0 && now.day != date.day)) {
      return "Ayer";
    } else {
      return DateFormat('dd MMM').format(date);
    }
  }

  Widget _buildActivityItem({
    required String title,
    required String category,
    required String date,
    required double amount,
    required String emoji,
    required double progress,
    required Color progressColor,
  }) {
    final isIncome = amount > 0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12), // rounded-xl
      child: Container(
        color: progress > 0 ? progressColor.withValues(alpha: 0.05) : const Color(0xFFFFFFFF).withValues(alpha: 0.5),
        child: Stack(
          children: [
            if (progress > 0)
              Positioned.fill(
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(color: progressColor.withValues(alpha: 0.15)),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F3FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(emoji, style: const TextStyle(fontSize: 24)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF131B2E),
                            fontFamily: 'Manrope',
                          ),
                        ),
                        Text(
                          date.isEmpty ? category : "$category • $date",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0x80434655), // on-surface-variant/50
                            fontFamily: 'Manrope',
                          ),
                        ),
                      ],
                    ),
                  ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${isIncome ? '+' : ''}${NumberFormatter.formatCurrency(amount.abs())}",
                            style: TextStyle(
                              fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isIncome ? const Color(0xFF00714D) : const Color(0xFF131B2E),
                          fontFamily: 'Manrope',
                        ),
                      ),
                      if (progress > 0)
                        Text(
                          "(${(progress * 100).toInt()}%)",
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF434655), // on-surface-variant
                            fontFamily: 'Manrope',
                          ),
                        ),
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
}
