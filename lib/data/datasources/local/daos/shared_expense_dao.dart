import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/shared_expense_entries_table.dart';
import '../tables/shared_expense_details_table.dart';

part 'shared_expense_dao.g.dart';

@DriftAccessor(tables: [SharedExpenseEntry, SharedExpenseDetail])
class SharedExpenseDao extends DatabaseAccessor<AppDatabase> with _$SharedExpenseDaoMixin {
  SharedExpenseDao(AppDatabase db) : super(db);

  // Queries básicas
  Future<List<SharedExpenseEntries>> getAllSharedExpenses() => 
      (select(sharedExpenseEntry)
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();

  Future<SharedExpenseEntries?> getSharedExpenseById(int id) =>
      (select(sharedExpenseEntry)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<List<SharedExpenseDetails>> getSharedExpenseDetailsForEntry(int expenseId) =>
      (select(sharedExpenseDetail)..where((t) => t.sharedExpenseId.equals(expenseId)))
          .get();

  // Watch Queries
  Stream<List<SharedExpenseEntries>> watchAllSharedExpenses() =>
      (select(sharedExpenseEntry)
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();

  // CRUD Operations para Entry
  Future<int> insertSharedExpense(SharedExpenseEntriesCompanion expense) =>
      into(sharedExpenseEntry).insert(expense);

  Future<bool> updateSharedExpense(SharedExpenseEntriesCompanion expense) =>
      update(sharedExpenseEntry).replace(expense);

  Future<int> deleteSharedExpense(int id) =>
      (delete(sharedExpenseEntry)..where((t) => t.id.equals(id))).go();

  // CRUD Operations para Details
  Future<int> insertSharedExpenseDetail(SharedExpenseDetailsCompanion detail) =>
      into(sharedExpenseDetail).insert(detail);

  Future<int> deleteSharedExpenseDetails(int expenseId) =>
      (delete(sharedExpenseDetail)..where((t) => t.sharedExpenseId.equals(expenseId))).go();
}
