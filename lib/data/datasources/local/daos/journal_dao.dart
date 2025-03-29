import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/journal_entries_table.dart';
import '../tables/journal_details_table.dart';

part 'journal_dao.g.dart';

@DriftAccessor(tables: [JournalEntry, JournalDetail])
class JournalDao extends DatabaseAccessor<AppDatabase> with _$JournalDaoMixin {
  JournalDao(AppDatabase db) : super(db);

  // Queries básicas para Journal Entry
  Future<List<JournalEntries>> getAllJournalEntries() => 
      (select(journalEntry)..orderBy([(t) => OrderingTerm.desc(t.date)])).get();
  
  Future<JournalEntries?> getJournalEntryById(int id) =>
      (select(journalEntry)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<List<JournalEntries>> watchAllJournalEntries() => 
      (select(journalEntry)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();
  
  // NUEVO: Stream para observar un diario específico
  Stream<JournalEntries?> watchJournalEntryById(int id) =>
      (select(journalEntry)..where((t) => t.id.equals(id))).watchSingleOrNull();
  
  // NUEVO: Obtener diarios por tipo de documento
  Future<List<JournalEntries>> getJournalEntriesByType(String documentTypeId) =>
      (select(journalEntry)
        ..where((t) => t.documentTypeId.equals(documentTypeId))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
      .get();
  
  // NUEVO: Obtener diarios por rango de fechas
  Future<List<JournalEntries>> getJournalEntriesByDateRange(DateTime startDate, DateTime endDate) =>
      (select(journalEntry)
        ..where((t) => t.date.isBiggerOrEqualValue(startDate) & 
                        t.date.isSmallerOrEqualValue(endDate))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
      .get();
  
  // NUEVO: Obtener diarios por cuenta contable
  Future<List<JournalEntries>> getJournalEntriesByAccount(int chartAccountId) {
    final query = select(journalEntry).join([
      innerJoin(
        journalDetail, 
        journalDetail.journalId.equalsExp(journalEntry.id),
      )
    ])
    ..where(journalDetail.chartAccountId.equals(chartAccountId));
    
    return query.get().then((rows) {
      // Extraer entradas únicas de journal_entry
      final Map<int, JournalEntries> uniqueEntries = {};
      for (final row in rows) {
        final entry = row.readTable(journalEntry);
        uniqueEntries[entry.id] = entry;
      }
      return uniqueEntries.values.toList()
        ..sort((a, b) => b.date.compareTo(a.date));
    });
  }
  
  // NUEVO: Obtener el siguiente secuencial para un tipo de documento
  Future<int> getNextSecuencial(String documentTypeId) async {
    final query = select(journalEntry)
      ..where((t) => t.documentTypeId.equals(documentTypeId))
      ..orderBy([(t) => OrderingTerm.desc(t.secuencial)])
      ..limit(1);
    
    final result = await query.getSingleOrNull();
    return (result?.secuencial ?? 0) + 1;
  }
  
  // NUEVO: Calcular balance de una cuenta
  Future<Map<String, double>> getAccountBalance(
    int chartAccountId, 
    DateTime? fromDate, 
    DateTime? toDate
  ) async {
    var query = select(journalDetail).join([
      innerJoin(
        journalEntry, 
        journalEntry.id.equalsExp(journalDetail.journalId),
      )
    ])
    ..where(journalDetail.chartAccountId.equals(chartAccountId));
    
    // Aplicar filtros de fecha si se proporcionan
    if (fromDate != null) {
      query = query..where(journalEntry.date.isBiggerOrEqualValue(fromDate));
    }
    
    if (toDate != null) {
      query = query..where(journalEntry.date.isSmallerOrEqualValue(toDate));
    }
    
    final results = await query.get();
    
    double totalDebit = 0.0;
    double totalCredit = 0.0;
    
    for (final row in results) {
      final detail = row.readTable(journalDetail);
      totalDebit += detail.debit;
      totalCredit += detail.credit;
    }
    
    return {
      'debit': totalDebit,
      'credit': totalCredit,
    };
  }

  // Queries para Journal Details
  Future<List<JournalDetails>> getJournalDetailsForEntry(int journalId) =>
      (select(journalDetail)..where((t) => t.journalId.equals(journalId))).get();

  // CRUD Operations para Journal Entry
  Future<int> insertJournalEntry(JournalEntriesCompanion entry) =>
      into(journalEntry).insert(entry);

  Future<bool> updateJournalEntry(JournalEntriesCompanion entry) =>
      update(journalEntry).replace(entry);

  Future<int> deleteJournalEntry(int id) =>
      (delete(journalEntry)..where((t) => t.id.equals(id))).go();

  // CRUD Operations para Journal Details
  Future<int> insertJournalDetail(JournalDetailsCompanion detail) =>
      into(journalDetail).insert(detail);

  Future<void> insertJournalDetails(List<JournalDetailsCompanion> details) async {
    await batch((batch) {
      batch.insertAll(journalDetail, details);
    });
  }

  Future<void> deleteJournalDetails(int journalId) =>
      (delete(journalDetail)..where((t) => t.journalId.equals(journalId))).go();
}
