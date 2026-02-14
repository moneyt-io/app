import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/loan_entries_table.dart';
import '../tables/loan_details_table.dart';

part 'loan_dao.g.dart';

@DriftAccessor(tables: [LoanEntry, LoanDetail])
class LoanDao extends DatabaseAccessor<AppDatabase> with _$LoanDaoMixin {
  LoanDao(AppDatabase db) : super(db);

  // Queries básicas
  Future<List<LoanEntries>> getAllLoans() => 
      (select(loanEntry)
        ..where((t) => t.active.equals(true))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();

  Future<LoanEntries?> getLoanById(int id) =>
      (select(loanEntry)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<List<LoanDetails>> getLoanDetailsForEntry(int loanId) =>
      (select(loanDetail)..where((t) => t.loanId.equals(loanId) & t.active.equals(true)))
          .get();

  // Watch Queries
  Stream<List<LoanEntries>> watchAllLoans() =>
      (select(loanEntry)
        ..where((t) => t.active.equals(true))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();

  // Queries especializadas
  Future<List<LoanEntries>> getLoansByContact(int contactId) =>
      (select(loanEntry)
        ..where((t) => t.contactId.equals(contactId) & t.active.equals(true))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();

  Future<List<LoanEntries>> getLoansByType(String documentTypeId) =>
      (select(loanEntry)
        ..where((t) => t.documentTypeId.equals(documentTypeId) & t.active.equals(true))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();

  Future<List<LoanEntries>> getLoansByStatus(String status) =>
      (select(loanEntry)
        ..where((t) => t.status.equals(status) & t.active.equals(true))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();

  // MÉTODOS CRÍTICOS FALTANTES:
  Future<double> getTotalByType(String documentTypeId) async {
    final amounts = await (select(loanEntry)
      ..where((loan) => loan.documentTypeId.equals(documentTypeId) & loan.active.equals(true)))
      .map((loan) => loan.amount)
      .get();
    
    return amounts.fold<double>(0.0, (sum, amount) => sum + (amount ?? 0.0));
  }

  Future<double> getOutstandingByType(String documentTypeId) async {
    final amounts = await (select(loanEntry)
      ..where((loan) => 
        loan.documentTypeId.equals(documentTypeId) & 
        loan.active.equals(true) &
        loan.status.equals('ACTIVE')))
      .map((loan) => loan.amount - loan.totalPaid)
      .get();
    
    return amounts.fold<double>(0.0, (sum, amount) => sum + (amount ?? 0.0));
  }

  // CRUD Operations para Entry
  Future<int> insertLoan(LoanEntriesCompanion entry) =>
      into(loanEntry).insert(entry);

  Future<bool> updateLoan(LoanEntriesCompanion entry) =>
      update(loanEntry).replace(entry);

  Future<void> deleteLoan(int id) {
    return transaction(() async {
      // 1. Obtener los IDs de transacciones asociadas a través de los detalles
      final details = await (select(loanDetail)..where((t) => t.loanId.equals(id))).get();
      final transactionIds = details.map((d) => d.transactionId).toList();

      // 2. Eliminar detalles del préstamo
      await (delete(loanDetail)..where((t) => t.loanId.equals(id))).go();

      // 3. Eliminar el préstamo
      await (delete(loanEntry)..where((t) => t.id.equals(id))).go();

      // 4. Eliminar las transacciones asociadas
      if (transactionIds.isNotEmpty) {
        await (delete(db.transactionEntry)..where((t) => t.id.isIn(transactionIds))).go();
      }
    });
  }

  // CRUD Operations para Details
  Future<int> insertLoanDetail(LoanDetailsCompanion detail) =>
      into(loanDetail).insert(detail);

  Future<bool> updateLoanDetail(LoanDetailsCompanion detail) =>
      update(loanDetail).replace(detail);

  Future<int> deleteLoanDetails(int loanId) =>
      (delete(loanDetail)..where((t) => t.loanId.equals(loanId))).go();

  // Utilidades
  Future<int> getNextSecuencial(String documentTypeId) async {
    final lastEntry = await (select(loanEntry)
      ..where((loan) => loan.documentTypeId.equals(documentTypeId))
      ..orderBy([(loan) => OrderingTerm.desc(loan.secuencial)])
      ..limit(1)).getSingleOrNull();
    
    return (lastEntry?.secuencial ?? 0) + 1;
  }

  // Estadísticas básicas
  Future<double> getTotalLentAmount() async {
    final result = await customSelect(
      'SELECT SUM(amount) as total FROM loan_entries WHERE document_type_id = ? AND active = 1',
      variables: [Variable.withString('L')],
      readsFrom: {loanEntry},
    ).getSingleOrNull();
    
    return result?.data['total']?.toDouble() ?? 0.0;
  }

  Future<double> getTotalBorrowedAmount() async {
    final result = await customSelect(
      'SELECT SUM(amount) as total FROM loan_entries WHERE document_type_id = ? AND active = 1',
      variables: [Variable.withString('B')],
      readsFrom: {loanEntry},
    ).getSingleOrNull();
    
    return result?.data['total']?.toDouble() ?? 0.0;
  }

  Future<double> getOutstandingLentAmount() async {
    final result = await customSelect(
      'SELECT SUM(amount - total_paid) as total FROM loan_entries WHERE document_type_id = ? AND status = ? AND active = 1',
      variables: [Variable.withString('L'), Variable.withString('ACTIVE')],
      readsFrom: {loanEntry},
    ).getSingleOrNull();
    
    return result?.data['total']?.toDouble() ?? 0.0;
  }

  Future<double> getOutstandingBorrowedAmount() async {
    final result = await customSelect(
      'SELECT SUM(amount - total_paid) as total FROM loan_entries WHERE document_type_id = ? AND status = ? AND active = 1',
      variables: [Variable.withString('B'), Variable.withString('ACTIVE')],
      readsFrom: {loanEntry},
    ).getSingleOrNull();
    
    return result?.data['total']?.toDouble() ?? 0.0;
  }
}
