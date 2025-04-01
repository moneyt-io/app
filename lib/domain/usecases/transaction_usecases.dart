import 'package:injectable/injectable.dart';
import '../entities/transaction_entry.dart';
import '../repositories/transaction_repository.dart';
import '../repositories/journal_repository.dart';
import '../repositories/wallet_repository.dart';
import '../repositories/category_repository.dart';

@injectable
class TransactionUseCases {
  final TransactionRepository _transactionRepository;
  final JournalRepository _journalRepository;
  final WalletRepository _walletRepository;
  final CategoryRepository _categoryRepository;
  
  TransactionUseCases(
    this._transactionRepository,
    this._journalRepository,
    this._walletRepository,
    this._categoryRepository,
  );
  
  // Consultas básicas
  Future<List<TransactionEntry>> getAllTransactions() => 
      _transactionRepository.getAllTransactions();
  
  Future<TransactionEntry?> getTransactionById(int id) => 
      _transactionRepository.getTransactionById(id);
      
  Future<List<TransactionEntry>> getTransactionsByType(String documentTypeId) =>
      _transactionRepository.getTransactionsByType(documentTypeId);
  
  Stream<List<TransactionEntry>> watchAllTransactions() => 
      _transactionRepository.watchAllTransactions();
  
  // Operaciones CRUD coordinadas con diarios contables
  Future<TransactionEntry> createIncome({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int walletId,
    required int categoryId,
    int? contactId,
    double rateExchange = 1.0,
  }) async {
    // 1. Obtener información de la wallet y categoría para los asientos contables
    final wallet = await _walletRepository.getWalletById(walletId);
    final category = await _categoryRepository.getCategoryById(categoryId);
    
    if (wallet == null || category == null) {
      throw Exception('Wallet o categoría no encontrada');
    }
    
    // 2. Crear el diario contable usando directamente el repositorio
    final journalEntry = await _journalRepository.createIncomeJournal(
      date: date,
      description: description,
      amount: amount,
      currencyId: currencyId,
      walletChartAccountId: wallet.chartAccountId,
      categoryChartAccountId: category.chartAccountId,
      rateExchange: rateExchange,
    );
    
    // 3. Crear la transacción vinculada al diario contable
    return _transactionRepository.createIncomeTransaction(
      date: date,
      description: description,
      amount: amount,
      currencyId: currencyId,
      walletId: walletId,
      categoryId: categoryId,
      contactId: contactId,
      rateExchange: rateExchange,
    );
  }
  
  Future<TransactionEntry> createExpense({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int walletId,
    required int categoryId,
    int? contactId,
    double rateExchange = 1.0,
  }) async {
    // 1. Obtener información de la wallet y categoría
    final wallet = await _walletRepository.getWalletById(walletId);
    final category = await _categoryRepository.getCategoryById(categoryId);
    
    if (wallet == null || category == null) {
      throw Exception('Wallet o categoría no encontrada');
    }
    
    // 2. Crear diario contable
    final journalEntry = await _journalRepository.createExpenseJournal(
      date: date,
      description: description,
      amount: amount,
      currencyId: currencyId,
      walletChartAccountId: wallet.chartAccountId,
      categoryChartAccountId: category.chartAccountId,
      rateExchange: rateExchange,
    );
    
    // 3. Crear transacción vinculada al diario
    return _transactionRepository.createExpenseTransaction(
      date: date,
      description: description,
      amount: amount,
      currencyId: currencyId,
      walletId: walletId,
      categoryId: categoryId,
      contactId: contactId,
      rateExchange: rateExchange,
    );
  }
  
  Future<TransactionEntry> createTransfer({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int sourceWalletId,
    required int targetWalletId,
    required String targetCurrencyId,
    required double targetAmount,
    double rateExchange = 1.0,
    int? contactId,
  }) async {
    // 1. Obtener información de las wallets
    final sourceWallet = await _walletRepository.getWalletById(sourceWalletId);
    final targetWallet = await _walletRepository.getWalletById(targetWalletId);
    
    if (sourceWallet == null || targetWallet == null) {
      throw Exception('Wallet origen o destino no encontrada');
    }
    
    // 2. Crear diario contable
    final journalEntry = await _journalRepository.createTransferJournal(
      date: date,
      description: description,
      amount: amount,
      currencyId: currencyId,
      sourceChartAccountId: sourceWallet.chartAccountId,
      targetChartAccountId: targetWallet.chartAccountId,
      targetCurrencyId: targetCurrencyId,
      targetAmount: targetAmount,
      rateExchange: rateExchange,
    );
    
    // 3. Crear transacción vinculada al diario
    return _transactionRepository.createTransferTransaction(
      date: date,
      description: description,
      amount: amount,
      sourceWalletId: sourceWalletId,
      targetWalletId: targetWalletId,
      targetAmount: targetAmount,
      rateExchange: rateExchange,
      contactId: contactId,
    );
  }
  
  // CRUD Operations para transacciones existentes
  Future<void> updateTransaction(TransactionEntry transaction) => 
      _transactionRepository.updateTransaction(transaction);
  
  Future<void> deleteTransaction(int id) => 
      _transactionRepository.deleteTransaction(id);
  
  // Métodos de utilidad
  Future<double> getWalletBalance(int walletId) async {
    // Implementación pendiente
    // Calcular el balance sumando los ingresos y restando los egresos
    return 0.0;
  }
  
  Future<Map<String, double>> getCategoryStatistics(int categoryId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    // Implementación pendiente
    // Calcular estadísticas para la categoría en el periodo dado
    return {'total': 0.0};
  }
}
