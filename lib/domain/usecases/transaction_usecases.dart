// lib/domain/usecases/transaction_usecases.dart
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class TransactionUseCases {
  final TransactionRepository repository;

  TransactionUseCases(this.repository);

  // Obtener todas las transacciones
  Stream<List<TransactionEntity>> watchAllTransactions() {
    return repository.watchAllTransactions();
  }

  // Crear una nueva transacción
  Future<int> createTransaction(TransactionEntity transaction) {
    return repository.insertTransaction(transaction);
  }

  // Actualizar una transacción existente
  Future<bool> updateTransaction(TransactionEntity transaction) {
    return repository.updateTransaction(transaction);
  }

  // Eliminar una transacción
  Future<bool> deleteTransaction(int id) {
    return repository.deleteTransaction(id);
  }

  // Crear una transferencia entre cuentas
  Future<void> createTransfer({
    required int fromAccountId,
    required int toAccountId,
    required double amount,
    required DateTime date,
    String? description,
    String? reference,
    String? contact,
  }) {
    return repository.createTransfer(
      fromAccountId: fromAccountId,
      toAccountId: toAccountId,
      amount: amount,
      date: date,
      description: description,
      reference: reference,
      contact: contact,
    );
  }

  // Obtener el balance de una cuenta
  Future<double> getAccountBalance(int accountId) {
    return repository.getAccountBalance(accountId);
  }

  // Observar transacciones por tipo
  Stream<List<TransactionEntity>> watchTransactionsByType(String type) {
    return repository.watchTransactionsByType(type);
  }

  // Observar transacciones por flujo
  Stream<List<TransactionEntity>> watchTransactionsByFlow(String flow) {
    return repository.watchTransactionsByFlow(flow);
  }

  // Observar transacciones por cuenta
  Stream<List<TransactionEntity>> watchTransactionsByAccount(int accountId) {
    return repository.watchTransactionsByAccount(accountId);
  }

  // Observar transacciones por categoría
  Stream<List<TransactionEntity>> watchTransactionsByCategory(int categoryId) {
    return repository.watchTransactionsByCategory(categoryId);
  }

  // Observar transacciones por rango de fechas
  Stream<List<TransactionEntity>> watchTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) {
    return repository.watchTransactionsByDateRange(startDate, endDate);
  }

  // Obtener una transacción por ID
  Future<TransactionEntity?> getTransactionById(int id) {
    return repository.getTransactionById(id);
  }
}