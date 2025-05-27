import '../entities/journal_entry.dart';
import '../entities/journal_detail.dart';

abstract class JournalRepository {
  // Métodos básicos existentes
  Future<List<JournalEntry>> getAllJournalEntries();
  Future<JournalEntry?> getJournalEntryById(int id);
  Future<List<JournalEntry>> getJournalEntriesByType(String documentTypeId);
  Future<List<JournalEntry>> getJournalEntriesByDate(DateTime startDate, DateTime endDate);
  Future<List<JournalEntry>> getJournalEntriesByAccount(int chartAccountId);
  
  // Observación en tiempo real
  Stream<List<JournalEntry>> watchAllJournalEntries();
  Stream<JournalEntry?> watchJournalEntryById(int id);
  
  // Operaciones CRUD
  Future<JournalEntry> createJournalEntry(JournalEntry entry, List<JournalDetail> details);
  Future<void> updateJournalEntry(JournalEntry entry);
  Future<void> deleteJournalEntry(int id);
  
  // Métodos utilitarios
  Future<int> getNextSecuencial(String documentTypeId);
  Future<Map<String, double>> getAccountBalance(int chartAccountId, {DateTime? fromDate, DateTime? toDate});
  
  // Métodos especializados para tipos de journal
  Future<JournalEntry> createIncomeJournal({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int walletChartAccountId,
    required int categoryChartAccountId,
    double rateExchange = 1.0,
  });
  
  Future<JournalEntry> createExpenseJournal({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int walletChartAccountId,
    required int categoryChartAccountId,
    double rateExchange = 1.0,
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
    double rateExchange = 1.0,
  });
  
  Future<JournalEntry> createCreditCardPaymentJournal({
    required DateTime date,
    String? description,
    required double amount,
    required String currencyId,
    required int sourceWalletChartAccountId,
    required int targetCreditCardChartAccountId,
    required String targetCurrencyId,
    required double targetAmount,
    double rateExchange = 1.0,
  });

  // Métodos para préstamos - AGREGADOS
  Future<JournalEntry> createJournal({
    required String documentTypeId,
    required DateTime date,
    required String description,
  });

  Future<void> createJournalDetails(List<JournalDetail> details);

  // Métodos helper para préstamos - AGREGADOS (temporalmente como dynamic)
  Future<dynamic> getLoanById(int loanId);
  Future<dynamic> getWalletById(int walletId);

  // MÉTODOS ESPECIALIZADOS PARA PRÉSTAMOS
  Future<JournalEntry> createLendFromCreditCardJournal({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int receivableAccountId,
    required int creditCardAccountId,
    double rateExchange = 1.0,
  });

  Future<JournalEntry> createLendFromServiceJournal({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int receivableAccountId,
    required int incomeAccountId,
    double rateExchange = 1.0,
  });

  Future<JournalEntry> createBorrowFromServiceJournal({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int expenseAccountId,
    required int payableAccountId,
    double rateExchange = 1.0,
  });

  // MÉTODOS PARA VALIDACIONES CONTABLES
  Future<bool> validateJournalBalance(List<JournalDetail> details);
  
  // MÉTODOS PARA REPORTES
  Future<Map<String, double>> getTrialBalance({DateTime? fromDate, DateTime? toDate});
  Future<List<JournalEntry>> getJournalsByDateRange(DateTime startDate, DateTime endDate);
}
