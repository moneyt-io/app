import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/recurring_transactions_table.dart';

part 'recurring_transaction_dao.g.dart';

@DriftAccessor(tables: [RecurringTransactions])
class RecurringTransactionDao extends DatabaseAccessor<AppDatabase>
    with _$RecurringTransactionDaoMixin {
  RecurringTransactionDao(AppDatabase db) : super(db);

  /// Returns all recurring transaction rules (active or inactive, not soft-deleted)
  Future<List<RecurringTransactionData>> getAllRecurringTransactions() =>
      (select(recurringTransactions)
            ..where((t) => t.deletedAt.isNull())
            ..orderBy([(t) => OrderingTerm.asc(t.nextExecutionDate)]))
          .get();

  /// Returns only active recurring transaction rules
  Future<List<RecurringTransactionData>> getActiveRecurringTransactions() =>
      (select(recurringTransactions)
            ..where((t) => t.active.equals(true) & t.deletedAt.isNull())
            ..orderBy([(t) => OrderingTerm.asc(t.nextExecutionDate)]))
          .get();

  /// Stream of all active recurring transaction rules
  Stream<List<RecurringTransactionData>> watchActiveRecurringTransactions() =>
      (select(recurringTransactions)
            ..where((t) => t.active.equals(true) & t.deletedAt.isNull())
            ..orderBy([(t) => OrderingTerm.asc(t.nextExecutionDate)]))
          .watch();

  /// Stream of all recurring transaction rules
  Stream<List<RecurringTransactionData>> watchAllRecurringTransactions() =>
      (select(recurringTransactions)
            ..where((t) => t.deletedAt.isNull())
            ..orderBy([(t) => OrderingTerm.asc(t.nextExecutionDate)]))
          .watch();

  /// Find single rule by ID
  Future<RecurringTransactionData?> getRecurringTransactionById(int id) =>
      (select(recurringTransactions)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  /// Insert a new recurring transaction rule
  Future<int> insertRecurringTransaction(RecurringTransactionDataCompanion entry) =>
      into(recurringTransactions).insert(entry);

  /// Update an existing recurring transaction rule
  Future<bool> updateRecurringTransaction(RecurringTransactionDataCompanion entry) =>
      update(recurringTransactions).replace(entry);

  /// Update only execution dates
  Future<int> updateExecutionDates(int id, DateTime lastExecutedAt, DateTime nextExecutionDate) =>
      (update(recurringTransactions)..where((t) => t.id.equals(id))).write(
        RecurringTransactionDataCompanion(
          lastExecutedAt: Value(lastExecutedAt),
          nextExecutionDate: Value(nextExecutionDate),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// Toggle active state
  Future<int> toggleActive(int id, bool active) =>
      (update(recurringTransactions)..where((t) => t.id.equals(id))).write(
        RecurringTransactionDataCompanion(
          active: Value(active),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// Soft delete a recurring transaction rule
  Future<int> softDeleteRecurringTransaction(int id) =>
      (update(recurringTransactions)..where((t) => t.id.equals(id))).write(
        RecurringTransactionDataCompanion(
          active: const Value(false),
          deletedAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// Hard delete
  Future<int> deleteRecurringTransaction(int id) =>
      (delete(recurringTransactions)..where((t) => t.id.equals(id))).go();
}
