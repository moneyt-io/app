import 'package:injectable/injectable.dart';
import '../../domain/entities/journal_entry.dart';
import '../../domain/entities/journal_detail.dart';
import '../../domain/repositories/journal_repository.dart';
import '../datasources/local/daos/journal_dao.dart';
import '../datasources/local/database.dart'; // Importar la base de datos que contiene JournalEntries
import '../models/journal_entry_model.dart';
import '../models/journal_detail_model.dart';

@Injectable(as: JournalRepository)
class JournalRepositoryImpl implements JournalRepository {
  final JournalDao _journalDao;

  JournalRepositoryImpl(this._journalDao);

  // Helper para convertir entidad de BD a entidad de dominio
  Future<JournalEntry> _convertToJournalEntry(JournalEntries entry) async {
    final details = await _journalDao.getJournalDetailsForEntry(entry.id);
    return JournalEntryModel.fromDatabase(entry).toEntity().copyWith(
      details: details.map((d) => JournalDetailModel.fromDatabase(d).toEntity()).toList(),
    );
  }

  @override
  Future<List<JournalEntry>> getAllJournalEntries() async {
    final results = await _journalDao.getAllJournalEntries();
    final journals = <JournalEntry>[];
    
    for (final result in results) {
      journals.add(await _convertToJournalEntry(result));
    }
    
    return journals;
  }

  @override
  Future<JournalEntry?> getJournalEntryById(int id) async {
    final result = await _journalDao.getJournalEntryById(id);
    if (result == null) return null;
    
    return await _convertToJournalEntry(result);
  }

  @override
  Stream<List<JournalEntry>> watchAllJournalEntries() {
    return _journalDao.watchAllJournalEntries().asyncMap((results) async {
      final journals = <JournalEntry>[];
      for (final result in results) {
        journals.add(await _convertToJournalEntry(result));
      }
      return journals;
    });
  }

  @override
  Future<JournalEntry> createJournalEntry(JournalEntry entry, List<JournalDetail> details) async {
    final journalModel = JournalEntryModel.fromEntity(entry);
    final journalCompanion = journalModel.toCompanion();
    
    // Insertar journal entry
    final journalId = await _journalDao.insertJournalEntry(journalCompanion);
    
    // Insertar details
    for (final detail in details) {
      final detailModel = JournalDetailModel.fromEntity(detail.copyWith(journalId: journalId));
      await _journalDao.insertJournalDetail(detailModel.toCompanion());
    }
    
    // Retornar el journal creado
    final createdJournal = await getJournalEntryById(journalId);
    return createdJournal!;
  }

  @override
  Future<void> updateJournalEntry(JournalEntry entry) async {
    final journalModel = JournalEntryModel.fromEntity(entry);
    await _journalDao.updateJournalEntry(journalModel.toCompanion());
  }

  @override
  Future<void> deleteJournalEntry(int id) async {
    await _journalDao.deleteJournalEntry(id);
  }

  @override
  Future<List<JournalEntry>> getJournalEntriesByType(String documentTypeId) async {
    final results = await _journalDao.getJournalEntriesByType(documentTypeId);
    final journals = <JournalEntry>[];
    
    for (final result in results) {
      journals.add(await _convertToJournalEntry(result));
    }
    
    return journals;
  }

  @override
  Future<List<JournalEntry>> getJournalEntriesByDate(DateTime startDate, DateTime endDate) async {
    final results = await _journalDao.getJournalEntriesByDateRange(startDate, endDate);
    final journals = <JournalEntry>[];
    
    for (final result in results) {
      journals.add(await _convertToJournalEntry(result));
    }
    
    return journals;
  }

  @override
  Future<List<JournalEntry>> getJournalEntriesByAccount(int chartAccountId) async {
    // Obtener journals que tengan detalles para esta cuenta
    final results = await _journalDao.getAllJournalEntries();
    final journals = <JournalEntry>[];
    
    for (final result in results) {
      final journal = await _convertToJournalEntry(result);
      if (journal.details.any((detail) => detail.chartAccountId == chartAccountId)) {
        journals.add(journal);
      }
    }
    
    return journals;
  }

  @override
  Stream<JournalEntry?> watchJournalEntryById(int id) {
    return _journalDao.watchAllJournalEntries().asyncMap((results) async {
      final result = results.where((j) => j.id == id).firstOrNull;
      if (result == null) return null;
      return await _convertToJournalEntry(result);
    });
  }

  @override
  Future<int> getNextSecuencial(String documentTypeId) {
    return _journalDao.getNextSecuencial(documentTypeId);
  }

  @override
  Future<Map<String, double>> getAccountBalance(int chartAccountId, {DateTime? fromDate, DateTime? toDate}) {
    return _journalDao.getAccountBalance(chartAccountId, fromDate: fromDate, toDate: toDate);
  }

