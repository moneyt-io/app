import '../entities/recurring_transaction.dart';

abstract class RecurringTransactionRepository {
  /// Fetches all non-deleted recurring transactions.
  Future<List<RecurringTransaction>> getAllRecurringTransactions();

  /// Fetches only active recurring transactions.
  Future<List<RecurringTransaction>> getActiveRecurringTransactions();

  /// Watches all active recurring transactions.
  Stream<List<RecurringTransaction>> watchActiveRecurringTransactions();

  /// Watches all recurring transactions.
  Stream<List<RecurringTransaction>> watchAllRecurringTransactions();

  /// Gets a recurring transaction by its ID.
  Future<RecurringTransaction?> getRecurringTransactionById(int id);

  /// Creates a new recurring transaction rule.
  Future<RecurringTransaction> createRecurringTransaction({
    required String documentTypeId,
    required String currencyId,
    required int paymentId,
    String paymentTypeId = 'W',
    required int categoryId,
    int? contactId,
    required double amount,
    double rateExchange = 1.0,
    String? description,
    required String frequency,
    required DateTime startDate,
    DateTime? endDate,
    DateTime? lastExecutedAt,
    required DateTime nextExecutionDate,
    bool autoCreate = true,
  });

  /// Updates an existing recurring transaction rule.
  Future<bool> updateRecurringTransaction(RecurringTransaction recurring);

  /// Updates execution dates for a recurring rule after auto-creation.
  Future<bool> updateExecutionDates(int id, DateTime lastExecutedAt, DateTime nextExecutionDate);

  /// Toggles active/paused state.
  Future<bool> toggleActive(int id, bool active);

  /// Soft deletes a recurring transaction rule.
  Future<bool> deleteRecurringTransaction(int id);
}
