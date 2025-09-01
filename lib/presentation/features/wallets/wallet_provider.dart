import 'package:flutter/foundation.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../../domain/services/balance_calculation_service.dart';

class WalletProvider with ChangeNotifier {
  final WalletUseCases _walletUseCases;
  final BalanceCalculationService _balanceService;

  List<Wallet> _wallets = [];
  Map<int, double> _walletBalances = {};
  bool _isLoading = false;
  String? _error;

  List<Wallet> get wallets => _wallets;
  Map<int, double> get walletBalances => _walletBalances;
  bool get isLoading => _isLoading;
  String? get error => _error;

  double get totalBalance {
    // Sum the balances of top-level wallets only to avoid double-counting.
    return _wallets
        .where((wallet) => wallet.parentId == null)
        .fold(0.0, (sum, wallet) => sum + (_walletBalances[wallet.id] ?? 0.0));
  }

  WalletProvider(this._walletUseCases, this._balanceService) {
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final allWallets = await _walletUseCases.getAllWallets();
      _wallets = allWallets;

      await _loadWalletBalances();

    } catch (e) {
      _error = 'Failed to load wallet data: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadWalletBalances() async {
    final Map<int, double> individualBalances = {};
    for (final wallet in _wallets) {
      final balance = await _balanceService.calculateWalletBalance(wallet.id);
      individualBalances[wallet.id] = balance;
    }

    final Map<int, double> consolidatedBalances = Map.from(individualBalances);

    // Consolidate balances for parent wallets
    final topLevelWallets = _wallets.where((w) => w.parentId == null).toList();
    for (final parentWallet in topLevelWallets) {
      final children = _wallets.where((w) => w.parentId == parentWallet.id).toList();
      double parentTotal = consolidatedBalances[parentWallet.id] ?? 0.0;
      if (children.isNotEmpty) {
        parentTotal += children.fold(0.0, (sum, child) => sum + (consolidatedBalances[child.id] ?? 0.0));
      }
      consolidatedBalances[parentWallet.id] = parentTotal;
    }

    _walletBalances = consolidatedBalances;
  }

  Future<void> recalculateBalances() async {
    if (_isLoading) return; // Avoid concurrent updates

    _isLoading = true;
    notifyListeners();

    try {
      // We only need to recalculate balances, not the whole wallet list.
      await _loadWalletBalances();
      _error = null;
    } catch (e) {
      _error = 'Failed to recalculate wallet balances: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createWalletWithAccount({
    required String name,
    String? description,
    required String currencyId,
    int? parentId,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _walletUseCases.createWalletWithAccount(
        name: name,
        description: description,
        currencyId: currencyId,
        parentId: parentId,
      );
      await loadInitialData(); // Reload all data to ensure consistency
    } catch (e) {
      _error = 'Failed to create wallet: ${e.toString()}';
      notifyListeners();
      throw e; // Re-throw to be caught in the UI if needed
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateWallet(Wallet wallet) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _walletUseCases.updateWallet(wallet);
      await loadInitialData(); // Reload all data to ensure consistency
    } catch (e) {
      _error = 'Failed to update wallet: ${e.toString()}';
      notifyListeners();
      throw e; // Re-throw to be caught in the UI if needed
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteWallet(int walletId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _walletUseCases.deleteWallet(walletId);
      await loadInitialData(); // Reload all data to ensure consistency
    } catch (e) {
      if (e.toString().contains('Cannot delete wallet: It has associated transactions.')) {
        _error = 'This wallet cannot be deleted because it has transactions linked to it.';
      } else {
        _error = 'Failed to delete wallet: ${e.toString()}';
      }
      notifyListeners();
      // Do not re-throw, as the provider now handles the error state for the UI.
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
