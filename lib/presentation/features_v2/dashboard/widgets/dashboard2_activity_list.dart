import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/services/exchange_rate_service.dart';
import '../../../features/wallets/wallet_provider.dart';
import '../../../../domain/entities/transaction_entry.dart';
import '../../../../core/utils/icon_to_emoji_mapper.dart';
import '../../../core/l10n/generated/strings.g.dart';

import '../../../../domain/entities/category.dart';
import '../../transactions/widgets/v2_category_selection_sheet.dart';
import '../../transactions/new_transactions_screen.dart';
import '../../../../core/utils/number_formatter.dart';
import 'dart:ui';

class Dashboard2ActivityList extends StatelessWidget {
  final List<TransactionEntry> transactions;
  final double totalExpenses;
  final Map<int, Category> categoriesDataMap;
  final String currencyId;
  final WalletProvider walletProvider;
  final bool shouldConvert;

  const Dashboard2ActivityList({
    super.key,
    required this.transactions,
    required this.totalExpenses,
    required this.categoriesDataMap,
    required this.currencyId,
    required this.walletProvider,
    required this.shouldConvert,
  });

  String _getTrueCurrency(TransactionEntry t) {
    if (t.details.isNotEmpty) {
      final detail = t.details.first;
      final walletId = detail.paymentId;
      final wallet = walletProvider.wallets.where((w) => w.id == walletId).firstOrNull;
      if (wallet != null) {
        return wallet.currencyId;
      }
    }
    return t.currencyId;
  }

  @override
  Widget build(BuildContext context) {
    // Agrupar gastos por categoría
    final expenses = transactions.where((t) => t.documentTypeId == 'E');
    final Map<String, double> categorySums = {};
    final Map<String, Category?> categoryMap = {};
    
    final exchangeRateService = GetIt.instance<ExchangeRateService>();
    
    for (final t in expenses) {
      final cat = t.category ?? (t.mainCategoryId != null ? categoriesDataMap[t.mainCategoryId!] : null);
      final catId = cat?.id.toString() ?? 'otros';
      
      final trueCurrency = _getTrueCurrency(t);
      final amt = shouldConvert ? exchangeRateService.convert(t.amount.abs(), trueCurrency, currencyId) : t.amount.abs();
      
      categorySums[catId] = (categorySums[catId] ?? 0) + amt;
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
            Text(
              t.v2.dashboard.activityList.expensesByCategory,
              style: const TextStyle(
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
              child: Text(t.common.viewAll),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (sortedCategories.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Text(
                t.v2.dashboard.activityList.noRecentExpenses,
                style: const TextStyle(
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

            // Asignar color consistente basado en el índice global de la categoría
            final colors = [
              const Color(0xFF004AC6), // Royal Blue
              const Color(0xFF0D9488), // Teal
              const Color(0xFFD97706), // Amber
              const Color(0xFF059669), // Emerald
              const Color(0xFF7C3AED), // Violet
              const Color(0xFFDC2626), // Soft Red
              const Color(0xFF2563EB), // Blue 600
              const Color(0xFFD946EF), // Fuchsia
              const Color(0xFF0F766E), // Dark Teal
              const Color(0xFFEA580C), // Orange
              const Color(0xFF4F46E5), // Indigo
              const Color(0xFFBE123C), // Rose
            ];
            
            int colorIndex = 0;
            if (catId != 'otros') {
              final parsedId = int.tryParse(catId);
              if (parsedId != null) {
                final sortedKeys = categoriesDataMap.keys.toList()..sort();
                final idx = sortedKeys.indexOf(parsedId);
                if (idx != -1) colorIndex = idx;
              }
            }
            
            final progressColor = colors[colorIndex % colors.length];

            // Filtrar las transacciones correspondientes a esta categoría
            final categoryTransactions = expenses.where((t) {
              final tCatId = t.category?.id.toString() ?? (t.mainCategoryId?.toString() ?? 'otros');
              return tCatId == catId;
            }).toList()
              ..sort((a, b) => b.amount.abs().compareTo(a.amount.abs()));

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _InteractiveActivityItem(
                title: category?.name ?? t.v2.dashboard.activityList.others,
                percentageStr: t.v2.dashboard.activityList.percentOfTotal(percent: (progress * 100).toInt()),
                amount: -sum,
                emoji: (category != null && category.icon.isNotEmpty) 
                    ? IconToEmojiMapper.getEmoji(category.icon) 
                    : '🏷️',
                progress: progress,
                progressColor: progressColor,
                topTransactions: categoryTransactions.take(5).toList(),
                currencyId: currencyId,
                walletProvider: walletProvider,
                shouldConvert: shouldConvert,
              ),
            );
          }),
      ],
    );
  }
}

class _InteractiveActivityItem extends StatefulWidget {
  final String title;
  final String percentageStr;
  final double amount;
  final String emoji;
  final double progress;
  final Color progressColor;
  final List<TransactionEntry> topTransactions;
  final String currencyId;
  final WalletProvider walletProvider;
  final bool shouldConvert;

