import '../entities/journal_entry.dart';
import '../entities/journal_detail.dart';

abstract class JournalRepository {
  // Consultas básicas
  Future<List<JournalEntry>> getAllJournalEntries();
  Future<JournalEntry?> getJournalEntryById(int id);
  Future<List<JournalEntry>> getJournalEntriesByType(String documentTypeId);
  Future<List<JournalEntry>> getJournalEntriesByDate(DateTime startDate, DateTime endDate);
  
  // Observación en tiempo real
  Stream<List<JournalEntry>> watchAllJournalEntries();
  Stream<JournalEntry?> watchJournalEntryById(int id);
  
  // Operaciones CRUD
  Future<JournalEntry> createJournalEntry(JournalEntry entry, List<JournalDetail> details);
  Future<void> updateJournalEntry(JournalEntry entry);
  Future<void> deleteJournalEntry(int id);
  
  // Métodos especializados
  Future<int> getNextSecuencial(String documentTypeId);
  Future<List<JournalEntry>> getJournalEntriesByAccount(int chartAccountId);
  Future<Map<String, double>> getAccountBalance(int chartAccountId, {DateTime? fromDate, DateTime? toDate});
  
  // Métodos específicos para la generación de asientos contables
  Future<JournalEntry> createIncomeJournal({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int walletChartAccountId,
    required int categoryChartAccountId,
    double rateExchange,
  });
  
  Future<JournalEntry> createExpenseJournal({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int walletChartAccountId,
    required int categoryChartAccountId,
    double rateExchange,
  });
  
  Future<JournalEntry> createTransferJournal({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int sourceChartAccountId,
    required int targetChartAccountId,
    required String targetCurrencyId,
    required double targetAmount,
    required double rateExchange,
  });
}
