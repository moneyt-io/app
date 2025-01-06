// lib/data/repositories/transaction_repository_impl.dart
import 'package:drift/drift.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../local/daos/transaction_dao.dart';
import '../local/database.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDao _transactionDao;

  TransactionRepositoryImpl(this._transactionDao);

  // Convertir Transaction (Drift) a TransactionEntity
  TransactionEntity _mapToEntity(Transaction transaction) {
    return TransactionEntity(
      id: transaction.id,
      type: transaction.type,
      flow: transaction.flow,
      amount: transaction.amount,
      accountId: transaction.accountId,
      categoryId: transaction.categoryId,
      reference: transaction.reference,
      contactId: transaction.contactId,
      description: transaction.description,
      transactionDate: transaction.transactionDate,
      createdAt: transaction.createdAt,
      updatedAt: transaction.updatedAt,
    );
  }

  // Convertir TransactionEntity a TransactionsCompanion
  TransactionsCompanion _mapToCompanion(TransactionEntity transaction) {
    return TransactionsCompanion(
      id: transaction.id == null 
          ? const Value.absent() 
          : Value(transaction.id!),
      type: Value(transaction.type),
      flow: Value(transaction.flow),
      amount: Value(transaction.amount),
      accountId: Value(transaction.accountId),
      categoryId: transaction.categoryId == null 
          ? const Value.absent() 
          : Value(transaction.categoryId!),
      reference: transaction.reference == null 
          ? const Value.absent() 
          : Value(transaction.reference!),
      contactId: transaction.contactId == null 
          ? const Value.absent() 
          : Value(transaction.contactId!),
      description: transaction.description == null 
          ? const Value.absent() 
          : Value(transaction.description!),
      transactionDate: Value(transaction.transactionDate),
      createdAt: transaction.createdAt == null 
          ? Value(DateTime.now()) 
          : Value(transaction.createdAt!),
      updatedAt: Value(DateTime.now()),
    );
  }

  @override
  Stream<List<TransactionEntity>> watchAllTransactions() {
    return _transactionDao.watchAllTransactions()
        .map((list) => list.map(_mapToEntity).toList());
  }

  @override
  Stream<List<TransactionEntity>> watchTransactionsByType(String type) {
    return _transactionDao.watchTransactionsByType(type)
        .map((list) => list.map(_mapToEntity).toList());
  }

  @override
  Stream<List<TransactionEntity>> watchTransactionsByFlow(String flow) {
    return _transactionDao.watchTransactionsByFlow(flow)
        .map((list) => list.map(_mapToEntity).toList());
  }

  @override
  Stream<List<TransactionEntity>> watchTransactionsByAccount(int accountId) {
    return _transactionDao.watchTransactionsByAccount(accountId)
        .map((list) => list.map(_mapToEntity).toList());
  }

  @override
  Stream<List<TransactionEntity>> watchTransactionsByCategory(int categoryId) {
    return _transactionDao.watchTransactionsByCategory(categoryId)
        .map((list) => list.map(_mapToEntity).toList());
  }

  @override
  Stream<List<TransactionEntity>> watchTransactionsByContact(int contactId) {
    return _transactionDao.watchTransactionsByContact(contactId)
        .map((list) => list.map(_mapToEntity).toList());
  }

  @override
  Stream<List<TransactionEntity>> watchTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) {
    return _transactionDao.watchTransactionsByDateRange(startDate, endDate)
        .map((list) => list.map(_mapToEntity).toList());
  }

  @override
  Future<TransactionEntity?> getTransactionById(int id) async {
    try {
      final transaction = await _transactionDao.getTransactionById(id);
      return _mapToEntity(transaction);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<int> insertTransaction(TransactionEntity transaction) async {
    return await _transactionDao.insertTransaction(_mapToCompanion(transaction));
  }

  @override
  Future<bool> updateTransaction(TransactionEntity transaction) async {
    return await _transactionDao.updateTransaction(_mapToCompanion(transaction));
  }

  @override
  Future<bool> deleteTransaction(int id) async {
    final result = await _transactionDao.deleteTransaction(id);
    return result > 0;
  }

  @override
  Future<double> getAccountBalance(int accountId) async {
    return await _transactionDao.getAccountBalance(accountId);
  }

  @override
  Stream<Map<int, double>> watchAllAccountBalances() {
    return _transactionDao.watchAllAccountBalances();
  }

  @override
  Stream<double> watchAccountBalance(int accountId) {
    return _transactionDao.watchAccountBalance(accountId);
  }

  @override
  Stream<List<TransactionEntity>> watchTransactionsByTypeAndFlow(String type, String flow) {
    return _transactionDao.watchTransactionsByTypeAndFlow(type, flow)
        .map((transactions) => transactions.map(_mapToEntity).toList());
  }

  @override
  Future<void> createTransfer({
    required int fromAccountId,
    required int toAccountId,
    required double amount,
    required DateTime date,
    String? description,
    String? reference,
    int? contactId,
  }) async {
    await _transactionDao.createTransfer(
      fromAccountId: fromAccountId,
      toAccountId: toAccountId,
      amount: amount,
      date: date,
      description: description,
      reference: reference,
      contactId: contactId,
    );
  }
}
