import 'package:injectable/injectable.dart';
import '../../domain/entities/transaction_entry.dart';
import '../../domain/entities/transaction_detail.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/local/daos/transaction_dao.dart';
import '../datasources/local/database.dart';
import '../models/transaction_entry_model.dart';
import '../models/transaction_detail_model.dart';

@Injectable(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDao _transactionDao;

  TransactionRepositoryImpl(this._transactionDao);

  // Helper para convertir entidad de BD a entidad de dominio
  Future<TransactionEntry> _convertToTransactionEntry(TransactionEntries entry) async {
    final details = await _transactionDao.getTransactionDetailsForEntry(entry.id);
    final transactionEntity = TransactionEntryModel.fromDatabase(entry).toEntity();
    
    // CORREGIDO: No usar copyWith, crear nueva instancia con details
    return TransactionEntry(
      id: transactionEntity.id,
      documentTypeId: transactionEntity.documentTypeId,
      currencyId: transactionEntity.currencyId,
      journalId: transactionEntity.journalId,
      contactId: transactionEntity.contactId,
      secuencial: transactionEntity.secuencial,
      date: transactionEntity.date,
      amount: transactionEntity.amount,
      rateExchange: transactionEntity.rateExchange,
      description: transactionEntity.description,
      active: transactionEntity.active,
      createdAt: transactionEntity.createdAt,
      updatedAt: transactionEntity.updatedAt,
      deletedAt: transactionEntity.deletedAt,
      details: details.map((d) => TransactionDetailModel.fromDatabase(d).toEntity()).toList(),
    );
  }

  @override
  Future<List<TransactionEntry>> getAllTransactions() async {
    final results = await _transactionDao.getAllTransactions();
    final transactions = <TransactionEntry>[];
    
    for (final result in results) {
      transactions.add(await _convertToTransactionEntry(result));
    }
    
    return transactions;
  }

  @override
  Future<TransactionEntry?> getTransactionById(int id) async {
    final result = await _transactionDao.getTransactionById(id);
    if (result == null) return null;
    
    return await _convertToTransactionEntry(result);
  }

  @override
  Stream<List<TransactionEntry>> watchAllTransactions() {
    return _transactionDao.watchAllTransactions().asyncMap((entries) async {
      final transactionsWithDetails = <TransactionEntry>[];
      for (final entry in entries) {
        transactionsWithDetails.add(await _convertToTransactionEntry(entry));
      }
      return transactionsWithDetails;
    });
  }

  @override
  Future<TransactionEntry> createTransaction(
    TransactionEntry transaction,
    List<TransactionDetail> details,
  ) async {
    final transactionModel = TransactionEntryModel.fromEntity(transaction);
    final transactionCompanion = transactionModel.toCompanion();
    
    // Insertar transaction entry
    final transactionId = await _transactionDao.insertTransaction(transactionCompanion);
    
    // Insertar details
    for (final detail in details) {
      // CORREGIDO: Crear nuevo detail en lugar de usar copyWith
      final updatedDetail = TransactionDetail(
        id: detail.id,
        transactionId: transactionId,
        currencyId: detail.currencyId,
        flowId: detail.flowId,
        paymentTypeId: detail.paymentTypeId,
        paymentId: detail.paymentId,
        categoryId: detail.categoryId,
        amount: detail.amount,
        rateExchange: detail.rateExchange,
      );
      final detailModel = TransactionDetailModel.fromEntity(updatedDetail);
      await _transactionDao.insertTransactionDetail(detailModel.toCompanion());
    }
    
    // Retornar la transaction creada
    final createdTransaction = await getTransactionById(transactionId);
    return createdTransaction!;
  }

  @override
  Future<void> updateTransaction(TransactionEntry transaction) async {
    final transactionModel = TransactionEntryModel.fromEntity(transaction);
    await _transactionDao.updateTransaction(transactionModel.toCompanion());
  }

  @override
  Future<void> deleteTransaction(int id) async {
    await _transactionDao.deleteTransaction(id);
  }

  @override
  Future<List<TransactionEntry>> getTransactionsByType(String documentTypeId) async {
    final results = await _transactionDao.getTransactionsByType(documentTypeId);
    final transactions = <TransactionEntry>[];
    
    for (final result in results) {
      transactions.add(await _convertToTransactionEntry(result));
    }
    
    return transactions;
  }

  @override
  Future<List<TransactionEntry>> getTransactionsByContact(int contactId) async {
    final results = await _transactionDao.getTransactionsByContact(contactId);
    final transactions = <TransactionEntry>[];
    
    for (final result in results) {
      transactions.add(await _convertToTransactionEntry(result));
    }
    
    return transactions;
  }

  @override
  Future<List<TransactionEntry>> getTransactionsByDateRange(DateTime startDate, DateTime endDate) async {
    final results = await _transactionDao.getTransactionsByDateRange(startDate, endDate);
    final transactions = <TransactionEntry>[];
    
    for (final result in results) {
      transactions.add(await _convertToTransactionEntry(result));
    }
    
    return transactions;
  }

  @override
  Future<int> getNextSecuencial(String documentTypeId) {
    return _transactionDao.getNextSecuencial(documentTypeId);
  }

  @override
  Future<double> getTotalIncomeAmount() {
    return _transactionDao.getTotalIncomeAmount();
  }

  @override
  Future<double> getTotalExpenseAmount() {
    return _transactionDao.getTotalExpenseAmount();
  }

  // MÉTODOS FALTANTES IMPLEMENTADOS:

  @override
  Future<TransactionEntry> createIncomeTransaction({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int walletId,
    required int categoryId,
    required int journalId, // AGREGADO: parámetro faltante
    int? contactId,
    double rateExchange = 1.0,
  }) async {
    // Crear la transacción de ingreso
    final transaction = TransactionEntry(
      id: 0,
      documentTypeId: 'I',
      currencyId: currencyId,
      journalId: journalId, // USAR el journalId proporcionado
      contactId: contactId,
      secuencial: await getNextSecuencial('I'),
      date: date,
      amount: amount,
      rateExchange: rateExchange,
      description: description,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      details: [],
    );

    final details = [
      TransactionDetail(
        id: 0,
        transactionId: 0,
        currencyId: currencyId,
        flowId: 'T', // To (hacia)
        paymentTypeId: 'W', // Wallet
        paymentId: walletId,
        categoryId: categoryId,
        amount: amount,
        rateExchange: rateExchange,
      ),
    ];

    return await createTransaction(transaction, details);
  }

  @override
  Future<TransactionEntry> createExpenseTransaction({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int categoryId,
    required int journalId,
    required String paymentTypeId, // AGREGADO: parámetro faltante
    required int paymentId, // CAMBIADO: de walletId a paymentId
    int? contactId,
    double rateExchange = 1.0,
  }) async {
    // Crear la transacción de gasto
    final transaction = TransactionEntry(
      id: 0,
      documentTypeId: 'E',
      currencyId: currencyId,
      journalId: journalId,
      contactId: contactId,
      secuencial: await getNextSecuencial('E'),
      date: date,
      amount: amount,
      rateExchange: rateExchange,
      description: description,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      details: [],
    );

    final details = [
      TransactionDetail(
        id: 0,
        transactionId: 0,
        currencyId: currencyId,
        flowId: 'F', // From (desde)
        paymentTypeId: paymentTypeId, // USAR parámetro
        paymentId: paymentId, // USAR parámetro
        categoryId: categoryId,
        amount: amount,
        rateExchange: rateExchange,
      ),
    ];

    return await createTransaction(transaction, details);
  }

  @override
  Future<TransactionEntry> createTransferTransaction({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int sourcePaymentId, // CAMBIADO: de sourceWalletId
    required int targetPaymentId, // CAMBIADO: de targetWalletId
    required String targetPaymentTypeId, // AGREGADO: parámetro faltante
    required String targetCurrencyId, // AGREGADO: parámetro faltante
    required double targetAmount, // AGREGADO: parámetro faltante
    required int journalId, // AGREGADO: parámetro faltante
    int? contactId, // AGREGADO: parámetro faltante
    required double rateExchange, // CAMBIADO: ahora es required
  }) async {
    // Crear la transacción de transferencia
    final transaction = TransactionEntry(
      id: 0,
      documentTypeId: 'T',
      currencyId: currencyId,
      journalId: journalId, // USAR parámetro
      contactId: contactId,
      secuencial: await getNextSecuencial('T'),
      date: date,
      amount: amount,
      rateExchange: rateExchange,
      description: description,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      details: [],
    );

    final details = [
      // From: Payment origen
      TransactionDetail(
        id: 0,
        transactionId: 0,
        currencyId: currencyId,
        flowId: 'F', // From
        paymentTypeId: 'W', // Asumimos Wallet por defecto
        paymentId: sourcePaymentId,
        categoryId: 0, // No aplica para transferencias
        amount: amount,
        rateExchange: rateExchange,
      ),
      // To: Payment destino
      TransactionDetail(
        id: 0,
        transactionId: 0,
        currencyId: targetCurrencyId,
        flowId: 'T', // To
        paymentTypeId: targetPaymentTypeId,
        paymentId: targetPaymentId,
        categoryId: 0, // No aplica para transferencias
        amount: targetAmount,
        rateExchange: rateExchange,
      ),
    ];

    return await createTransaction(transaction, details);
  }

  @override
  Future<TransactionEntry> createCreditCardPaymentTransaction({
    required DateTime date,
    String? description, // CAMBIADO: ahora es nullable
    required double amount,
    required String currencyId,
    required int sourceWalletId,
    required int targetCreditCardId, // CAMBIADO: de creditCardId
    required String targetCurrencyId, // AGREGADO: parámetro faltante
    required double targetAmount, // AGREGADO: parámetro faltante
    required int journalId, // AGREGADO: parámetro faltante
    double rateExchange = 1.0,
  }) async {
    // Crear la transacción de pago de tarjeta de crédito
    final transaction = TransactionEntry(
      id: 0,
      documentTypeId: 'P', // P de Payment (pago de tarjeta)
      currencyId: currencyId,
      journalId: journalId, // USAR parámetro
      contactId: null,
      secuencial: await getNextSecuencial('P'),
      date: date,
      amount: amount,
      rateExchange: rateExchange,
      description: description ?? 'Pago de tarjeta de crédito',
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      details: [],
    );

    final details = [
      // From: Wallet (sale dinero)
      TransactionDetail(
        id: 0,
        transactionId: 0,
        currencyId: currencyId,
        flowId: 'F', // From
        paymentTypeId: 'W', // Wallet
        paymentId: sourceWalletId,
        categoryId: 0, // No aplica
        amount: amount,
        rateExchange: rateExchange,
      ),
      // To: Tarjeta de crédito (reduce deuda)
      TransactionDetail(
        id: 0,
        transactionId: 0,
        currencyId: targetCurrencyId,
        flowId: 'T', // To
        paymentTypeId: 'C', // Credit Card
        paymentId: targetCreditCardId,
        categoryId: 0, // No aplica
        amount: targetAmount,
        rateExchange: rateExchange,
      ),
    ];

    return await createTransaction(transaction, details);
  }

  @override
  Future<TransactionEntry> createCreditCardExpenseTransaction({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int creditCardId,
    required int categoryId,
    int? contactId,
    double rateExchange = 1.0,
  }) async {
    // Crear la transacción de gasto con tarjeta de crédito
    final transaction = TransactionEntry(
      id: 0,
      documentTypeId: 'E',
      currencyId: currencyId,
      journalId: 0, // Se actualizará después
      contactId: contactId,
      secuencial: await getNextSecuencial('E'),
      date: date,
      amount: amount,
      rateExchange: rateExchange,
      description: description,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      details: [],
    );

    final details = [
      TransactionDetail(
        id: 0,
        transactionId: 0,
        currencyId: currencyId,
        flowId: 'F', // From (desde tarjeta)
        paymentTypeId: 'C', // Credit Card
        paymentId: creditCardId,
        categoryId: categoryId,
        amount: amount,
        rateExchange: rateExchange,
      ),
    ];

    return await createTransaction(transaction, details);
  }

  @override
  Future<TransactionEntry> createLoanTransaction({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required String loanType, // 'L' o 'B'
    required int contactId,
    required String paymentTypeId, // 'W' o 'C'
    required int paymentId,
    double rateExchange = 1.0,
  }) async {
    // Crear la transacción de préstamo
    final transaction = TransactionEntry(
      id: 0,
      documentTypeId: loanType,
      currencyId: currencyId,
      journalId: 0, // Se actualizará después
      contactId: contactId,
      secuencial: await getNextSecuencial(loanType),
      date: date,
      amount: amount,
      rateExchange: rateExchange,
      description: description,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      details: [],
    );

    final details = [
      TransactionDetail(
        id: 0,
        transactionId: 0,
        currencyId: currencyId,
        flowId: loanType == 'L' ? 'F' : 'T', // Lend=From, Borrow=To
        paymentTypeId: paymentTypeId,
        paymentId: paymentId,
        categoryId: 0, // No aplica para préstamos
        amount: amount,
        rateExchange: rateExchange,
      ),
    ];

    return await createTransaction(transaction, details);
  }

  @override
  Future<List<TransactionEntry>> getTransactionsByCreditCardPayment(int creditCardId) async {
    final results = await _transactionDao.getTransactionsByCreditCardPayment(creditCardId);
    final transactions = <TransactionEntry>[];
    
    for (final result in results) {
      transactions.add(await _convertToTransactionEntry(result));
    }
    
    return transactions;
  }

  @override
  Future<List<TransactionEntry>> getTransactionsByPaymentTypeAndId(String paymentTypeId, int paymentId) async {
    final results = await _transactionDao.getTransactionsByPaymentTypeAndId(paymentTypeId, paymentId);
    final transactions = <TransactionEntry>[];
    
    for (final result in results) {
      transactions.add(await _convertToTransactionEntry(result));
    }
    
    return transactions;
  }

  // MÉTODOS PARA PRÉSTAMOS SIN TRANSFERENCIA IMPLEMENTADOS

  @override
  Future<TransactionEntry> createLendFromServiceTransaction({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int categoryId,
    required int journalId,
    required int contactId,
    double rateExchange = 1.0,
  }) async {
    // Crear la transacción de ingreso por servicio (préstamo otorgado)
    final transaction = TransactionEntry(
      id: 0,
      documentTypeId: 'I', // Ingreso porque es un servicio prestado
      currencyId: currencyId,
      journalId: journalId,
      contactId: contactId,
      secuencial: await getNextSecuencial('I'),
      date: date,
      amount: amount,
      rateExchange: rateExchange,
      description: description,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      details: [],
    );

    final details = [
      TransactionDetail(
        id: 0,
        transactionId: 0,
        currencyId: currencyId,
        flowId: 'T', // To (hacia categoría de ingreso)
        paymentTypeId: 'T', // Transaction (sin transferencia física)
        paymentId: categoryId,
        categoryId: categoryId,
        amount: amount,
        rateExchange: rateExchange,
      ),
    ];

    return await createTransaction(transaction, details);
  }

  @override
  Future<TransactionEntry> createBorrowFromServiceTransaction({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int categoryId,
    required int journalId,
    required int contactId,
    double rateExchange = 1.0,
  }) async {
    // Crear la transacción de gasto por servicio (préstamo recibido)
    final transaction = TransactionEntry(
      id: 0,
      documentTypeId: 'E', // Gasto porque es un servicio recibido
      currencyId: currencyId,
      journalId: journalId,
      contactId: contactId,
      secuencial: await getNextSecuencial('E'),
      date: date,
      amount: amount,
      rateExchange: rateExchange,
      description: description,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      details: [],
    );

    final details = [
      TransactionDetail(
        id: 0,
        transactionId: 0,
        currencyId: currencyId,
        flowId: 'F', // From (desde categoría de gasto)
        paymentTypeId: 'T', // Transaction (sin transferencia física)
        paymentId: categoryId,
        categoryId: categoryId,
        amount: amount,
        rateExchange: rateExchange,
      ),
    ];

    return await createTransaction(transaction, details);
  }

  // MÉTODOS PARA AJUSTES CONTABLES IMPLEMENTADOS

  @override
  Future<TransactionEntry> createAdjustmentTransaction({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int categoryId,
    required String adjustmentType, // 'WRITE_OFF', 'EXTRA', 'DISCOUNT'
    int? contactId,
    double rateExchange = 1.0,
  }) async {
    // Determinar tipo de documento según el ajuste
    String documentTypeId;
    String flowId;
    
    switch (adjustmentType) {
      case 'WRITE_OFF':
        // Write-off puede ser gasto (préstamo otorgado) o ingreso (préstamo recibido)
        documentTypeId = 'E'; // Por defecto gasto, se ajustará según contexto
        flowId = 'F';
        break;
      case 'EXTRA':
        // Monto extra generalmente es ingreso
        documentTypeId = 'I';
        flowId = 'T';
        break;
      case 'DISCOUNT':
        // Descuento generalmente es ingreso
        documentTypeId = 'I';
        flowId = 'T';
        break;
      default:
        documentTypeId = 'E';
        flowId = 'F';
    }

    final transaction = TransactionEntry(
      id: 0,
      documentTypeId: documentTypeId,
      currencyId: currencyId,
      journalId: 0, // Se creará automáticamente si es necesario
      contactId: contactId,
      secuencial: await getNextSecuencial(documentTypeId),
      date: date,
      amount: amount,
      rateExchange: rateExchange,
      description: '$description (Ajuste: $adjustmentType)',
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      details: [],
    );

    final details = [
      TransactionDetail(
        id: 0,
        transactionId: 0,
        currencyId: currencyId,
        flowId: flowId,
        paymentTypeId: 'T', // Transaction (ajuste contable)
        paymentId: categoryId,
        categoryId: categoryId,
        amount: amount,
        rateExchange: rateExchange,
      ),
    ];

    return await createTransaction(transaction, details);
  }

  // CONSULTAS ESPECIALIZADAS IMPLEMENTADAS

  @override
  Future<List<TransactionEntry>> getTransactionsByLoan(int loanId) async {
    // Esta implementación requiere una consulta específica en el DAO
    // Por ahora retornamos una lista vacía, se implementará en el DAO
    return [];
  }

  @override
  Future<List<TransactionEntry>> getAdjustmentTransactions() async {
    // Buscar transacciones que tengan paymentTypeId = 'T' (ajustes)
    final allTransactions = await getAllTransactions();
    return allTransactions.where((transaction) {
      return transaction.details.any((detail) => detail.paymentTypeId == 'T');
    }).toList();
  }
}