  const _InteractiveActivityItem({
    required this.title,
    required this.percentageStr,
    required this.amount,
    required this.emoji,
    required this.progress,
    required this.progressColor,
    required this.topTransactions,
    required this.currencyId,
    required this.walletProvider,
    required this.shouldConvert,
  });

  String _getTrueCurrency(TransactionEntry t) {
    if (t.details.isNotEmpty) {
      final detail = t.details.first;
      final walletId = detail.paymentId;
      final wallet = walletProvider.wallets.where((w) => w.id == walletId).firstOrNull;
      if (wallet != null) {
        return wallet.currencyId;
      }
    }
    return t.currencyId;
  }

  @override
  State<_InteractiveActivityItem> createState() => _InteractiveActivityItemState();
}

class _InteractiveActivityItemState extends State<_InteractiveActivityItem> with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    // Retraso sutil para garantizar que el usuario aprecie el estado visual "presionado" en toques muy rápidos
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) setState(() => _isPressed = false);
    });
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  void _handleLongPress() {
    HapticFeedback.heavyImpact();
    setState(() => _isPressed = false);
    
    if (widget.topTransactions.isEmpty) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: const Color(0xFFFFFFFF).withValues(alpha: 0.85),
              padding: EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
                bottom: MediaQuery.of(context).padding.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC3C6D7),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: widget.progressColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(widget.emoji, style: const TextStyle(fontSize: 24)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF131B2E),
                                fontFamily: 'Manrope',
                              ),
                            ),
                            Text(
                              t.v2.dashboard.activityList.topExpenses(count: widget.topTransactions.length),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF737686),
                                fontFamily: 'Manrope',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ...widget.topTransactions.map((tx) {
                    final txTitle = tx.description?.isNotEmpty == true
                        ? tx.description!
                        : (tx.contact?.name ?? widget.title);
                    final trueCurrency = widget._getTrueCurrency(tx);
                    final exchangeRateService = GetIt.instance<ExchangeRateService>();
                    final amt = widget.shouldConvert ? exchangeRateService.convert(tx.amount.abs(), trueCurrency, widget.currencyId) : tx.amount.abs();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  txTitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF131B2E),
                                    fontFamily: 'Manrope',
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _formatDate(tx.date),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF737686),
                                    fontFamily: 'Manrope',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            NumberFormatter.formatCurrency(amt, currencyId: widget.currencyId),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFBA1A1A),
                              fontFamily: 'Manrope',
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0 && now.day == date.day) {
      return t.common.today;
    } else if (difference.inDays == 1 || (difference.inDays == 0 && now.day != date.day)) {
      return t.common.yesterday;
    } else {
      return DateFormat('dd MMM').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = widget.amount > 0;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onLongPress: _handleLongPress,
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0, // Más sutil
        duration: const Duration(milliseconds: 100), // Más rápido
        curve: Curves.easeOutCubic,
        child: AnimatedOpacity(
          opacity: _isPressed ? 0.6 : 1.0, // Ligeramente más visible
          duration: const Duration(milliseconds: 100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: widget.progress > 0 
                  ? widget.progressColor.withValues(alpha: 0.05) 
                  : const Color(0xFFFFFFFF).withValues(alpha: 0.5),
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    if (widget.progress > 0)
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: widget.progress,
                          child: Container(color: widget.progressColor.withValues(alpha: 0.15)),
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
                            child: Text(widget.emoji, style: const TextStyle(fontSize: 24)),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
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
                                  widget.percentageStr,
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
                                "${isIncome ? '+' : ''}${NumberFormatter.formatCurrency(widget.amount.abs(), currencyId: widget.currencyId)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: isIncome ? const Color(0xFF00714D) : const Color(0xFF131B2E),
                                  fontFamily: 'Manrope',
                                ),
                              ),
                              if (widget.progress > 0)
                                Text(
                                  "(${(widget.progress * 100).toInt()}%)",
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
            ),
          ),
        ),
      ),
    );
  }
}
