import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/loan_details_table.dart';
import '../tables/loan_entries_table.dart';

part 'loan_dao.g.dart';

@DriftAccessor(tables: [LoanEntry, LoanDetail])
class LoanDao extends DatabaseAccessor<AppDatabase> with _$LoanDaoMixin {
  LoanDao(AppDatabase db) : super(db);

  // Queries básicas
  Future<List<LoanEntries>> getAllLoans() => 
      (select(loanEntry)
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();

  Future<LoanEntries?> getLoanById(int id) =>
      (select(loanEntry)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<List<LoanDetails>> getLoanDetailsForEntry(int loanId) =>
      (select(loanDetail)..where((t) => t.loanId.equals(loanId)))
          .get();

  Future<List<LoanEntries>> getLoansByContact(int contactId) => 
      (select(loanEntry)
        ..where((t) => t.contactId.equals(contactId))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();

  // Watch Queries
  Stream<List<LoanEntries>> watchAllLoans() =>
      (select(loanEntry)
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();

  // CRUD Operations
  Future<int> insertLoan(LoanEntriesCompanion loan) =>
      into(loanEntry).insert(loan);

  Future<bool> updateLoan(LoanEntriesCompanion loan) =>
      update(loanEntry).replace(loan);

  Future<int> deleteLoan(int id) =>
      (delete(loanEntry)..where((t) => t.id.equals(id))).go();

  // CRUD Operations para Details
  Future<int> insertLoanDetail(LoanDetailsCompanion detail) =>
      into(loanDetail).insert(detail);

  Future<int> deleteLoanDetails(int loanId) =>
      (delete(loanDetail)..where((t) => t.loanId.equals(loanId))).go();
}
