import '../entities/journal_entry.dart';
import '../entities/journal_detail.dart';

abstract class JournalRepository {
  // Queries básicas
  Future<List<JournalEntry>> getAllJournalEntries();
  Future<JournalEntry?> getJournalEntryById(int id);
  Stream<List<JournalEntry>> watchAllJournalEntries();
  
  // CRUD Operations
  Future<JournalEntry> createJournalEntry(JournalEntry entry, List<JournalDetail> details);
  Future<void> updateJournalEntry(JournalEntry entry);
  Future<void> deleteJournalEntry(int id);
}
