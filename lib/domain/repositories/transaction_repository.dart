// lib/domain/repositories/transaction_repository.dart
import '../entities/transaction.dart';

abstract class TransactionRepository {
  // Observar transacciones
  Stream<List<TransactionEntity>> watchAllTransactions();
  Stream<List<TransactionEntity>> watchTransactionsByType(String type);
  Stream<List<TransactionEntity>> watchTransactionsByFlow(String flow);
  Stream<List<TransactionEntity>> watchTransactionsByAccount(int accountId);
  Stream<List<TransactionEntity>> watchTransactionsByCategory(int categoryId);
  Stream<List<TransactionEntity>> watchTransactionsByDateRange(DateTime startDate, DateTime endDate);

  // Operaciones CRUD
  Future<TransactionEntity?> getTransactionById(int id);
  Future<int> createTransaction(TransactionEntity transaction);
  Future<bool> updateTransaction(TransactionEntity transaction);
  Future<bool> deleteTransaction(int id);

  // Operaciones específicas
  Future<double> getAccountBalance(int accountId);
  Future<void> createTransfer({
    required int fromAccountId,
    required int toAccountId,
    required double amount,
    required DateTime date,
    String? description,
    String? reference,
    String? contact,
  });
}