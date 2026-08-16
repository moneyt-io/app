import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import '../../domain/usecases/recurring_transaction_usecases.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../data/datasources/local/daos/transaction_dao.dart';
import '../utils/recurring_date_helper.dart';

/// Robust and idempotent background service that checks active recurring transaction rules
/// on app startup and automatically generates transaction instances for any due dates passed.
///
/// Ensures:
/// 1. Complete isolation: Rules live in `recurring_transactions`; historical transactions in `transaction_entries`.
/// 2. Idempotency: Checks for already-created transactions for the same rule and date before inserting.
/// 3. Month-end & calendar safety: Uses [RecurringDateHelper] to avoid date drifting and time-of-day bugs.
class RecurringTransactionService {
  RecurringTransactionService._();

  static final instance = RecurringTransactionService._();

  bool _isRunning = false;

  /// Runs the auto-creation check for all active recurring transaction rules.
  /// Returns the total number of newly generated transactions.
  Future<int> runPendingRecurrences() async {
    if (_isRunning) return 0;
    _isRunning = true;

    int created = 0;

    try {
      final recurringUseCases = GetIt.instance<RecurringTransactionUseCases>();
      final transactionUseCases = GetIt.instance<TransactionUseCases>();
      final transactionDao = GetIt.instance<TransactionDao>();

      // Fetch only active recurring rules
      final activeRules = await recurringUseCases.getActiveRecurringTransactions();
      final now = DateTime.now();

      for (final rule in activeRules) {
        // Reference date: lastExecutedAt if available, otherwise rule's startDate
        final lastRef = rule.lastExecutedAt ?? rule.startDate;

        // Compute all due dates between lastRef (exclusive) and now (inclusive)
        final dueDates = RecurringDateHelper.computeDueDates(
          lastRef,
          rule.recurrenceFrequency,
          now,
        );

        if (dueDates.isEmpty) continue;

        DateTime? lastSuccessfullyCreatedDate;

        for (final dueDate in dueDates) {
          // If the rule has an end date and this due date is after it, stop generating
          if (rule.endDate != null && dueDate.isAfter(rule.endDate!)) {
            break;
          }

          // 🛡️ IDEMPOTENCY CHECK: Ensure a transaction hasn't already been created for this rule & date
          final alreadyExists = await transactionDao.hasTransactionForRecurringAndDate(rule.id, dueDate);
          if (alreadyExists) {
            debugPrint('[RecurringService] ⏩ Skipping rule #${rule.id} for $dueDate: already exists.');
            lastSuccessfullyCreatedDate = dueDate;
            continue;
          }

          try {
            if (rule.isIncome) {
              await transactionUseCases.createIncome(
                date: dueDate,
                description: rule.description ?? '',
                amount: rule.amount.abs(),
                currencyId: rule.currencyId,
                walletId: rule.paymentId,
                categoryId: rule.categoryId,
                contactId: rule.contactId,
                rateExchange: rule.rateExchange,
                recurringTransactionId: rule.id,
              );
            } else {
              await transactionUseCases.createExpense(
                date: dueDate,
                description: rule.description ?? '',
                amount: rule.amount.abs(),
                currencyId: rule.currencyId,
                paymentId: rule.paymentId,
                paymentTypeId: rule.paymentTypeId,
                categoryId: rule.categoryId,
                contactId: rule.contactId,
                rateExchange: rule.rateExchange,
                recurringTransactionId: rule.id,
              );
            }
            created++;
            lastSuccessfullyCreatedDate = dueDate;
          } catch (e) {
            debugPrint('[RecurringService] ❌ Error creating recurring copy for rule #${rule.id} at $dueDate: $e');
          }
        }

        // Update lastExecutedAt and nextExecutionDate on the rule
        if (lastSuccessfullyCreatedDate != null) {
          final nextDue = RecurringDateHelper.calculateNextDueDate(
            lastSuccessfullyCreatedDate,
            rule.recurrenceFrequency,
          );

          await recurringUseCases.updateExecutionDates(
            rule.id,
            lastSuccessfullyCreatedDate,
            nextDue,
          );

          // If next scheduled date is past endDate, deactivate rule automatically
          if (rule.endDate != null && nextDue.isAfter(rule.endDate!)) {
            await recurringUseCases.toggleActive(rule.id, false);
          }
        }
      }

      if (created > 0) {
        debugPrint('[RecurringService] ✅ Auto-created $created recurring transaction(s).');
      } else {
        debugPrint('[RecurringService] ✅ All recurring transactions are up to date.');
      }
    } catch (e) {
      debugPrint('[RecurringService] ❌ Unexpected error during recurrence run: $e');
    } finally {
      _isRunning = false;
    }

    return created;
  }
}
