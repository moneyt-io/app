import 'package:injectable/injectable.dart';
import '../../domain/entities/transaction_entry.dart';
import '../../domain/entities/transaction_detail.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/local/daos/transaction_dao.dart';
import '../models/transaction_entry_model.dart';
import '../models/transaction_detail_model.dart';

@Injectable(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDao _dao;

  TransactionRepositoryImpl(this._dao);

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
}