  // Métodos especializados - implementaciones básicas
  @override
  Future<JournalEntry> createIncomeJournal({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int walletChartAccountId,
    required int categoryChartAccountId,
    double rateExchange = 1.0,
  }) async {
    final journalEntry = JournalEntry(
      id: 0,
      documentTypeId: 'I',
      secuencial: await getNextSecuencial('I'),
      date: date,
      description: description,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      details: [],
    );

    final details = [
      // Débito: Wallet (aumenta activo)
      JournalDetail(
        id: 0,
        journalId: 0,
        currencyId: currencyId,
        chartAccountId: walletChartAccountId,
        debit: amount,
        credit: 0,
        rateExchange: rateExchange,
      ),
      // Crédito: Categoría de ingreso (aumenta ingreso)
      JournalDetail(
        id: 0,
        journalId: 0,
        currencyId: currencyId,
        chartAccountId: categoryChartAccountId,
        debit: 0,
        credit: amount,
        rateExchange: rateExchange,
      ),
    ];

    return await createJournalEntry(journalEntry, details);
  }

  @override
  Future<JournalEntry> createExpenseJournal({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int walletChartAccountId,
    required int categoryChartAccountId,
    double rateExchange = 1.0,
  }) async {
    final journalEntry = JournalEntry(
      id: 0,
      documentTypeId: 'E',
      secuencial: await getNextSecuencial('E'),
      date: date,
      description: description,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      details: [],
    );

    final details = [
      // Débito: Categoría de gasto (aumenta gasto)
      JournalDetail(
        id: 0,
        journalId: 0,
        currencyId: currencyId,
        chartAccountId: categoryChartAccountId,
        debit: amount,
        credit: 0,
        rateExchange: rateExchange,
      ),
      // Crédito: Wallet (disminuye activo)
      JournalDetail(
        id: 0,
        journalId: 0,
        currencyId: currencyId,
        chartAccountId: walletChartAccountId,
        debit: 0,
        credit: amount,
        rateExchange: rateExchange,
      ),
    ];

    return await createJournalEntry(journalEntry, details);
  }

  @override
  Future<JournalEntry> createTransferJournal({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int sourceChartAccountId,
    required int targetChartAccountId,
    required String targetCurrencyId,
    required double targetAmount,
    double rateExchange = 1.0,
  }) async {
    final journalEntry = JournalEntry(
      id: 0,
      documentTypeId: 'T',
      secuencial: await getNextSecuencial('T'),
      date: date,
      description: description,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      details: [],
    );

    final details = [
      // Crédito: Wallet origen (disminuye activo origen)
      JournalDetail(
        id: 0,
        journalId: 0,
        currencyId: currencyId,
        chartAccountId: sourceChartAccountId,
        debit: 0,
        credit: amount,
        rateExchange: rateExchange,
      ),
      // Débito: Wallet destino (aumenta activo destino)
      JournalDetail(
        id: 0,
        journalId: 0,
        currencyId: targetCurrencyId,
        chartAccountId: targetChartAccountId,
        debit: targetAmount,
        credit: 0,
        rateExchange: rateExchange,
      ),
    ];

    return await createJournalEntry(journalEntry, details);
  }

  @override
  Future<JournalEntry> createCreditCardPaymentJournal({
    required DateTime date,
    String? description,
    required double amount,
    required String currencyId,
    required int sourceWalletChartAccountId,
    required int targetCreditCardChartAccountId, // AGREGADO: parámetro faltante
    required String targetCurrencyId, // AGREGADO: parámetro faltante
    required double targetAmount, // AGREGADO: parámetro faltante
    double rateExchange = 1.0,
  }) async {
    final journalEntry = JournalEntry(
      id: 0,
      documentTypeId: 'P', // P de Payment
      secuencial: await getNextSecuencial('P'),
      date: date,
      description: description ?? 'Pago de tarjeta de crédito',
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      details: [],
    );

    final details = [
      // Crédito: Wallet origen (disminuye activo)
      JournalDetail(
        id: 0,
        journalId: 0,
        currencyId: currencyId,
        chartAccountId: sourceWalletChartAccountId,
        debit: 0,
        credit: amount,
        rateExchange: rateExchange,
      ),
      // Débito: Tarjeta de crédito (disminuye pasivo)
      JournalDetail(
        id: 0,
        journalId: 0,
        currencyId: targetCurrencyId,
        chartAccountId: targetCreditCardChartAccountId,
        debit: targetAmount,
        credit: 0,
        rateExchange: rateExchange,
      ),
    ];

    return await createJournalEntry(journalEntry, details);
  }

  // MÉTODOS FALTANTES IMPLEMENTADOS:

  @override
  Future<JournalEntry> createJournal({
    required String documentTypeId,
    required DateTime date,
    required String description,
  }) async {
    final journalEntry = JournalEntry(
      id: 0,
      documentTypeId: documentTypeId,
      secuencial: await getNextSecuencial(documentTypeId),
      date: date,
      description: description,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      details: [],
    );

    // Como no recibimos details, creamos el journal sin detalles
    // Los detalles se pueden agregar posteriormente con createJournalDetails
    return await createJournalEntry(journalEntry, []);
  }

