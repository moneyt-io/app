import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entities/transaction.dart';
import '../../../domain/entities/transaction_entry.dart';
import '../../../domain/usecases/transaction_usecases.dart';
import '../../../domain/usecases/category_usecases.dart';
import '../../../domain/usecases/contact_usecases.dart';
import '../../../domain/usecases/wallet_usecases.dart';

class TransactionProvider extends ChangeNotifier {
  final _transactionUseCases = GetIt.instance<TransactionUseCases>();
  final _categoryUseCases = GetIt.instance<CategoryUseCases>();
  final _contactUseCases = GetIt.instance<ContactUseCases>();
  final _walletUseCases = GetIt.instance<WalletUseCases>();

  // State
  List<TransactionEntry> _transactions = [];
  Map<int, String> _categoriesMap = {};
  Map<int, String> _contactsMap = {};
  Map<int, String> _walletsMap = {};
  bool _isLoading = false;
  bool _isInitialLoad = true;
  String? _error;

  // Getters
  List<TransactionEntry> get transactions => _transactions;
  Map<int, String> get categoriesMap => _categoriesMap;
  Map<int, String> get contactsMap => _contactsMap;
  Map<int, String> get walletsMap => _walletsMap;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Constructor
  TransactionProvider() {
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    if (!_isInitialLoad) return; // Avoids unnecessary reloads

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Load all necessary data in parallel for efficiency
      final results = await Future.wait([
        _transactionUseCases.getAllTransactions(),
        _categoryUseCases.getAllCategories(),
        _contactUseCases.getAllContacts(),
        _walletUseCases.getAllWallets(),
      ]);

      // Assign results to state variables
      _transactions = results[0] as List<TransactionEntry>;
      final categories = results[1] as List<dynamic>;
      final contacts = results[2] as List<dynamic>;
      final wallets = results[3] as List<dynamic>;

      _categoriesMap = {for (var c in categories) c.id: c.name};
      _contactsMap = {for (var c in contacts) c.id: c.name};
      _walletsMap = {for (var w in wallets) w.id: w.name};

      _isInitialLoad = false;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<TransactionEntry> createIncome({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int walletId,
    required int categoryId,
    int? contactId,
  }) async {
    try {
      final newTransaction = await _transactionUseCases.createIncome(
        date: date,
        description: description,
        amount: amount,
        currencyId: currencyId,
        walletId: walletId,
        categoryId: categoryId,
        contactId: contactId,
      );
      // The list will be refreshed when the user returns to the transaction list screen.
      return newTransaction;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<TransactionEntry> createExpense({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int paymentId,
    required String paymentTypeId,
    required int categoryId,
    int? contactId,
  }) async {
    try {
      final newTransaction = await _transactionUseCases.createExpense(
        date: date,
        description: description,
        amount: amount,
        currencyId: currencyId,
        paymentId: paymentId,
        paymentTypeId: paymentTypeId,
        categoryId: categoryId,
        contactId: contactId,
      );
      return newTransaction;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<TransactionEntry> createTransfer({
    required DateTime date,
    required String description,
    required double amount,
    required String currencyId,
    required int sourcePaymentId,
    required int targetPaymentId,
    required String targetPaymentTypeId,
    required String targetCurrencyId,
    required double targetAmount,
    int? contactId,
  }) async {
    try {
      final newTransaction = await _transactionUseCases.createTransfer(
        date: date,
        description: description,
        amount: amount,
        currencyId: currencyId,
        sourcePaymentId: sourcePaymentId,
        targetPaymentId: targetPaymentId,
        targetPaymentTypeId: targetPaymentTypeId,
        targetCurrencyId: targetCurrencyId,
        targetAmount: targetAmount,
        contactId: contactId,
      );
      return newTransaction;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> refreshTransactions() async {
    _isLoading = true;
    notifyListeners();
    try {
      _transactions = await _transactionUseCases.getAllTransactions();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTransaction(TransactionEntity transaction) async {
    try {
      await _transactionUseCases.updateTransaction(transaction);
      await refreshTransactions(); // Reload the list to reflect the change
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteTransaction(int transactionId) async {
    try {
      await _transactionUseCases.deleteTransaction(transactionId);
      // Remove the transaction from the local list for an instant UI update
      _transactions.removeWhere((t) => t.id == transactionId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
