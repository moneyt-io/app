import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/recurring_transaction.dart';
import '../../../../domain/enums/recurrence_frequency.dart';
import '../../../../domain/usecases/recurring_transaction_usecases.dart';
import '../../core/l10n/generated/strings.g.dart';
import '../theme/v2_colors.dart';
import '../../../core/utils/number_formatter.dart';
import '../../../core/utils/icon_to_emoji_mapper.dart';
import 'widgets/recurring_transaction_edit_sheet.dart';

/// Full-screen management view for all recurring transaction rules.
/// Completely decoupled from historical transaction entries to preserve financial integrity.
class RecurringTransactionsScreen extends StatefulWidget {
  const RecurringTransactionsScreen({super.key});

  @override
  State<RecurringTransactionsScreen> createState() =>
      _RecurringTransactionsScreenState();
}

class _RecurringTransactionsScreenState
    extends State<RecurringTransactionsScreen> {
  final _useCases = GetIt.instance<RecurringTransactionUseCases>();

  // ------------------------------------------------------------------ helpers

  Map<RecurrenceFrequency, List<RecurringTransaction>> _group(
      List<RecurringTransaction> rules) {
    final map = <RecurrenceFrequency, List<RecurringTransaction>>{};
    for (final freq in RecurrenceFrequency.values) {
      final filtered = rules.where((t) => t.recurrenceFrequency == freq).toList();
      if (filtered.isNotEmpty) map[freq] = filtered;
    }
    return map;
  }

  String _freqLabel(RecurrenceFrequency freq) {
    final t = context.t;
    return switch (freq) {
      RecurrenceFrequency.daily     => t.v2.transactions.recurrenceDaily,
      RecurrenceFrequency.weekly    => t.v2.transactions.recurrenceWeekly,
      RecurrenceFrequency.monthly   => t.v2.transactions.recurrenceMonthly,
      RecurrenceFrequency.bimonthly => t.v2.transactions.recurrenceBimonthly,
      RecurrenceFrequency.quarterly => t.v2.transactions.recurrenceQuarterly,
      RecurrenceFrequency.yearly    => t.v2.transactions.recurrenceYearly,
    };
  }

  Color _freqColor(RecurrenceFrequency freq) {
    return switch (freq) {
      RecurrenceFrequency.daily     => const Color(0xFF6750A4),
      RecurrenceFrequency.weekly    => const Color(0xFF0277BD),
      RecurrenceFrequency.monthly   => const Color(0xFF00695C),
      RecurrenceFrequency.bimonthly => const Color(0xFF558B2F),
      RecurrenceFrequency.quarterly => const Color(0xFFF57C00),
      RecurrenceFrequency.yearly    => const Color(0xFFC62828),
    };
  }

  void _openEditSheet(RecurringTransaction rule) {
    RecurringTransactionEditSheet.show(
      context,
      rule: rule,
      onUpdated: () => setState(() {}),
    );
  }

  Future<void> _confirmDelete(RecurringTransaction rule) async {
    final t = context.t;
    final confirmed = await showCupertinoDialog<bool>(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(t.v2.transactions.deleteRecurringTitle),
        content: Text(t.v2.transactions.deleteRecurringContent),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context, true),
            child: Text(t.v2.transactions.delete),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context, false),
            child: Text(t.v2.transactions.cancel),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      await _useCases.deleteRecurringTransaction(rule.id);
      setState(() {});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.v2.transactions.recurringRuleDeleted)),
        );
      }
    }
  }

  // ------------------------------------------------------------------ build

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7FA),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildAppBar(t),
              Expanded(
                child: StreamBuilder<List<RecurringTransaction>>(
                  stream: _useCases.watchAllRecurringTransactions(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        !snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: V2Colors.primary,
                        ),
                      );
                    }

                    final all = snapshot.data ?? [];

                    if (all.isEmpty) {
                      return _buildEmpty(t);
                    }

                    return _buildList(ctx, all, t);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------------ widgets

  Widget _buildAppBar(AppStrings t) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: V2Colors.onSurface),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Text(
              t.v2.transactions.recurringScreenTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: V2Colors.onSurface,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'Manrope',
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildEmpty(AppStrings t) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: V2Colors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: const Text('🔄', style: TextStyle(fontSize: 40)),
            ),
            const SizedBox(height: 24),
            Text(
              t.v2.transactions.recurringScreenEmpty,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: V2Colors.onSurfaceVariant,
                fontFamily: 'Manrope',
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(
    BuildContext ctx,
    List<RecurringTransaction> all,
    AppStrings t,
  ) {
    final grouped = _group(all);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
      children: [
        for (final entry in grouped.entries) ...[
          _buildSectionHeader(entry.key, entry.value.length),
          const SizedBox(height: 8),
          for (final rule in entry.value) ...[
            _buildCard(ctx, rule, entry.key, t),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 16),
        ],
      ],
    );
  }

  Widget _buildSectionHeader(RecurrenceFrequency freq, int count) {
    final color = _freqColor(freq);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, left: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(freq.emoji, style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 6),
                Text(
                  _freqLabel(freq),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: color,
                    fontFamily: 'Manrope',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$count',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: V2Colors.onSurfaceVariant,
              fontFamily: 'Manrope',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext ctx,
    RecurringTransaction rule,
    RecurrenceFrequency freq,
    AppStrings t,
  ) {
    final isIncome = rule.isIncome;
    final amountColor =
        isIncome ? const Color(0xFF1B873F) : const Color(0xFFB3261E);
    final amountPrefix = isIncome ? '+' : '-';
    final fmt = NumberFormatter.formatCurrency(rule.amount.abs(),
        currencyId: rule.currencyId);

    final walletName = rule.wallet?.name ?? '';
    final emoji = (rule.category != null && rule.category!.icon.isNotEmpty)
        ? IconToEmojiMapper.getEmoji(rule.category!.icon)
        : (isIncome ? '💰' : '🏷️');

    final nextDue = rule.nextExecutionDate;
    final langCode = LocaleSettings.currentLocale.languageCode;
    final nextDueStr = DateFormat('d MMM yyyy', langCode).format(nextDue);
    final isOverdue = nextDue.isBefore(DateTime.now());
    final freqColor = _freqColor(freq);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _openEditSheet(rule),
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top: avatar + info + amount
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: freqColor.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: Text(emoji, style: const TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  rule.description?.isNotEmpty == true
                                      ? rule.description!
                                      : (rule.category?.name ??
                                          (isIncome
                                              ? t.v2.transactions.recurringIncome
                                              : t.v2.transactions.recurringExpense)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: V2Colors.onSurface,
                                    fontFamily: 'Manrope',
                                  ),
                                ),
                              ),
                              if (!rule.active) ...[
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    t.v2.transactions.pausedBadge,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                      fontFamily: 'Manrope',
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          if (walletName.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              walletName,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: V2Colors.onSurfaceVariant,
                                fontFamily: 'Manrope',
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Text(
                      '$amountPrefix$fmt',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: amountColor,
                        fontFamily: 'Manrope',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Divider
                Container(
                  height: 1,
                  color: V2Colors.outlineVariant.withValues(alpha: 0.3),
                ),
                const SizedBox(height: 10),

                // Bottom: freq badge + next due + actions
                Row(
                  children: [
                    // Freq badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: freqColor.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(freq.emoji,
                              style: const TextStyle(fontSize: 11)),
                          const SizedBox(width: 4),
                          Text(
                            _freqLabel(freq),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: freqColor,
                              fontFamily: 'Manrope',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Next due date
                    Icon(
                      isOverdue
                          ? Icons.warning_amber_rounded
                          : Icons.event_rounded,
                      size: 13,
                      color: isOverdue
                          ? const Color(0xFFB3261E)
                          : V2Colors.onSurfaceVariant,
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        t.v2.transactions.recurringNextDue(date: nextDueStr),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: isOverdue
                              ? const Color(0xFFB3261E)
                              : V2Colors.onSurfaceVariant,
                          fontFamily: 'Manrope',
                        ),
                      ),
                    ),
                    // Edit
                    _ActionBtn(
                      icon: Icons.edit_outlined,
                      color: V2Colors.primary,
                      onTap: () => _openEditSheet(rule),
                    ),
                    const SizedBox(width: 6),
                    // Delete
                    _ActionBtn(
                      icon: Icons.delete_outline_rounded,
                      color: const Color(0xFFB3261E),
                      onTap: () => _confirmDelete(rule),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 17, color: color),
      ),
    );
  }
}
