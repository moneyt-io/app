import 'package:injectable/injectable.dart';
import '../entities/journal_entry.dart';
import '../entities/journal_detail.dart';
import '../repositories/journal_repository.dart';

@injectable
class JournalUseCases {
  final JournalRepository _repository;
  
  JournalUseCases(this._repository);
  
  // Consultas básicas
  Future<List<JournalEntry>> getAllJournalEntries() => 
      _repository.getAllJournalEntries();
  
  Future<JournalEntry?> getJournalEntryById(int id) => 
      _repository.getJournalEntryById(id);
  
  Future<List<JournalEntry>> getJournalEntriesByType(String documentTypeId) =>
      _repository.getJournalEntriesByType(documentTypeId);
      
  Future<List<JournalEntry>> getJournalEntriesByDate(DateTime startDate, DateTime endDate) =>
      _repository.getJournalEntriesByDate(startDate, endDate);
      
  Future<List<JournalEntry>> getJournalEntriesByAccount(int chartAccountId) =>
      _repository.getJournalEntriesByAccount(chartAccountId);
  
  // Observación en tiempo real
  Stream<List<JournalEntry>> watchAllJournalEntries() => 
      _repository.watchAllJournalEntries();
      
  Stream<JournalEntry?> watchJournalEntryById(int id) =>
      _repository.watchJournalEntryById(id);
  
  // Operaciones CRUD
  Future<JournalEntry> createJournalEntry(
    JournalEntry entry, 
    List<JournalDetail> details
  ) => _repository.createJournalEntry(entry, details);
  
  Future<void> updateJournalEntry(JournalEntry entry) => 
      _repository.updateJournalEntry(entry);
  
  Future<void> deleteJournalEntry(int id) => 
      _repository.deleteJournalEntry(id);
  
  // Métodos específicos para la generación de asientos contables
  
  /// Crea un asiento contable de ingreso (tipo "I")
  /// 
  /// Genera un débito a la cuenta de activo (wallet) y un crédito a la cuenta de ingreso (categoría)
  Future<JournalEntry> createIncomeJournal({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int walletChartAccountId,
    required int categoryChartAccountId,
    double rateExchange = 1.0,
  }) async {
    // Crear la entrada del diario
    final entry = JournalEntry(
      id: 0, // Se asignará automáticamente
      documentTypeId: 'I', // Ingreso
      secuencial: await _repository.getNextSecuencial('I'),
      date: date,
      description: description,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: null,
      deletedAt: null,
      details: [],
    );
    
    // Crear los detalles (partida doble)
    final details = [
      // Débito a la cuenta de activo (wallet)
      JournalDetail(
        id: 0,
        journalId: 0, // Se asignará después
        currencyId: currencyId,
        chartAccountId: walletChartAccountId,
        debit: amount,
        credit: 0,
        rateExchange: rateExchange,
      ),
      // Crédito a la cuenta de ingresos (categoría)
      JournalDetail(
        id: 0,
        journalId: 0, // Se asignará después
        currencyId: currencyId,
        chartAccountId: categoryChartAccountId,
        debit: 0,
        credit: amount,
        rateExchange: rateExchange,
      ),
    ];
    
    // Guardar el asiento contable completo
    return createJournalEntry(entry, details);
  }
  
  /// Crea un asiento contable de gasto (tipo "E")
  /// 
  /// Genera un débito a la cuenta de gastos (categoría) y un crédito a la cuenta de activo (wallet)
  Future<JournalEntry> createExpenseJournal({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int walletChartAccountId,
    required int categoryChartAccountId,
    double rateExchange = 1.0,
  }) async {
    // Crear la entrada del diario
    final entry = JournalEntry(
      id: 0, // Se asignará automáticamente
      documentTypeId: 'E', // Gasto
      secuencial: await _repository.getNextSecuencial('E'),
      date: date,
      description: description,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: null,
      deletedAt: null,
      details: [],
    );
    
    // Crear los detalles (partida doble)
    final details = [
      // Débito a la cuenta de gastos (categoría)
      JournalDetail(
        id: 0,
        journalId: 0, // Se asignará después
        currencyId: currencyId,
        chartAccountId: categoryChartAccountId,
        debit: amount,
        credit: 0,
        rateExchange: rateExchange,
      ),
      // Crédito a la cuenta de activo (wallet)
      JournalDetail(
        id: 0,
        journalId: 0, // Se asignará después
        currencyId: currencyId,
        chartAccountId: walletChartAccountId,
        debit: 0,
        credit: amount,
        rateExchange: rateExchange,
      ),
    ];
    
    // Guardar el asiento contable completo
    return createJournalEntry(entry, details);
  }
  
