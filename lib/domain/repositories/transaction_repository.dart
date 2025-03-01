// lib/domain/repositories/transaction_repository.dart
import '../entities/transaction_entry.dart';
import '../entities/transaction_detail.dart';

abstract class TransactionRepository {
  // Queries básicas
  Future<List<TransactionEntry>> getAllTransactions();
  Future<TransactionEntry?> getTransactionById(int id);
  Future<List<TransactionEntry>> getTransactionsByType(String documentTypeId);
  Stream<List<TransactionEntry>> watchAllTransactions();
  
  // CRUD Operations
  Future<TransactionEntry> createTransaction(TransactionEntry transaction, List<TransactionDetail> details);
  Future<void> updateTransaction(TransactionEntry transaction);
  Future<void> deleteTransaction(int id);

  // Operaciones específicas
  Future<void> createTransfer({
    required int fromAccountId,
    required int toAccountId,
    required double amount,
    required DateTime date,
    String? description,
    int? contactId,
  });
}