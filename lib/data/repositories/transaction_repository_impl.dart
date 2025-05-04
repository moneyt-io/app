import 'package:injectable/injectable.dart';
import '../../domain/entities/transaction_entry.dart';
import '../../domain/entities/transaction_detail.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/repositories/journal_repository.dart';
import '../datasources/local/daos/transaction_dao.dart';
import '../models/transaction_entry_model.dart';
import '../models/transaction_detail_model.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../../domain/repositories/contact_repository.dart';

@Injectable(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDao _dao;
  final JournalRepository _journalRepository;
  final CategoryRepository _categoryRepository;
  final WalletRepository _walletRepository;
  final ContactRepository _contactRepository;

  TransactionRepositoryImpl(
    this._dao, 
    this._journalRepository,
    this._categoryRepository,
    this._walletRepository,
    this._contactRepository,
  );

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
    
    // Cargar datos relacionados
    final contact = entry.contactId != null
        ? await _contactRepository.getContactById(entry.contactId!)
        : null;
    final wallet = details.isNotEmpty 
        ? await _walletRepository.getWalletById(details.first.paymentId)
        : null;
    final category = details.isNotEmpty && details.first.categoryId > 0
        ? await _categoryRepository.getCategoryById(details.first.categoryId)
        : null;

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
      contact: contact,
      wallet: wallet,
      category: category,
    );
  }

  @override
  Future<TransactionEntry> createTransaction(
    TransactionEntry entry,
    List<TransactionDetail> details
  ) async {
    final model = TransactionEntryModel.fromEntity(entry);
    final id = await _dao.insertTransaction(model.toCompanion());
    
    if (id == 0) {
      throw Exception('Error al insertar la transacción en la base de datos');
    }

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
      throw Exception('Error al recuperar la transacción creada');
    }
    
    return createdTransaction;
  }

  @override
  Future<void> updateTransaction(TransactionEntry transaction) async {
    final model = TransactionEntryModel.fromEntity(transaction);
    await _dao.updateTransaction(model.toCompanion());
  }

  @override
  Future<void> deleteTransaction(int id) async {
    // Primero eliminamos los detalles
    await _dao.deleteTransactionDetails(id);
    // Luego eliminamos la entrada principal
    await _dao.deleteTransaction(id);
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
    required int journalId,
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int walletId,
    required int categoryId,
    int? contactId,
    double rateExchange = 1.0,
  }) async {
    // 2. Obtener el siguiente secuencial
    final secuencial = await getNextSecuencial('I');
    
    // 3. Crear modelo de transacción con el journalId correcto (recibido)
    final transactionModel = TransactionEntryModel.create(
      documentTypeId: 'I',
      currencyId: currencyId,
      journalId: journalId,
      contactId: contactId,
      secuencial: secuencial,
      date: date,
      amount: amount,
      rateExchange: rateExchange,
      description: description,
    );
    
    // 4. Insertar la transacción y obtener su ID
    final transactionId = await _dao.insertTransaction(transactionModel.toCompanion());
    
    if (transactionId == 0) {
      throw Exception('Error al insertar la transacción de ingreso');
    }
    
    // 5. Crear detalle de la transacción
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
    
    // 6. Insertar el detalle
    await _dao.insertTransactionDetail(detailModel.toCompanion());
    
    // 7. Obtener la transacción completa
    final transaction = await getTransactionById(transactionId);
    if (transaction == null) {
      throw Exception('Error al crear la transacción de ingreso');
    }
    
    return transaction;
  }

  @override
  Future<TransactionEntry> createExpenseTransaction({
    required int journalId,
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int walletId,
    required int categoryId,
    int? contactId,
    double rateExchange = 1.0,
  }) async {
    // 2. Obtener el siguiente secuencial
    final secuencial = await getNextSecuencial('E');
    
    // 3. Crear modelo de transacción con el journalId correcto (recibido)
    final transactionModel = TransactionEntryModel.create(
      documentTypeId: 'E',
      currencyId: currencyId,
      journalId: journalId,
      contactId: contactId,
      secuencial: secuencial,
      date: date,
      amount: amount,
      rateExchange: rateExchange,
      description: description,
    );
    
    // 4. Insertar la transacción y obtener su ID
    final transactionId = await _dao.insertTransaction(transactionModel.toCompanion());
    
    if (transactionId == 0) {
      throw Exception('Error al insertar la transacción de egreso');
    }
    
    // 5. Crear detalle de la transacción
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
    
    // 6. Insertar el detalle
    await _dao.insertTransactionDetail(detailModel.toCompanion());
    
    // 7. Obtener la transacción completa
    final transaction = await getTransactionById(transactionId);
    if (transaction == null) {
      throw Exception('Error al crear la transacción de egreso');
    }
    
    return transaction;
  }

  @override
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
    String currencyId = 'USD', 
    String targetCurrencyId = 'USD',
  }) async {
    // 2. Obtener el siguiente secuencial
    final secuencial = await getNextSecuencial('T');
    
    // 3. Crear modelo de transacción con el journalId correcto (recibido)
    final transactionModel = TransactionEntryModel.create(
      documentTypeId: 'T',
      currencyId: currencyId,
      journalId: journalId,
      contactId: contactId,
      secuencial: secuencial,
      date: date,
      amount: amount,
      rateExchange: rateExchange,
      description: description,
    );
    
    // 4. Insertar la transacción y obtener su ID
    final transactionId = await _dao.insertTransaction(transactionModel.toCompanion());
    
    if (transactionId == 0) {
      throw Exception('Error al insertar la transacción de transferencia');
    }
    
    // 5. Crear detalles de origen (From)
    final sourceDetailModel = TransactionDetailModel.create(
      transactionId: transactionId,
      currencyId: currencyId,
      flowId: 'F', // From
      paymentTypeId: 'W', // Wallet
      paymentId: sourceWalletId,
      categoryId: 0, // No aplica categoría en transferencias
      amount: -amount, // Sale de la cuenta origen (negativo)
      rateExchange: 1.0, // Tasa base para el origen
    );
    
    // 6. Crear detalles de destino (To)
    final targetDetailModel = TransactionDetailModel.create(
      transactionId: transactionId,
      currencyId: targetCurrencyId,
      flowId: 'T', // To
      paymentTypeId: 'W', // Wallet
      paymentId: targetWalletId,
      categoryId: 0, // No aplica categoría en transferencias
      amount: targetAmount, // Entra a la cuenta destino (positivo)
      rateExchange: rateExchange, // Tasa aplicada para la conversión
    );
    
    // 7. Insertar ambos detalles
    await _dao.insertTransactionDetail(sourceDetailModel.toCompanion());
    await _dao.insertTransactionDetail(targetDetailModel.toCompanion());
    
    // 8. Obtener la transacción completa
    final transaction = await getTransactionById(transactionId);
    if (transaction == null) {
      throw Exception('Error al crear la transacción de transferencia');
    }
    
    return transaction;
  }
}
