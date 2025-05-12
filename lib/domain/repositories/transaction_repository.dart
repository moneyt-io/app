// lib/domain/repositories/transaction_repository.dart
import '../entities/transaction_entry.dart';
import '../entities/transaction_detail.dart';

abstract class TransactionRepository {
  // Consultas básicas
  Future<List<TransactionEntry>> getAllTransactions();
  Future<TransactionEntry?> getTransactionById(int id);
  Future<List<TransactionEntry>> getTransactionsByType(String documentTypeId);
  Stream<List<TransactionEntry>> watchAllTransactions();
  
  // CRUD Operations
  Future<TransactionEntry> createTransaction(TransactionEntry transaction, List<TransactionDetail> details);
  Future<void> updateTransaction(TransactionEntry transaction);
  Future<void> deleteTransaction(int id);

  // Métodos específicos por tipo
  Future<TransactionEntry> createIncomeTransaction({
    required int journalId,
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int walletId,
    required int categoryId,
    int? contactId,
    double rateExchange = 1.0,
  });
  
  Future<TransactionEntry> createExpenseTransaction({
    required int journalId,
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required String paymentTypeId, // Añadir este parámetro
    required int paymentId,
    required int categoryId,
    int? contactId,
    double rateExchange = 1.0,
  });
  
  Future<TransactionEntry> createTransferTransaction({
    required int journalId,
    required DateTime date,
    required String description,
    required double amount,
    required int sourceWalletId,
    required int targetWalletId,
    required double targetAmount,
    required double rateExchange,
    int? contactId,
  });
  
  // Utilitarios
  Future<int> getNextSecuencial(String documentTypeId);
}