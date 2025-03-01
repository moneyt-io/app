import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/transaction_entries_table.dart';
import '../tables/transaction_details_table.dart';

part 'transaction_dao.g.dart';

@DriftAccessor(tables: [TransactionEntry, TransactionDetail])
class TransactionDao extends DatabaseAccessor<AppDatabase> with _$TransactionDaoMixin {
  TransactionDao(AppDatabase db) : super(db);

  // Queries básicas
  Future<List<TransactionEntries>> getAllTransactions() => 
      (select(transactionEntry)
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();

  Future<TransactionEntries?> getTransactionById(int id) =>
      (select(transactionEntry)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<List<TransactionDetails>> getTransactionDetailsForEntry(int transactionId) =>
      (select(transactionDetail)..where((t) => t.transactionId.equals(transactionId)))
          .get();

  // Queries por tipo
  Future<List<TransactionEntries>> getTransactionsByType(String documentTypeId) => 
      (select(transactionEntry)
        ..where((t) => t.documentTypeId.equals(documentTypeId))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();

  // Watch Queries
  Stream<List<TransactionEntries>> watchAllTransactions() =>
      (select(transactionEntry)
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();

  Stream<List<TransactionEntries>> watchTransactionsByType(String documentTypeId) =>
      (select(transactionEntry)
        ..where((t) => t.documentTypeId.equals(documentTypeId))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();

  // CRUD Operations para Entry
  Future<int> insertTransaction(TransactionEntriesCompanion entry) =>
      into(transactionEntry).insert(entry);

  Future<bool> updateTransaction(TransactionEntriesCompanion entry) =>
      update(transactionEntry).replace(entry);

  Future<int> deleteTransaction(int id) =>
      (delete(transactionEntry)..where((t) => t.id.equals(id))).go();

  // CRUD Operations para Details
  Future<int> insertTransactionDetail(TransactionDetailsCompanion detail) =>
      into(transactionDetail).insert(detail);

  Future<int> deleteTransactionDetails(int transactionId) =>
      (delete(transactionDetail)..where((t) => t.transactionId.equals(transactionId))).go();

  Future<bool> updateTransactionDetail(TransactionDetailsCompanion detail) =>
      update(transactionDetail).replace(detail);

  // Balance Queries
  Future<double> getAccountBalance(int accountId) async {
    final details = await (select(transactionDetail)
      ..where((t) => t.paymentId.equals(accountId)))
      .get();
    
    return details.fold<double>(0.0, (sum, detail) => sum + detail.amount);
  }

  Stream<double> watchAccountBalance(int accountId) {
    return (select(transactionDetail)
      ..where((t) => t.paymentId.equals(accountId)))
      .watch()
      .map((details) => details.fold<double>(
        0.0, 
        (sum, detail) => sum + detail.amount
      ));
  }
}
