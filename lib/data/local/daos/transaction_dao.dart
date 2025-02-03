import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/transaction_table.dart';

part 'transaction_dao.g.dart';

@DriftAccessor(tables: [Transactions])
class TransactionDao extends DatabaseAccessor<AppDatabase> with _$TransactionDaoMixin {
  TransactionDao(AppDatabase db) : super(db);

  // Métodos básicos
  Future<List<Transaction>> getAllTransactions() => select(transactions).get();
  Stream<List<Transaction>> watchAllTransactions() => select(transactions).watch();
  
  Future<Transaction> getTransactionById(int id) =>
      (select(transactions)..where((t) => t.id.equals(id))).getSingle();

  // Método de inserción simplificado
  Future<int> insertTransaction(Transaction transaction) =>
      into(transactions).insert(transaction);

  Future<bool> updateTransaction(Transaction transaction) =>
      update(transactions).replace(transaction);

  Future<int> deleteTransaction(int id) =>
      (delete(transactions)..where((t) => t.id.equals(id))).go();

  // Método de transferencia simplificado
  Future<void> createTransfer({
    required int fromAccountId,
    required int toAccountId,
    required double amount,
    required DateTime date,
    String? description,
    String? reference,
    int? contactId,
  }) async {
    final now = DateTime.now();
    
    // Crear transacción de salida usando el constructor básico
    final outgoing = Transaction(
      id: 0,  // Se auto-incrementará
      type: TRANSACTION_TYPE_TRANSFER,
      flow: FLOW_TYPE_OUTFLOW,
      amount: amount,
      accountId: fromAccountId,
      categoryId: null,
      contactId: contactId,
      reference: reference,
      description: description,
      transactionDate: date,
      createdAt: now,
      updatedAt: now,
      status: true,
    );

    // Crear transacción de entrada usando el constructor básico
    final incoming = Transaction(
      id: 0,  // Se auto-incrementará
      type: TRANSACTION_TYPE_TRANSFER,
      flow: FLOW_TYPE_INFLOW,
      amount: amount,
      accountId: toAccountId,
      categoryId: null,
      contactId: contactId,
      reference: reference,
      description: description,
      transactionDate: date,
      createdAt: now,
      updatedAt: now,
      status: true,
    );

    await transaction(() async {
      await insertTransaction(outgoing);
      await insertTransaction(incoming);
    });
  }

  // Simplificamos el upsert también
  Future<void> upsertTransaction(Insertable<Transaction> transaction) =>
      into(transactions).insertOnConflictUpdate(transaction);

  Future<List<Transaction>> getTransactionsByAccount(int accountId) =>
      (select(transactions)..where((t) => t.accountId.equals(accountId))).get();

  Future<List<Transaction>> getTransactionsByCategory(int categoryId) =>
      (select(transactions)..where((t) => t.categoryId.equals(categoryId))).get();

  Future<List<Transaction>> getTransactionsByType(String type) =>
      (select(transactions)..where((t) => t.type.equals(type))).get();

  Stream<List<Transaction>> watchTransactionsByType(String type) =>
      (select(transactions)..where((t) => t.type.equals(type))).watch();

  Stream<List<Transaction>> watchTransactionsByFlow(String flow) =>
      (select(transactions)..where((t) => t.flow.equals(flow))).watch();

  Stream<List<Transaction>> watchTransactionsByAccount(int accountId) =>
      (select(transactions)..where((t) => t.accountId.equals(accountId))).watch();

  Stream<List<Transaction>> watchTransactionsByCategory(int categoryId) =>
      (select(transactions)..where((t) => t.categoryId.equals(categoryId))).watch();

  Stream<List<Transaction>> watchTransactionsByContact(int contactId) =>
      (select(transactions)..where((t) => t.contactId.equals(contactId))).watch();

  Stream<List<Transaction>> watchTransactionsByTypeAndFlow(String type, String flow) =>
      (select(transactions)
        ..where((t) => t.type.equals(type) & t.flow.equals(flow)))
        .watch();

  Future<double> getAccountBalance(int accountId) async {
    final inflows = await (selectOnly(transactions)
      ..where(transactions.accountId.equals(accountId) & transactions.flow.equals(FLOW_TYPE_INFLOW))
      ..addColumns([transactions.amount.sum()]))
        .getSingleOrNull();

    final outflows = await (selectOnly(transactions)
      ..where(transactions.accountId.equals(accountId) & transactions.flow.equals(FLOW_TYPE_OUTFLOW))
      ..addColumns([transactions.amount.sum()]))
        .getSingleOrNull();

    final inflowAmount = (inflows?.read(transactions.amount.sum()) ?? 0.0) as double;
    final outflowAmount = (outflows?.read(transactions.amount.sum()) ?? 0.0) as double;
    
    return inflowAmount - outflowAmount;
  }

  Stream<double> watchAccountBalance(int accountId) {
    final query = customSelect(
      'SELECT COALESCE(SUM(CASE WHEN flow = ? THEN amount ELSE -amount END), 0.0) as balance '
      'FROM transactions WHERE account_id = ?',
      variables: [Variable.withString(FLOW_TYPE_INFLOW), Variable.withInt(accountId)],
      readsFrom: {transactions},
    );
    return query.watchSingle().map((row) => row.read<double>('balance'));
  }

  Stream<Map<int, double>> watchAllAccountBalances() {
    final query = customSelect(
      'SELECT account_id, '
      'COALESCE(SUM(CASE WHEN flow = ? THEN amount ELSE -amount END), 0.0) as balance '
      'FROM transactions GROUP BY account_id',
      variables: [Variable.withString(FLOW_TYPE_INFLOW)],
      readsFrom: {transactions},
    );
    return query.watch().map((rows) {
      final balances = <int, double>{};
      for (final row in rows) {
        balances[row.read<int>('account_id')] = row.read<double>('balance');
      }
      return balances;
    });
  }

  Stream<List<Transaction>> watchTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) =>
      (select(transactions)
        ..where((t) =>
            t.transactionDate.isBiggerOrEqualValue(startDate) & 
            t.transactionDate.isSmallerOrEqualValue(endDate)))
        .watch();

  Future<List<Transaction>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) =>
      (select(transactions)
        ..where((t) =>
            t.transactionDate.isBiggerOrEqualValue(startDate) & 
            t.transactionDate.isSmallerOrEqualValue(endDate)))
        .get();
}
