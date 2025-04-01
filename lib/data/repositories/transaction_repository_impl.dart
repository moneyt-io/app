import 'package:injectable/injectable.dart';
import '../../domain/entities/transaction_entry.dart';
import '../../domain/entities/transaction_detail.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/repositories/journal_repository.dart';
import '../datasources/local/daos/transaction_dao.dart';
import '../models/transaction_entry_model.dart';
import '../models/transaction_detail_model.dart';

@Injectable(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDao _dao;
  final JournalRepository _journalRepository;

  TransactionRepositoryImpl(this._dao, this._journalRepository);

  @override
  Future<List<TransactionEntry>> getAllTransactions() async {
    final entries = await _dao.getAllTransactions();
    return Future.wait(entries.map((entry) async {
      final details = await _dao.getTransactionDetailsForEntry(entry.id);
      return TransactionEntryModel(
        id: entry.id,
        documentTypeId: entry.documentTypeId,
        currencyId: entry.currencyId,
        journalId: entry.journalId,
        contactId: entry.contactId,
        secuencial: entry.secuencial,
        date: entry.date,
        amount: entry.amount,
        rateExchange: entry.rateExchange,
        description: entry.description,
        active: entry.active,
        createdAt: entry.createdAt,
        updatedAt: entry.updatedAt,
        deletedAt: entry.deletedAt,
      ).toEntity(
        details: details.map((detail) => TransactionDetailModel(
          id: detail.id,
          transactionId: detail.transactionId,
          currencyId: detail.currencyId,
          flowId: detail.flowId,
          paymentTypeId: detail.paymentTypeId,
          paymentId: detail.paymentId,
          categoryId: detail.categoryId,
          amount: detail.amount,
          rateExchange: detail.rateExchange,
        ).toEntity()).toList(),
      );
    }));
  }

  @override
  Stream<List<TransactionEntry>> watchAllTransactions() {
    return _dao.watchAllTransactions().asyncMap((entries) async {
      return Future.wait(entries.map((entry) async {
        final details = await _dao.getTransactionDetailsForEntry(entry.id);
        return TransactionEntryModel(
          id: entry.id,
          documentTypeId: entry.documentTypeId,
          currencyId: entry.currencyId,
          journalId: entry.journalId,
          contactId: entry.contactId,
          secuencial: entry.secuencial,
          date: entry.date,
          amount: entry.amount,
          rateExchange: entry.rateExchange,
          description: entry.description,
          active: entry.active,
          createdAt: entry.createdAt,
          updatedAt: entry.updatedAt,
          deletedAt: entry.deletedAt,
        ).toEntity(
          details: details.map((detail) => TransactionDetailModel(
            id: detail.id,
            transactionId: detail.transactionId,
            currencyId: detail.currencyId,
            flowId: detail.flowId,
            paymentTypeId: detail.paymentTypeId,
            paymentId: detail.paymentId,
            categoryId: detail.categoryId,
            amount: detail.amount,
            rateExchange: detail.rateExchange,
          ).toEntity()).toList(),
        );
      }));
    });
  }

  @override
  Future<TransactionEntry?> getTransactionById(int id) async {
    final entry = await _dao.getTransactionById(id);
    if (entry == null) return null;

    final details = await _dao.getTransactionDetailsForEntry(entry.id);
    return TransactionEntryModel(
      id: entry.id,
      documentTypeId: entry.documentTypeId,
      currencyId: entry.currencyId,
      journalId: entry.journalId,
      contactId: entry.contactId,
      secuencial: entry.secuencial,
      date: entry.date,
      amount: entry.amount,
      rateExchange: entry.rateExchange,
      description: entry.description,
      active: entry.active,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
      deletedAt: entry.deletedAt,
    ).toEntity(
      details: details.map((detail) => TransactionDetailModel(
        id: detail.id,
        transactionId: detail.transactionId,
        currencyId: detail.currencyId,
        flowId: detail.flowId,
        paymentTypeId: detail.paymentTypeId,
        paymentId: detail.paymentId,
        categoryId: detail.categoryId,
        amount: detail.amount,
        rateExchange: detail.rateExchange
      ).toEntity()).toList(),
    );
  }

  @override
  Future<TransactionEntry> createTransaction(
    TransactionEntry entry,
    List<TransactionDetail> details
  ) async {
    final model = TransactionEntryModel.fromEntity(entry);
    final id = await _dao.insertTransaction(model.toCompanion());

    // Insertar detalles
    for (var detail in details) {
      final detailModel = TransactionDetailModel.create(
        transactionId: id,
        currencyId: detail.currencyId,
        flowId: detail.flowId,
        paymentTypeId: detail.paymentTypeId,
        paymentId: detail.paymentId,
        categoryId: detail.categoryId,
        amount: detail.amount,
        rateExchange: detail.rateExchange,
      );
      await _dao.insertTransactionDetail(detailModel.toCompanion());
    }

    final createdTransaction = await getTransactionById(id);
    if (createdTransaction == null) {
      throw Exception('Failed to create transaction');
    }
    return createdTransaction;
  }

  @override
  Future<void> updateTransaction(TransactionEntry transaction) async {
    final model = TransactionEntryModel.fromEntity(transaction);
    await _dao.updateTransaction(model.toCompanion());
    // Note: Details update should be handled separately if needed
  }

  @override
  Future<void> deleteTransaction(int id) async {
    // Primero eliminamos los detalles usando el método correcto
    await _dao.deleteTransactionDetails(id);
    // Luego eliminamos la entrada principal
    await _dao.deleteTransaction(id);
  }

  @override
  Future<void> createTransfer({
    required int fromAccountId,
    required int toAccountId,
    required double amount,
    required DateTime date,
    String? description,
    int? contactId,
  }) async {
    // TODO: Implementar lógica de transferencia
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionEntry>> getTransactionsByType(String documentTypeId) async {
    final entries = await _dao.getTransactionsByType(documentTypeId);
    return Future.wait(entries.map((entry) async {
      final details = await _dao.getTransactionDetailsForEntry(entry.id);
      return TransactionEntryModel(
        id: entry.id,
        documentTypeId: entry.documentTypeId,
        currencyId: entry.currencyId,
        journalId: entry.journalId,
        contactId: entry.contactId,
        secuencial: entry.secuencial,
        date: entry.date,
        amount: entry.amount,
        rateExchange: entry.rateExchange,
        description: entry.description,
        active: entry.active,
        createdAt: entry.createdAt,
        updatedAt: entry.updatedAt,
        deletedAt: entry.deletedAt,
      ).toEntity(
        details: details.map((detail) => TransactionDetailModel(
          id: detail.id,
          transactionId: detail.transactionId,
          currencyId: detail.currencyId,
          flowId: detail.flowId,
          paymentTypeId: detail.paymentTypeId,
          paymentId: detail.paymentId,
          categoryId: detail.categoryId,
          amount: detail.amount,
          rateExchange: detail.rateExchange,
        ).toEntity()).toList(),
      );
    }));
  }

  @override
  Future<int> getNextSecuencial(String documentTypeId) {
    return _dao.getNextSecuencial(documentTypeId);
  }

  @override
  Future<TransactionEntry> createIncomeTransaction({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int walletId,
    required int categoryId,
    int? contactId,
    double rateExchange = 1.0,
  }) async {
    // 1. Obtener el siguiente secuencial
    final secuencial = await getNextSecuencial('I');
    
    // 2. Crear modelo de transacción
    final transactionModel = TransactionEntryModel.create(
      documentTypeId: 'I',
      currencyId: currencyId,
      journalId: 0, // Se actualizará después de crear el journal
      contactId: contactId,
      secuencial: secuencial,
      date: date,
      amount: amount,
      rateExchange: rateExchange,
      description: description,
    );
    
    // 3. Insertar la transacción y obtener su ID
    final transactionId = await _dao.insertTransaction(transactionModel.toCompanion());
    
    // 4. Crear detalle de la transacción
    final detailModel = TransactionDetailModel.create(
      transactionId: transactionId,
      currencyId: currencyId,
      flowId: 'I', // Ingreso
      paymentTypeId: 'W', // Wallet
      paymentId: walletId,
      categoryId: categoryId,
      amount: amount,
      rateExchange: rateExchange,
    );
    
    // 5. Insertar el detalle
    await _dao.insertTransactionDetail(detailModel.toCompanion());
    
    // 6. Obtener la transacción completa
    final transaction = await getTransactionById(transactionId);
    if (transaction == null) {
      throw Exception('Error al crear la transacción de ingreso');
    }
    
    return transaction;
  }

  @override
  Future<TransactionEntry> createExpenseTransaction({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int walletId,
    required int categoryId,
    int? contactId,
    double rateExchange = 1.0,
  }) async {
    // 1. Obtener el siguiente secuencial
    final secuencial = await getNextSecuencial('E');
    
    // 2. Crear modelo de transacción
    final transactionModel = TransactionEntryModel.create(
      documentTypeId: 'E',
      currencyId: currencyId,
      journalId: 0, // Se actualizará después de crear el journal
      contactId: contactId,
      secuencial: secuencial,
      date: date,
      amount: amount,
      rateExchange: rateExchange,
      description: description,
    );
    
    // 3. Insertar la transacción y obtener su ID
    final transactionId = await _dao.insertTransaction(transactionModel.toCompanion());
    
    // 4. Crear detalle de la transacción
    final detailModel = TransactionDetailModel.create(
      transactionId: transactionId,
      currencyId: currencyId,
      flowId: 'O', // Egreso/Outflow
      paymentTypeId: 'W', // Wallet
      paymentId: walletId,
      categoryId: categoryId,
      amount: amount,
      rateExchange: rateExchange,
    );
    
    // 5. Insertar el detalle
    await _dao.insertTransactionDetail(detailModel.toCompanion());
    
    // 6. Obtener la transacción completa
    final transaction = await getTransactionById(transactionId);
    if (transaction == null) {
      throw Exception('Error al crear la transacción de egreso');
    }
    
    return transaction;
  }

  @override
  Future<TransactionEntry> createTransferTransaction({
    required DateTime date,
    required String description,
    required double amount,
    required int sourceWalletId,
    required int targetWalletId,
    required double targetAmount,
    required double rateExchange,
    int? contactId,
  }) async {
    // 1. Obtener el siguiente secuencial
    final secuencial = await getNextSecuencial('T');
    
    // Asumimos que la divisa base es USD para este ejemplo
    const String currencyId = 'USD';
    const String targetCurrencyId = 'USD';
    
    // 2. Crear modelo de transacción
    final transactionModel = TransactionEntryModel.create(
      documentTypeId: 'T',
      currencyId: currencyId,
      journalId: 0, // Se actualizará después de crear el journal
      contactId: contactId,
      secuencial: secuencial,
      date: date,
      amount: amount,
      rateExchange: rateExchange,
      description: description,
    );
    
    // 3. Insertar la transacción y obtener su ID
    final transactionId = await _dao.insertTransaction(transactionModel.toCompanion());
    
    // 4. Crear detalles de origen (From)
    final sourceDetailModel = TransactionDetailModel.create(
      transactionId: transactionId,
      currencyId: currencyId,
      flowId: 'F', // From
      paymentTypeId: 'W', // Wallet
      paymentId: sourceWalletId,
      categoryId: 0, // No aplica categoría en transferencias
      amount: amount,
      rateExchange: 1.0,
    );
    
    // 5. Crear detalles de destino (To)
    final targetDetailModel = TransactionDetailModel.create(
      transactionId: transactionId,
      currencyId: targetCurrencyId,
      flowId: 'T', // To
      paymentTypeId: 'W', // Wallet
      paymentId: targetWalletId,
      categoryId: 0, // No aplica categoría en transferencias
      amount: targetAmount,
      rateExchange: rateExchange,
    );
    
    // 6. Insertar ambos detalles
    await _dao.insertTransactionDetail(sourceDetailModel.toCompanion());
    await _dao.insertTransactionDetail(targetDetailModel.toCompanion());
    
    // 7. Obtener la transacción completa
    final transaction = await getTransactionById(transactionId);
    if (transaction == null) {
      throw Exception('Error al crear la transacción de transferencia');
    }
    
    return transaction;
  }
}
