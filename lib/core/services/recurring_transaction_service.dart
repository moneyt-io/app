import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/transaction_entry.dart';
import '../../domain/enums/recurrence_frequency.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../data/datasources/local/daos/transaction_dao.dart';
import '../../data/datasources/local/database.dart';
import 'package:drift/drift.dart' show Value;

/// Service that checks all recurring transactions on app startup and
/// automatically creates new copies for any that have passed their due date.
///
/// Usage: call [runPendingRecurrences] once after the database is ready,
/// typically from [DashboardWrapper.initState] or [main].
class RecurringTransactionService {
  RecurringTransactionService._();

  static final instance = RecurringTransactionService._();

  bool _isRunning = false;

  /// Runs the auto-creation check.
  ///
  /// Returns the number of new transactions that were created.
  Future<int> runPendingRecurrences() async {
    if (_isRunning) return 0;
    _isRunning = true;

    int created = 0;

    try {
      final useCases = GetIt.instance<TransactionUseCases>();
      final db = GetIt.instance<AppDatabase>();

      // Fetch all active recurring transactions
      final all = await useCases.getAllTransactions();
      final recurring =
          all.where((tx) => tx.isRecurring && tx.active).toList();

      final now = DateTime.now();

      for (final template in recurring) {
        final freq = template.recurringFrequency;
        if (freq == null) continue;

        // Determine the reference date: lastExecutedAt if set, otherwise
        // the transaction's own creation date (date field).
        final lastRef = template.lastExecutedAt ?? template.date;

        // Compute all missed due dates since lastRef up to now
        final dueDates = _computeDueDates(lastRef, freq, now);
        if (dueDates.isEmpty) continue;

        // Create a new transaction copy for each missed due date
        for (final dueDate in dueDates) {
          try {
            if (template.isIncome) {
              if (template.details.isEmpty) continue;
              final detail = template.details.first;
              await useCases.createIncome(
                date: dueDate,
                description: template.description ?? '',
                amount: template.amount.abs(),
                currencyId: template.currencyId,
                walletId: detail.paymentId ?? 0,
                categoryId: detail.categoryId ?? 0,
                contactId: template.contactId,
                rateExchange: template.rateExchange,
                // No recurrenceFrequency on auto-created copies — they are
                // one-time instances. Only the template keeps the frequency.
                recurrenceFrequency: null,
              );
            } else if (template.isExpense) {
              if (template.details.isEmpty) continue;
              final detail = template.details.first;
              await useCases.createExpense(
                date: dueDate,
                description: template.description ?? '',
                amount: template.amount.abs(),
                currencyId: template.currencyId,
                paymentId: detail.paymentId ?? 0,
                paymentTypeId: detail.paymentTypeId ?? 'W',
                categoryId: detail.categoryId ?? 0,
                contactId: template.contactId,
                rateExchange: template.rateExchange,
                recurrenceFrequency: null,
              );
            }
            created++;
          } catch (e) {
            debugPrint(
                '[RecurringService] Error creating copy for tx ${template.id}: $e');
          }
        }

        if (dueDates.isNotEmpty) {
          // Update lastExecutedAt on the template to the last due date fired
          await db.update(db.transactionEntry).replace(
                TransactionEntriesCompanion(
                  id: Value(template.id),
                  documentTypeId: Value(template.documentTypeId),
                  currencyId: Value(template.currencyId),
                  journalId: Value(template.journalId),
                  contactId: Value(template.contactId),
                  secuencial: Value(template.secuencial),
                  date: Value(template.date),
                  amount: Value(template.amount),
                  rateExchange: Value(template.rateExchange),
                  description: Value(template.description),
                  recurrenceFrequency: Value(template.recurrenceFrequency),
                  lastExecutedAt: Value(dueDates.last),
                  active: Value(template.active),
                  createdAt: Value(template.createdAt),
                  updatedAt: Value(DateTime.now()),
                  deletedAt: Value(template.deletedAt),
                ),
              );
        }
      }

      if (created > 0) {
        debugPrint(
            '[RecurringService] ✅ Auto-created $created recurring transaction(s)');
      } else {
        debugPrint('[RecurringService] ✅ All recurring transactions are up to date');
      }
    } catch (e) {
      debugPrint('[RecurringService] ❌ Error: $e');
    } finally {
      _isRunning = false;
    }

    return created;
  }

  /// Returns all dates between [lastRef] (exclusive) and [now] (inclusive)
  /// that are due based on [freq]. Limited to 365 iterations for safety.
  List<DateTime> _computeDueDates(
    DateTime lastRef,
    RecurrenceFrequency freq,
    DateTime now,
  ) {
    final dates = <DateTime>[];
    DateTime cursor = lastRef;
    int iterations = 0;

    while (iterations < 365) {
      final next = _advance(cursor, freq);
      // Only add if the next due date is strictly in the past (not future)
      if (next.isAfter(now)) break;
      dates.add(next);
      cursor = next;
      iterations++;
    }

    return dates;
  }

  DateTime _advance(DateTime from, RecurrenceFrequency freq) {
    return switch (freq) {
      RecurrenceFrequency.daily     => from.add(const Duration(days: 1)),
      RecurrenceFrequency.weekly    => from.add(const Duration(days: 7)),
      RecurrenceFrequency.monthly   => DateTime(from.year, from.month + 1, from.day),
      RecurrenceFrequency.bimonthly => DateTime(from.year, from.month + 2, from.day),
      RecurrenceFrequency.quarterly => DateTime(from.year, from.month + 3, from.day),
      RecurrenceFrequency.yearly    => DateTime(from.year + 1, from.month, from.day),
    };
  }
}
