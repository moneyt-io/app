import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/journal_entries_table.dart';
import '../tables/journal_details_table.dart';

part 'journal_dao.g.dart';

@DriftAccessor(tables: [JournalEntry, JournalDetail])
class JournalDao extends DatabaseAccessor<AppDatabase> with _$JournalDaoMixin {
  JournalDao(AppDatabase db) : super(db);

  // Queries básicas
  Future<List<JournalEntries>> getAllJournalEntries() => 
      (select(journalEntry)
        ..where((t) => t.active.equals(true))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();

  Future<JournalEntries?> getJournalEntryById(int id) =>
      (select(journalEntry)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<List<JournalDetails>> getJournalDetailsForEntry(int journalId) =>
      (select(journalDetail)..where((t) => t.journalId.equals(journalId)))
          .get(); // REMOVIDO: filtro por active

  // Watch Queries
  Stream<List<JournalEntries>> watchAllJournalEntries() =>
      (select(journalEntry)
        ..where((t) => t.active.equals(true))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();

  // Queries especializadas
  Future<List<JournalEntries>> getJournalEntriesByType(String documentTypeId) =>
      (select(journalEntry)
        ..where((t) => t.documentTypeId.equals(documentTypeId) & t.active.equals(true))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();

  Future<List<JournalEntries>> getJournalEntriesByDateRange(DateTime startDate, DateTime endDate) =>
      (select(journalEntry)
        ..where((t) => t.date.isBetweenValues(startDate, endDate) & t.active.equals(true))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();

  // MÉTODO AGREGADO PARA REPORTES
  Future<List<JournalEntries>> getJournalsByDateRange(DateTime startDate, DateTime endDate) =>
      (select(journalEntry)
        ..where((j) => j.date.isBetweenValues(startDate, endDate) & j.active.equals(true))
        ..orderBy([(j) => OrderingTerm.desc(j.date)]))
        .get();

  // CRUD Operations para Entry
  Future<int> insertJournalEntry(JournalEntriesCompanion entry) =>
      into(journalEntry).insert(entry);

  Future<bool> updateJournalEntry(JournalEntriesCompanion entry) =>
      update(journalEntry).replace(entry);

  Future<int> deleteJournalEntry(int id) =>
      (delete(journalEntry)..where((t) => t.id.equals(id))).go();

  // CRUD Operations para Details
  Future<int> insertJournalDetail(JournalDetailsCompanion detail) =>
      into(journalDetail).insert(detail);

  Future<bool> updateJournalDetail(JournalDetailsCompanion detail) =>
      update(journalDetail).replace(detail);

  Future<int> deleteJournalDetails(int journalId) =>
      (delete(journalDetail)..where((t) => t.journalId.equals(journalId))).go();

  Future<List<JournalDetails>> getJournalDetailsByAccount(int chartAccountId) =>
      (select(journalDetail)
        ..where((t) => t.chartAccountId.equals(chartAccountId)))
        .get(); // REMOVIDO: filtro por active

  // Utilidades
  Future<int> getNextSecuencial(String documentTypeId) async {
    final lastEntry = await (select(journalEntry)
      ..where((t) => t.documentTypeId.equals(documentTypeId))
      ..orderBy([(t) => OrderingTerm.desc(t.secuencial)])
      ..limit(1)).getSingleOrNull();
    
    return (lastEntry?.secuencial ?? 0) + 1;
  }

  // Métodos para balance de cuentas
  Future<Map<String, double>> getAccountBalance(int chartAccountId, {DateTime? fromDate, DateTime? toDate}) async {
    var query = select(journalDetail).join([
      innerJoin(journalEntry, journalEntry.id.equalsExp(journalDetail.journalId))
    ])..where(journalDetail.chartAccountId.equals(chartAccountId)); // REMOVIDO: filtro por active em journalDetail

    if (fromDate != null && toDate != null) {
      query = query..where(journalEntry.date.isBetweenValues(fromDate, toDate));
    }

    final results = await query.get();
    
    double totalDebit = 0.0;
    double totalCredit = 0.0;
    
    for (final row in results) {
      final detail = row.readTable(journalDetail);
      totalDebit += detail.debit ?? 0.0;
      totalCredit += detail.credit ?? 0.0;
    }
    
    return {
      'debit': totalDebit,
      'credit': totalCredit,
      'balance': totalDebit - totalCredit,
    };
  }
}
