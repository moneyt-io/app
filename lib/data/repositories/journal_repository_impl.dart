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
  final JournalDao _dao;

  JournalRepositoryImpl(this._dao);

  // Helper para convertir JournalEntries y sus detalles a JournalEntry
  Future<JournalEntry> _convertToJournalEntry(JournalEntries entry) async {
    final details = await _dao.getJournalDetailsForEntry(entry.id);
    return JournalEntryModel(
      id: entry.id,
      documentTypeId: entry.documentTypeId,
      secuencial: entry.secuencial,
      date: entry.date,
      description: entry.description,
      active: entry.active,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
      deletedAt: entry.deletedAt,
    ).toEntity(
      details: details.map((detail) => JournalDetailModel(
        id: detail.id,
        journalId: detail.journalId,
        currencyId: detail.currencyId,
        chartAccountId: detail.chartAccountId,
        credit: detail.credit,
        debit: detail.debit,
        rateExchange: detail.rateExchange,
      )).toList(),
    );
  }

  @override
  Future<List<JournalEntry>> getAllJournalEntries() async {
    final entries = await _dao.getAllJournalEntries();
    return Future.wait(entries.map(_convertToJournalEntry));
  }

  @override
  Future<JournalEntry> createJournalEntry(JournalEntry entry, List<JournalDetail> details) async {
    final model = JournalEntryModel.fromEntity(entry);
    final id = await _dao.insertJournalEntry(model.toCompanion());
    
    final detailModels = details.map((detail) => JournalDetailModel(
      id: 0,
      journalId: id,
      currencyId: detail.currencyId,
      chartAccountId: detail.chartAccountId,
      credit: detail.credit,
      debit: detail.debit,
      rateExchange: detail.rateExchange,
    )).toList();
    
    await _dao.insertJournalDetails(detailModels.map((m) => m.toCompanion()).toList());
    
    final createdEntry = await getJournalEntryById(id);
    if (createdEntry == null) {
      throw Exception('Failed to create journal entry');
    }
    return createdEntry;
  }

  @override 
  Future<JournalEntry?> getJournalEntryById(int id) async {
    final entry = await _dao.getJournalEntryById(id);
    if (entry == null) return null;
    return _convertToJournalEntry(entry);
  }

  @override
  Stream<List<JournalEntry>> watchAllJournalEntries() {
    return _dao.watchAllJournalEntries().asyncMap((entries) async {
      return Future.wait(entries.map(_convertToJournalEntry));
    });
  }

  @override
  Future<void> updateJournalEntry(JournalEntry entry) async {
    final model = JournalEntryModel.fromEntity(entry);
    await _dao.updateJournalEntry(model.toCompanion());
  }

  @override
  Future<void> deleteJournalEntry(int id) async {
    await _dao.deleteJournalDetails(id); // Primero borramos los detalles
    await _dao.deleteJournalEntry(id);   // Luego borramos la entrada principal
  }

  // NUEVOS MÉTODOS IMPLEMENTADOS

  @override
  Future<List<JournalEntry>> getJournalEntriesByType(String documentTypeId) async {
    final entries = await _dao.getJournalEntriesByType(documentTypeId);
    return Future.wait(entries.map(_convertToJournalEntry));
  }
  
  @override
  Future<List<JournalEntry>> getJournalEntriesByDate(DateTime startDate, DateTime endDate) async {
    final entries = await _dao.getJournalEntriesByDateRange(startDate, endDate);
    return Future.wait(entries.map(_convertToJournalEntry));
  }
  
  @override
  Stream<JournalEntry?> watchJournalEntryById(int id) {
    return _dao.watchJournalEntryById(id).asyncMap((entry) async {
      if (entry == null) return null;
      return _convertToJournalEntry(entry);
    });
  }
  
  @override
  Future<int> getNextSecuencial(String documentTypeId) {
    return _dao.getNextSecuencial(documentTypeId);
  }
  
  @override
  Future<List<JournalEntry>> getJournalEntriesByAccount(int chartAccountId) async {
    final entries = await _dao.getJournalEntriesByAccount(chartAccountId);
    return Future.wait(entries.map(_convertToJournalEntry));
  }
  
  @override
  Future<Map<String, double>> getAccountBalance(int chartAccountId, {DateTime? fromDate, DateTime? toDate}) async {
    final result = await _dao.getAccountBalance(chartAccountId, fromDate, toDate);
    
    // Calcular el balance neto (débito - crédito)
    final debit = result['debit'] ?? 0.0;
    final credit = result['credit'] ?? 0.0;
    final balance = debit - credit;
    
    return {
      'debit': debit,
      'credit': credit,
      'balance': balance,
    };
  }

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
    final secuencial = await getNextSecuencial('I');
    final journalModel = JournalEntryModel.create(
      documentTypeId: 'I',
      secuencial: secuencial,
      date: date,
      description: description,
      active: true,
    );
    final journalId = await _dao.insertJournalEntry(journalModel.toCompanion());
    final details = [
      JournalDetailModel(
        id: 0,
        journalId: journalId,
        currencyId: currencyId,
        chartAccountId: walletChartAccountId,
        debit: amount,
        credit: 0,
        rateExchange: rateExchange,
      ),
      JournalDetailModel(
        id: 0,
        journalId: journalId,
        currencyId: currencyId,
        chartAccountId: categoryChartAccountId,
        debit: 0,
        credit: amount,
        rateExchange: rateExchange,
      ),
    ];
    await _dao.insertJournalDetails(details.map((d) => d.toCompanion()).toList());
    final journalEntry = await getJournalEntryById(journalId);
    if (journalEntry == null) {
      throw Exception('No se pudo crear el diario de ingreso');
    }
    return journalEntry;
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
    final secuencial = await getNextSecuencial('E');
    final journalModel = JournalEntryModel.create(
      documentTypeId: 'E',
      secuencial: secuencial,
      date: date,
      description: description,
      active: true,
    );
    final journalId = await _dao.insertJournalEntry(journalModel.toCompanion());
    final details = [
      JournalDetailModel(
        id: 0,
        journalId: journalId,
        currencyId: currencyId,
        chartAccountId: categoryChartAccountId,
        debit: amount,
        credit: 0,
        rateExchange: rateExchange,
      ),
      JournalDetailModel(
        id: 0,
        journalId: journalId,
        currencyId: currencyId,
        chartAccountId: walletChartAccountId,
        debit: 0,
        credit: amount,
        rateExchange: rateExchange,
      ),
    ];
    await _dao.insertJournalDetails(details.map((d) => d.toCompanion()).toList());
    final journalEntry = await getJournalEntryById(journalId);
    if (journalEntry == null) {
      throw Exception('No se pudo crear el diario de gasto');
    }
    return journalEntry;
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
    final secuencial = await getNextSecuencial('T');
    final journalModel = JournalEntryModel.create(
      documentTypeId: 'T',
      secuencial: secuencial,
      date: date,
      description: description,
      active: true,
    );
    final journalId = await _dao.insertJournalEntry(journalModel.toCompanion());
    final details = [
      JournalDetailModel(
        id: 0,
        journalId: journalId,
        currencyId: targetCurrencyId,
        chartAccountId: targetChartAccountId,
        debit: targetAmount,
        credit: 0,
        rateExchange: rateExchange,
      ),
      JournalDetailModel(
        id: 0,
        journalId: journalId,
        currencyId: currencyId,
        chartAccountId: sourceChartAccountId,
        debit: 0,
        credit: amount,
        rateExchange: 1.0,
      ),
    ];
    if (currencyId != targetCurrencyId && (amount * rateExchange) != targetAmount) {
      final difference = targetAmount - (amount * rateExchange);
      if (difference > 0) {
        details.add(
          JournalDetailModel(
            id: 0,
            journalId: journalId,
            currencyId: targetCurrencyId,
            chartAccountId: targetChartAccountId,
            debit: 0,
            credit: difference.abs(),
            rateExchange: rateExchange,
          ),
        );
      } else if (difference < 0) {
        details.add(
          JournalDetailModel(
            id: 0,
            journalId: journalId,
            currencyId: targetCurrencyId,
            chartAccountId: targetChartAccountId,
            debit: difference.abs(),
            credit: 0,
            rateExchange: rateExchange,
          ),
        );
      }
    }
    await _dao.insertJournalDetails(details.map((d) => d.toCompanion()).toList());
    final journalEntry = await getJournalEntryById(journalId);
    if (journalEntry == null) {
      throw Exception('No se pudo crear el diario de transferencia');
    }
    return journalEntry;
  }

  @override
  Future<JournalEntry> createCreditCardPaymentJournal({
    required DateTime date,
    String? description,
    required double amount,
    required String currencyId,
    required int sourceWalletChartAccountId,
    required int targetCreditCardChartAccountId,
    required String targetCurrencyId,
    required double targetAmount,
    double rateExchange = 1.0,
  }) async {
    final secuencial = await getNextSecuencial('C'); // Card Payment
    
    final journalModel = JournalEntryModel.create(
      documentTypeId: 'C',
      secuencial: secuencial,
      date: date,
      description: description ?? 'Card payment',
      active: true,
    );
    
    final journalId = await _dao.insertJournalEntry(journalModel.toCompanion());
    
    // Asiento contable: Débito a tarjeta (reduce pasivo), Crédito a wallet (reduce activo)
    final details = [
      JournalDetailModel(
        id: 0,
        journalId: journalId,
        currencyId: targetCurrencyId,
        chartAccountId: targetCreditCardChartAccountId,
        debit: targetAmount, // Reduce el pasivo de la tarjeta
        credit: 0,
        rateExchange: rateExchange,
      ),
      JournalDetailModel(
        id: 0,
        journalId: journalId,
        currencyId: currencyId,
        chartAccountId: sourceWalletChartAccountId,
        debit: 0,
        credit: amount, // Reduce el activo de la wallet
        rateExchange: 1.0,
      ),
    ];
    
    // Manejar diferencia de cambio si las monedas son diferentes
    if (currencyId != targetCurrencyId && (amount * rateExchange) != targetAmount) {
      final difference = targetAmount - (amount * rateExchange);
      if (difference != 0) {
        details.add(
          JournalDetailModel(
            id: 0,
            journalId: journalId,
            currencyId: targetCurrencyId,
            chartAccountId: targetCreditCardChartAccountId, // Cuenta de ganancia/pérdida cambiaria
            debit: difference > 0 ? 0 : difference.abs(),
            credit: difference > 0 ? difference : 0,
            rateExchange: rateExchange,
          ),
        );
      }
    }
    
    await _dao.insertJournalDetails(details.map((d) => d.toCompanion()).toList());
    
    final journalEntry = await getJournalEntryById(journalId);
    if (journalEntry == null) {
      throw Exception('No se pudo crear el diario de pago de tarjeta');
    }
    return journalEntry;
  }

  // MÉTODOS FALTANTES IMPLEMENTADOS

  @override
  Future<JournalEntry> createJournal({
    required String documentTypeId,
    required DateTime date,
    required String description,
  }) async {
    final secuencial = await getNextSecuencial(documentTypeId);
    final journalModel = JournalEntryModel.create(
      documentTypeId: documentTypeId,
      secuencial: secuencial,
      date: date,
      description: description,
      active: true,
    );
    
    final journalId = await _dao.insertJournalEntry(journalModel.toCompanion());
    
    final journalEntry = await getJournalEntryById(journalId);
    if (journalEntry == null) {
      throw Exception('No se pudo crear el journal entry');
    }
    return journalEntry;
  }

  @override
  Future<void> createJournalDetails(List<JournalDetail> details) async {
    final detailModels = details.map((detail) => JournalDetailModel(
      id: detail.id,
      journalId: detail.journalId,
      currencyId: detail.currencyId,
      chartAccountId: detail.chartAccountId,
      credit: detail.credit,
      debit: detail.debit,
      rateExchange: detail.rateExchange,
    )).toList();
    
    await _dao.insertJournalDetails(detailModels.map((m) => m.toCompanion()).toList());
  }

  @override
  Future<dynamic> getLoanById(int loanId) async {
    // TODO: Implementar cuando tengamos LoanDao disponible
    // Por ahora retornamos un objeto dummy para evitar errores
    return {
      'id': loanId,
      'contactId': 1,
      'documentTypeId': 'L',
      'amount': 0.0,
    };
  }

  @override
  Future<dynamic> getWalletById(int walletId) async {
    // TODO: Implementar cuando tengamos WalletDao disponible
    // Por ahora retornamos un objeto dummy para evitar errores
    return {
      'id': walletId,
      'chartAccountId': 1001, // ID placeholder
      'name': 'Wallet $walletId',
    };
  }
}
