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
    required String currencyId,
    required int sourcePaymentId,
    required int targetPaymentId,
    required String targetPaymentTypeId,
    required String targetCurrencyId,
    required double targetAmount,
    required double rateExchange,
    int? contactId,
  });

  /// Crea una transacción de pago de tarjeta de crédito
  Future<TransactionEntry> createCreditCardPaymentTransaction({
    required int journalId,
    required DateTime date,
    String? description,
    required double amount,
    required String currencyId,
    required int sourceWalletId,
    required int targetCreditCardId,
    required String targetCurrencyId,
    required double targetAmount,
    double rateExchange = 1.0,
  });

  // Métodos de consulta específicos para tarjetas de crédito
  Future<List<TransactionEntry>> getTransactionsByPaymentTypeAndId(String paymentTypeId, int paymentId);
  Future<List<TransactionEntry>> getTransactionsByCreditCardPayment(int creditCardId);

  // Utilitarios
  Future<int> getNextSecuencial(String documentTypeId);
}