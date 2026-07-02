import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/transaction_entry.dart';
import '../../../../domain/enums/recurrence_frequency.dart';
import '../../features/transactions/transaction_provider.dart';
import '../../features/wallets/wallet_provider.dart';
import '../../core/l10n/generated/strings.g.dart';
import '../theme/v2_colors.dart';
import '../../../core/utils/number_formatter.dart';
import 'new_transaction_screen.dart';

/// Full-screen management view for all recurring transactions.
class RecurringTransactionsScreen extends StatefulWidget {
  const RecurringTransactionsScreen({super.key});

  @override
  State<RecurringTransactionsScreen> createState() =>
      _RecurringTransactionsScreenState();
}

class _RecurringTransactionsScreenState
    extends State<RecurringTransactionsScreen> {

  // ------------------------------------------------------------------ helpers

  Map<RecurrenceFrequency, List<TransactionEntry>> _group(
      List<TransactionEntry> txs) {
    final map = <RecurrenceFrequency, List<TransactionEntry>>{};
    for (final freq in RecurrenceFrequency.values) {
      final filtered = txs.where((t) => t.recurringFrequency == freq).toList();
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

  DateTime _nextDue(DateTime last, RecurrenceFrequency freq) {
    return switch (freq) {
      RecurrenceFrequency.daily     => last.add(const Duration(days: 1)),
      RecurrenceFrequency.weekly    => last.add(const Duration(days: 7)),
      RecurrenceFrequency.monthly   => DateTime(last.year, last.month + 1, last.day),
      RecurrenceFrequency.bimonthly => DateTime(last.year, last.month + 2, last.day),
      RecurrenceFrequency.quarterly => DateTime(last.year, last.month + 3, last.day),
      RecurrenceFrequency.yearly    => DateTime(last.year + 1, last.month, last.day),
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

  void _navigateToEdit(TransactionEntry tx) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => NewTransactionScreen(
          transactionIdToEdit: tx.id,
          initialType: tx.documentTypeId,
          initialAmount: tx.amount.abs(),
          initialDescription: tx.description,
          initialCategoryId: tx.mainCategoryId,
          initialWalletId: tx.details.isNotEmpty
              ? (tx.details.first.paymentTypeId == 'C'
                  ? -tx.details.first.paymentId
                  : tx.details.first.paymentId)
              : null,
          initialDate: tx.date,
          initialRecurrenceFrequency: tx.recurrenceFrequency,
          autoOpenKeyboard: false,
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
      BuildContext ctx, TransactionEntry tx, TransactionProvider tp) async {
    final confirmed = await showCupertinoDialog<bool>(
      context: ctx,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Eliminar transacción recurrente'),
        content: const Text(
            'Se eliminará permanentemente. Esta acción no se puede deshacer.'),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
    if (confirmed == true && ctx.mounted) {
      await tp.deleteTransaction(tx.id);
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
          child: Consumer2<TransactionProvider, WalletProvider>(
            builder: (ctx, txProvider, walletProvider, _) {
              final all = txProvider.transactions
                  .where((tx) => tx.isRecurring)
                  .toList()
                ..sort((a, b) => b.date.compareTo(a.date));

              return Column(
                children: [
                  _buildAppBar(t),
                  Expanded(
                    child: all.isEmpty
                        ? _buildEmpty(t)
                        : _buildList(ctx, all, txProvider, walletProvider, t),
                  ),
                ],
              );
            },
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
    List<TransactionEntry> all,
    TransactionProvider txProvider,
    WalletProvider walletProvider,
    AppStrings t,
  ) {
    final grouped = _group(all);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
      children: [
        for (final entry in grouped.entries) ...[
          _buildSectionHeader(entry.key, entry.value.length),
          const SizedBox(height: 8),
          for (final tx in entry.value) ...[
            _buildCard(ctx, tx, entry.key, txProvider, walletProvider, t),
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
    TransactionEntry tx,
    RecurrenceFrequency freq,
    TransactionProvider txProvider,
    WalletProvider walletProvider,
    AppStrings t,
  ) {
    final isIncome = tx.isIncome;
    final amountColor =
        isIncome ? const Color(0xFF1B873F) : const Color(0xFFB3261E);
    final amountPrefix = isIncome ? '+' : '-';
    final fmt = NumberFormatter.formatCurrency(tx.amount.abs(), currencyId: tx.currencyId);

    // Wallet name
    String walletName = '';
    if (tx.details.isNotEmpty && tx.details.first.paymentId != null) {
      final wallet = walletProvider.wallets
          .where((w) => w.id == tx.details.first.paymentId)
          .firstOrNull;
      walletName = wallet?.name ?? '';
    }

    final emoji = tx.category?.icon ?? (isIncome ? '💰' : '💸');

    final nextDue = _nextDue(tx.date, freq);
    final nextDueStr = DateFormat('d MMM yyyy', 'es').format(nextDue);
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
          onTap: () => _navigateToEdit(tx),
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
                          Text(
                            tx.description?.isNotEmpty == true
                                ? tx.description!
                                : (isIncome ? 'Ingreso' : 'Gasto'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: V2Colors.onSurface,
                              fontFamily: 'Manrope',
                            ),
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
                      onTap: () => _navigateToEdit(tx),
                    ),
                    const SizedBox(width: 6),
                    // Delete
                    _ActionBtn(
                      icon: Icons.delete_outline_rounded,
                      color: const Color(0xFFB3261E),
                      onTap: () => _confirmDelete(ctx, tx, txProvider),
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
