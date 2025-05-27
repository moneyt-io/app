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
        ..where((t) => t.active.equals(true))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();

  Future<TransactionEntries?> getTransactionById(int id) =>
      (select(transactionEntry)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<List<TransactionDetails>> getTransactionDetailsForEntry(int transactionId) =>
      (select(transactionDetail)..where((t) => t.transactionId.equals(transactionId)))
          .get(); // REMOVIDO: & t.active.equals(true) - active no existe en transaction_details

  // Watch Queries
  Stream<List<TransactionEntries>> watchAllTransactions() =>
      (select(transactionEntry)
        ..where((t) => t.active.equals(true))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();

  // Queries especializadas
  Future<List<TransactionEntries>> getTransactionsByType(String documentTypeId) =>
      (select(transactionEntry)
        ..where((t) => t.documentTypeId.equals(documentTypeId) & t.active.equals(true))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();

  Future<List<TransactionEntries>> getTransactionsByContact(int contactId) =>
      (select(transactionEntry)
        ..where((t) => t.contactId.equals(contactId) & t.active.equals(true))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();

  Future<List<TransactionEntries>> getTransactionsByDateRange(DateTime startDate, DateTime endDate) =>
      (select(transactionEntry)
        ..where((t) => t.date.isBetweenValues(startDate, endDate) & t.active.equals(true))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();

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

  Future<bool> updateTransactionDetail(TransactionDetailsCompanion detail) =>
      update(transactionDetail).replace(detail);

  Future<int> deleteTransactionDetails(int transactionId) =>
      (delete(transactionDetail)..where((t) => t.transactionId.equals(transactionId))).go();

  // Utilidades
  Future<int> getNextSecuencial(String documentTypeId) async {
    final lastEntry = await (select(transactionEntry)
      ..where((t) => t.documentTypeId.equals(documentTypeId))
      ..orderBy([(t) => OrderingTerm.desc(t.secuencial)])
      ..limit(1)).getSingleOrNull();
    
    return (lastEntry?.secuencial ?? 0) + 1;
  }

  // Estadísticas básicas
  Future<double> getTotalIncomeAmount() async {
    final result = await customSelect(
      'SELECT SUM(amount) as total FROM transaction_entries WHERE document_type_id = ? AND active = 1',
      variables: [Variable.withString('I')],
      readsFrom: {transactionEntry},
    ).getSingleOrNull();
    
    return result?.data['total']?.toDouble() ?? 0.0;
  }

  Future<double> getTotalExpenseAmount() async {
    final result = await customSelect(
      'SELECT SUM(amount) as total FROM transaction_entries WHERE document_type_id = ? AND active = 1',
      variables: [Variable.withString('E')],
      readsFrom: {transactionEntry},
    ).getSingleOrNull();
    
    return result?.data['total']?.toDouble() ?? 0.0;
  }

  // MÉTODOS AGREGADOS PARA SOPORTE DE TRANSACTIONREPOSITORY:

  Future<List<TransactionEntries>> getTransactionsByCreditCardPayment(int creditCardId) async {
    final query = select(transactionEntry).join([
      innerJoin(transactionDetail, transactionDetail.transactionId.equalsExp(transactionEntry.id))
    ]);
    
    query.where(transactionEntry.active.equals(true) & 
                transactionDetail.paymentTypeId.equals('C') & 
                transactionDetail.paymentId.equals(creditCardId));
    
    query.orderBy([OrderingTerm.desc(transactionEntry.date)]);
    
    final results = await query.get();
    return results.map((row) => row.readTable(transactionEntry)).toList();
  }

  Future<List<TransactionEntries>> getTransactionsByPaymentTypeAndId(String paymentTypeId, int paymentId) async {
    final query = select(transactionEntry).join([
      innerJoin(transactionDetail, transactionDetail.transactionId.equalsExp(transactionEntry.id))
    ]);
    
    query.where(transactionEntry.active.equals(true) & 
                transactionDetail.paymentTypeId.equals(paymentTypeId) & 
                transactionDetail.paymentId.equals(paymentId));
    
    query.orderBy([OrderingTerm.desc(transactionEntry.date)]);
    
    final results = await query.get();
    return results.map((row) => row.readTable(transactionEntry)).toList();
  }
}
