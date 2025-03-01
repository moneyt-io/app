import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/journal_entries_table.dart';
import '../tables/journal_details_table.dart';

part 'journal_dao.g.dart';

@DriftAccessor(tables: [JournalEntry, JournalDetail])
class JournalDao extends DatabaseAccessor<AppDatabase> with _$JournalDaoMixin {
  JournalDao(AppDatabase db) : super(db);

  // Queries básicas para Journal Entry
  Future<List<JournalEntries>> getAllJournalEntries() => select(journalEntry).get();
  
  Future<JournalEntries?> getJournalEntryById(int id) =>
      (select(journalEntry)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<List<JournalEntries>> watchAllJournalEntries() => select(journalEntry).watch();

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
