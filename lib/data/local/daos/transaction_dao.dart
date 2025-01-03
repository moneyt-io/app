// lib/data/local/daos/transaction_dao.dart
import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/transaction_table.dart';

part 'transaction_dao.g.dart';

@DriftAccessor(tables: [Transactions])
class TransactionDao extends DatabaseAccessor<AppDatabase> with _$TransactionDaoMixin {
  TransactionDao(AppDatabase db) : super(db);

  // Observar todas las transacciones activas
  Stream<List<Transaction>> watchAllTransactions() {
    return (select(transactions)
      ..where((t) => t.status.equals(true))
      ..orderBy([
        (t) => OrderingTerm(
              expression: t.transactionDate,
              mode: OrderingMode.desc,
            ),
      ]))
        .watch();
  }

  // Observar transacciones por tipo
  Stream<List<Transaction>> watchTransactionsByType(String type) {
    return (select(transactions)
      ..where((t) => t.type.equals(type) & t.status.equals(true))
      ..orderBy([(t) => OrderingTerm(expression: t.transactionDate, mode: OrderingMode.desc)]))
        .watch();
  }

  // Observar transacciones por flujo (entrada/salida)
  Stream<List<Transaction>> watchTransactionsByFlow(String flow) {
    return (select(transactions)
      ..where((t) => t.flow.equals(flow) & t.status.equals(true))
      ..orderBy([(t) => OrderingTerm(expression: t.transactionDate, mode: OrderingMode.desc)]))
        .watch();
  }

  // Observar transacciones por tipo y flujo
  Stream<List<Transaction>> watchTransactionsByTypeAndFlow(String type, String flow) {
    return (select(transactions)
      ..where((t) => t.type.equals(type) & t.flow.equals(flow) & t.status.equals(true))
      ..orderBy([(t) => OrderingTerm(expression: t.transactionDate, mode: OrderingMode.desc)]))
        .watch();
  }

  // Observar transacciones por cuenta
  Stream<List<Transaction>> watchTransactionsByAccount(int accountId) {
    return (select(transactions)
      ..where((t) => t.accountId.equals(accountId) & t.status.equals(true))
      ..orderBy([(t) => OrderingTerm(expression: t.transactionDate, mode: OrderingMode.desc)]))
        .watch();
  }

  // Observar transacciones por categoría
  Stream<List<Transaction>> watchTransactionsByCategory(int categoryId) {
    return (select(transactions)
      ..where((t) => t.categoryId.equals(categoryId) & t.status.equals(true))
      ..orderBy([(t) => OrderingTerm(expression: t.transactionDate, mode: OrderingMode.desc)]))
        .watch();
  }

  // Observar transacciones por contacto
  Stream<List<Transaction>> watchTransactionsByContact(int contactId) {
    return (select(transactions)
      ..where((t) => t.contactId.equals(contactId) & t.status.equals(true))
      ..orderBy([(t) => OrderingTerm(expression: t.transactionDate, mode: OrderingMode.desc)]))
        .watch();
  }

  // Obtener una transacción por ID
  Future<Transaction?> getTransactionById(int id) =>
      (select(transactions)..where((t) => t.id.equals(id))).getSingleOrNull();

  // Insertar una nueva transacción
  Future<int> insertTransaction(TransactionsCompanion transaction) =>
      into(transactions).insert(transaction);

  // Insertar múltiples transacciones (útil para transferencias)
  Future<void> insertMultipleTransactions(List<TransactionsCompanion> transactions) async {
    await batch((batch) {
      batch.insertAll(this.transactions, transactions);
    });
  }

  // Actualizar una transacción
  Future<bool> updateTransaction(TransactionsCompanion transaction) async {
    return await update(transactions).replace(transaction);
  }

  // Eliminar una transacción (borrado lógico)
  Future<bool> deleteTransaction(int id) async {
    final result = await (update(transactions)..where((t) => t.id.equals(id)))
        .write(const TransactionsCompanion(status: Value(false)));
    return result > 0;
  }

  // Obtener transacciones por rango de fechas
  Stream<List<Transaction>> watchTransactionsByDateRange(
      DateTime startDate, DateTime endDate) {
    return (select(transactions)
      ..where((t) => t.transactionDate.isBetweenValues(startDate, endDate) & 
                     t.status.equals(true))
      ..orderBy([(t) => OrderingTerm(expression: t.transactionDate, mode: OrderingMode.desc)]))
        .watch();
  }

  // Obtener el balance de una cuenta
  Future<double> getAccountBalance(int accountId) async {
    final query = select(transactions)
      ..where((t) => t.accountId.equals(accountId) & t.status.equals(true));

    final results = await query.get();
    double balance = 0;

    for (final transaction in results) {
      if (transaction.flow == FLOW_TYPE_INFLOW) {
        balance += transaction.amount;
      } else if (transaction.flow == FLOW_TYPE_OUTFLOW) {
        balance -= transaction.amount;
      }
    }
    return balance;
  }

  // Observar el balance de una cuenta
  Stream<double> watchAccountBalance(int accountId) {
    final query = select(transactions)
      ..where((t) => t.accountId.equals(accountId) & t.status.equals(true));

    return query.watch().map((transactions) {
      double balance = 0;
      for (final transaction in transactions) {
        if (transaction.flow == FLOW_TYPE_INFLOW) {
          balance += transaction.amount;
        } else if (transaction.flow == FLOW_TYPE_OUTFLOW) {
          balance -= transaction.amount;
        }
      }
      return balance;
    });
  }

  // Obtener el balance de todas las cuentas en una sola consulta
  Stream<Map<int, double>> watchAllAccountBalances() {
    return (select(transactions)..where((t) => t.status.equals(true)))
        .watch()
        .map((transactions) {
      final balances = <int, double>{};
      for (final transaction in transactions) {
        final currentBalance = balances[transaction.accountId] ?? 0.0;
        balances[transaction.accountId] = currentBalance + 
            (transaction.flow == FLOW_TYPE_INFLOW ? transaction.amount : -transaction.amount);
      }
      return balances;
    });
  }

  // Crear una transferencia entre cuentas
  Future<void> createTransfer({
    required int fromAccountId,
    required int toAccountId,
    required double amount,
    required DateTime date,
    String? description,
    String? reference,
    int? contactId,
  }) async {
    // Crear la transacción de salida
    final outflowTransaction = TransactionsCompanion(
      type: const Value(TRANSACTION_TYPE_TRANSFER),
      flow: const Value(FLOW_TYPE_OUTFLOW),
      amount: Value(amount),
      accountId: Value(fromAccountId),
      transactionDate: Value(date),
      description: Value(description),
      reference: Value(reference),
      contactId: Value(contactId),
    );

    // Crear la transacción de entrada
    final inflowTransaction = TransactionsCompanion(
      type: const Value(TRANSACTION_TYPE_TRANSFER),
      flow: const Value(FLOW_TYPE_INFLOW),
      amount: Value(amount),
      accountId: Value(toAccountId),
      transactionDate: Value(date),
      description: Value(description),
      reference: Value(reference),
      contactId: Value(contactId),
    );

    // Insertar ambas transacciones en una sola operación
    await insertMultipleTransactions([outflowTransaction, inflowTransaction]);
  }
}