  @override
  Future<void> createJournalDetails(List<JournalDetail> details) async {
    // CORREGIDO: Cambiar firma para coincidir con la interfaz
    for (final detail in details) {
      final detailModel = JournalDetailModel.fromEntity(detail);
      await _journalDao.insertJournalDetail(detailModel.toCompanion());
    }
  }

  @override
  Future<dynamic> getLoanById(int id) async {
    // Este método parece ser un error en la interfaz del repositorio
    // Los journals no deberían tener métodos para loans
    throw UnimplementedError('getLoanById no debería estar en JournalRepository');
  }

  @override
  Future<dynamic> getWalletById(int id) async {
    // Este método parece ser un error en la interfaz del repositorio
    // Los journals no deberían tener métodos para wallets
    throw UnimplementedError('getWalletById no debería estar en JournalRepository');
  }

  // MÉTODOS ESPECIALIZADOS PARA PRÉSTAMOS IMPLEMENTADOS

  @override
  Future<JournalEntry> createLendFromCreditCardJournal({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int receivableAccountId,
    required int creditCardAccountId,
    double rateExchange = 1.0,
  }) async {
    // 1. Crear journal principal
    final journal = await createJournal(
      documentTypeId: 'L',
      date: date,
      description: description,
    );

    // 2. Crear detalles con partida doble
    final details = [
      JournalDetail(
        id: 0,
        journalId: journal.id,
        currencyId: currencyId,
        chartAccountId: receivableAccountId,
        debit: amount,
        credit: 0,
        rateExchange: rateExchange,
      ),
      JournalDetail(
        id: 0,
        journalId: journal.id,
        currencyId: currencyId,
        chartAccountId: creditCardAccountId,
        debit: 0,
        credit: amount,
        rateExchange: rateExchange,
      ),
    ];

    await createJournalDetails(details);
    return journal;
  }

  @override
  Future<JournalEntry> createLendFromServiceJournal({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int receivableAccountId,
    required int incomeAccountId,
    double rateExchange = 1.0,
  }) async {
    // 1. Crear journal principal
    final journal = await createJournal(
      documentTypeId: 'L',
      date: date,
      description: description,
    );

    // 2. Crear detalles con partida doble
    final details = [
      JournalDetail(
        id: 0,
        journalId: journal.id,
        currencyId: currencyId,
        chartAccountId: receivableAccountId,
        debit: amount,
        credit: 0,
        rateExchange: rateExchange,
      ),
      JournalDetail(
        id: 0,
        journalId: journal.id,
        currencyId: currencyId,
        chartAccountId: incomeAccountId,
        debit: 0,
        credit: amount,
        rateExchange: rateExchange,
      ),
    ];

    await createJournalDetails(details);
    return journal;
  }

  @override
  Future<JournalEntry> createBorrowFromServiceJournal({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int expenseAccountId,
    required int payableAccountId,
    double rateExchange = 1.0,
  }) async {
    // 1. Crear journal principal
    final journal = await createJournal(
      documentTypeId: 'B',
      date: date,
      description: description,
    );

    // 2. Crear detalles con partida doble
    final details = [
      JournalDetail(
        id: 0,
        journalId: journal.id,
        currencyId: currencyId,
        chartAccountId: expenseAccountId,
        debit: amount,
        credit: 0,
        rateExchange: rateExchange,
      ),
      JournalDetail(
        id: 0,
        journalId: journal.id,
        currencyId: currencyId,
        chartAccountId: payableAccountId,
        debit: 0,
        credit: amount,
        rateExchange: rateExchange,
      ),
    ];

    await createJournalDetails(details);
    return journal;
  }

  // MÉTODOS PARA VALIDACIONES CONTABLES

  @override
  Future<bool> validateJournalBalance(List<JournalDetail> details) async {
    double totalDebits = 0;
    double totalCredits = 0;

    for (final detail in details) {
      totalDebits += detail.debit;
      totalCredits += detail.credit;
    }

    // Tolerancia para decimales
    const tolerance = 0.01;
    return (totalDebits - totalCredits).abs() < tolerance;
  }

  // MÉTODOS PARA REPORTES

  @override
  Future<Map<String, double>> getTrialBalance({DateTime? fromDate, DateTime? toDate}) async {
    // Implementación básica - puede mejorarse con consultas SQL específicas
    final journals = await getJournalsByDateRange(
      fromDate ?? DateTime(2020, 1, 1),
      toDate ?? DateTime.now(),
    );

    double totalDebits = 0;
    double totalCredits = 0;

    for (final journal in journals) {
      for (final detail in journal.details) {
        totalDebits += detail.debit;
        totalCredits += detail.credit;
      }
    }

    return {
      'totalDebits': totalDebits,
      'totalCredits': totalCredits,
      'difference': totalDebits - totalCredits,
    };
  }

  @override
  Future<List<JournalEntry>> getJournalsByDateRange(DateTime startDate, DateTime endDate) async {
    final results = await _journalDao.getJournalsByDateRange(startDate, endDate);
    final journals = <JournalEntry>[];
    
    for (final result in results) {
      journals.add(await _convertToJournalEntry(result));
    }
    
    return journals;
  }
}
