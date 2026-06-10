import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import '../../../core/services/exchange_rate_service.dart';
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
    // Legacy getter, returns raw sum
    return _wallets
        .where((wallet) => wallet.parentId == null)
        .fold(0.0, (sum, wallet) => sum + (_walletBalances[wallet.id] ?? 0.0));
  }

  double getTotalBalance(String baseCurrencyId) {
    // Legacy logic: Ignore baseCurrencyId, return raw sum (Absolute numbers)
    return _wallets
        .where((wallet) => wallet.parentId == null)
        .fold(0.0, (sum, wallet) {
      final rawBalance = _walletBalances[wallet.id] ?? 0.0;
      return sum + rawBalance;
    });
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
    // Optimización: Un solo viaje a base de datos
    final Map<int, double> individualBalances = 
        await _balanceService.calculateAllWalletBalances();
        
    // Asegurar que las wallets que no tienen transacciones aparezcan con 0.0
    for (final wallet in _wallets) {
      if (!individualBalances.containsKey(wallet.id)) {
        individualBalances[wallet.id] = 0.0;
      }
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
    int? parentId, // Wallet parent ID
    required String name,
    required String currencyId,
    String? description,
    String? icon,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _walletUseCases.createWalletWithAccount(
        parentId: parentId,
        name: name,
        currencyId: currencyId,
        description: description,
        icon: icon,
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