  /// Crea un asiento contable de transferencia (tipo "T")
  /// 
  /// Genera un débito a la cuenta destino y un crédito a la cuenta origen
  Future<JournalEntry> createTransferJournal({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int sourceChartAccountId,
    required int targetChartAccountId,
    required String targetCurrencyId,
    required double targetAmount,
    required double rateExchange,
  }) async {
    // Crear la entrada del diario
    final entry = JournalEntry(
      id: 0, // Se asignará automáticamente
      documentTypeId: 'T', // Transferencia
      secuencial: await _repository.getNextSecuencial('T'), 
      date: date,
      description: description,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: null,
      deletedAt: null,
      details: [],
    );
    
    // Crear los detalles (partida doble)
    final details = [
      // Débito a la cuenta destino
      JournalDetail(
        id: 0,
        journalId: 0, // Se asignará después
        currencyId: targetCurrencyId,
        chartAccountId: targetChartAccountId,
        debit: targetAmount,
        credit: 0,
        rateExchange: rateExchange,
      ),
      // Crédito a la cuenta origen
      JournalDetail(
        id: 0,
        journalId: 0, // Se asignará después
        currencyId: currencyId,
        chartAccountId: sourceChartAccountId,
        debit: 0,
        credit: amount,
        rateExchange: 1.0, // Moneda base
      ),
    ];
    
    // Si hay diferencia de cambio (caso multi-divisa), añadir asiento de ajuste
    if (currencyId != targetCurrencyId && (amount * rateExchange) != targetAmount) {
      final difference = targetAmount - (amount * rateExchange);
      
      // Añadir asiento de ajuste por diferencia de cambio
      if (difference > 0) {
        // Ganancia por cambio - Débito a la cuenta destino, crédito a cuenta de ganancia por cambio
        details.add(
          JournalDetail(
            id: 0,
            journalId: 0,
            currencyId: targetCurrencyId,
            // Aquí deberíamos referenciar una cuenta específica de ganancia por TC
            // Por simplicidad, usamos la misma cuenta destino
            chartAccountId: targetChartAccountId, // En implementación real, usar cuenta de ganancia
            debit: 0,
            credit: difference.abs(),
            rateExchange: rateExchange,
          ),
        );
      } else if (difference < 0) {
        // Pérdida por cambio - Débito a cuenta de pérdida por cambio, crédito a cuenta destino
        details.add(
          JournalDetail(
            id: 0,
            journalId: 0,
            currencyId: targetCurrencyId,
            // Aquí deberíamos referenciar una cuenta específica de pérdida por TC
            // Por simplicidad, usamos la misma cuenta destino
            chartAccountId: targetChartAccountId, // En implementación real, usar cuenta de pérdida
            debit: difference.abs(),
            credit: 0,
            rateExchange: rateExchange,
          ),
        );
      }
    }
    
    // Guardar el asiento contable completo
    return createJournalEntry(entry, details);
  }
  
  /// Crea un asiento contable para un préstamo otorgado (tipo "L")
  Future<JournalEntry> createLendJournal({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int walletChartAccountId,
    required int receivableChartAccountId,
    double rateExchange = 1.0,
  }) async {
    // Crear la entrada del diario
    final entry = JournalEntry(
      id: 0,
      documentTypeId: 'L', // Préstamo otorgado
      secuencial: await _repository.getNextSecuencial('L'),
      date: date,
      description: description,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: null,
      deletedAt: null,
      details: [],
    );
    
    // Crear los detalles (partida doble)
    final details = [
      // Débito a la cuenta por cobrar
      JournalDetail(
        id: 0,
        journalId: 0,
        currencyId: currencyId,
        chartAccountId: receivableChartAccountId,
        debit: amount,
        credit: 0,
        rateExchange: rateExchange,
      ),
      // Crédito a la cuenta de activo (wallet)
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
    
    return createJournalEntry(entry, details);
  }
  
  /// Crea un asiento contable para un préstamo recibido (tipo "B")
  Future<JournalEntry> createBorrowJournal({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int walletChartAccountId,
    required int payableChartAccountId,
    double rateExchange = 1.0,
  }) async {
    // Crear la entrada del diario
    final entry = JournalEntry(
      id: 0,
      documentTypeId: 'B', // Préstamo recibido
      secuencial: await _repository.getNextSecuencial('B'),
      date: date,
      description: description,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: null,
      deletedAt: null,
      details: [],
    );
    
    // Crear los detalles (partida doble)
    final details = [
      // Débito a la cuenta de activo (wallet)
      JournalDetail(
        id: 0,
        journalId: 0,
        currencyId: currencyId,
        chartAccountId: walletChartAccountId,
        debit: amount,
        credit: 0,
        rateExchange: rateExchange,
      ),
      // Crédito a la cuenta por pagar
      JournalDetail(
        id: 0,
        journalId: 0,
        currencyId: currencyId,
        chartAccountId: payableChartAccountId,
        debit: 0,
        credit: amount,
        rateExchange: rateExchange,
      ),
    ];
    
    return createJournalEntry(entry, details);
  }
  
  /// Obtiene el balance de una cuenta contable en un período
  Future<Map<String, double>> getAccountBalance(
    int chartAccountId, {
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    return _repository.getAccountBalance(
      chartAccountId,
      fromDate: fromDate,
      toDate: toDate,
    );
  }
}
