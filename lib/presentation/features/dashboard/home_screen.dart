import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../core/services/paywall_service.dart';
import 'package:superwallkit_flutter/superwallkit_flutter.dart';

import '../../../domain/entities/transaction_entry.dart';
import '../../../domain/usecases/transaction_usecases.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../../domain/usecases/journal_usecases.dart';
import '../../../domain/services/balance_calculation_service.dart';
import '../../core/atoms/greeting_header.dart';
import '../../core/atoms/expandable_fab.dart';
import '../../core/molecules/balance_summary_widget.dart';
import '../../core/molecules/quick_actions_grid.dart';
import '../../core/molecules/wallets_dashboard_widget.dart';

import '../../core/organisms/app_drawer.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import 'dashboard_widgets_screen.dart'; // AGREGADO: Import de la pantalla de widgets
import 'widgets/recent_transactions_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final WalletUseCases _walletUseCases;
  late final TransactionUseCases _transactionUseCases;
  late final JournalUseCases _journalUseCases;
  final _balanceCalculationService =
      GetIt.instance<BalanceCalculationService>();

  // Dashboard data
  double _totalBalance = 0.0;
  double _income = 0.0;
  double _expenses = 0.0;
  bool _isBalanceVisible = true;

  // Wallets data
  List<WalletDisplayItem> _walletItems = [];
  int _totalWalletsCount = 5;

  List<TransactionEntry> _recentTransactions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _walletUseCases = GetIt.instance<WalletUseCases>();
    _transactionUseCases = GetIt.instance<TransactionUseCases>();
    _journalUseCases = GetIt.instance<JournalUseCases>();
    _loadDashboardData();
    _showPaywallIfNeeded(); // AÑADIDO: Llamada para mostrar la paywall.
  }

  // AÑADIDO: Método para mostrar la paywall si el usuario no está suscrito.
  Future<void> _showPaywallIfNeeded() async {
    // Se espera un momento para no interferir con la animación de entrada.
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final paywallService = GetIt.instance<PaywallService>();

      // 1. Verificar si el usuario ya tiene una suscripción activa usando el SDK de Superwall.
      final isSubscribed = Superwall.shared.subscriptionStatus is SubscriptionStatusActive;

      // 2. Si no está suscrito y el widget está montado, mostrar el paywall.
      if (!isSubscribed && mounted) {
        print(' HomeScreen: User is not subscribed. Triggering paywall...');
        paywallService.registerEvent('campaign_trigger');
      } else {
        print(' HomeScreen: User is subscribed or widget not mounted. Skipping paywall.');
      }
    } catch (e) {
      print(' HomeScreen: Error trying to show paywall: $e');
    }
  }

  Future<void> _loadDashboardData() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    try {
      // Load wallets and calculate total balance
      final totalBalance = await _loadWalletsData();

      // Calculate income and expenses for the current month
      final now = DateTime.now();

      final allTransactions = await _transactionUseCases.getAllTransactions();
      final transactions = allTransactions
          .where((t) => t.date.year == now.year && t.date.month == now.month)
          .toList();
      final income =
          _balanceCalculationService.calculateTotalIncome(transactions);
      final expenses =
          _balanceCalculationService.calculateTotalExpense(transactions);

      // Load recent transactions for the list
      await _loadRecentTransactions();

      if (mounted) {
        setState(() {
          _totalBalance = totalBalance;
          _income = income;
          _expenses = expenses;
        });
      }
    } catch (e) {
      print('Error loading dashboard data: $e');
      // Optionally, show an error message to the user
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<double> _loadWalletsData() async {
    try {
      final wallets = await _walletUseCases.getAllWallets();
      // Filter for active wallets that are children (have a parentId)
      final activeWallets =
          wallets.where((w) => w.active && w.parentId != null).toList();

      final List<WalletDisplayItem> walletItems = [];
      double totalBalance = 0.0;

      for (var wallet in activeWallets) {
        final balanceData =
            await _journalUseCases.getAccountBalance(wallet.chartAccountId);
        final balance = balanceData['balance'] ?? 0.0;
        totalBalance += balance;
        walletItems.add(WalletDisplayItem(
          id: wallet.id,
          name: wallet.name,
          balance: balance,
          icon: Icons.account_balance_wallet,
          iconColor: Colors.white,
          iconBackgroundColor: Colors.blue,
        ));
      }

      if (mounted) {
        setState(() {
          // Show only the first 3 wallets in the dashboard carousel
          _walletItems = walletItems.take(3).toList();
        });
      }

      return totalBalance;
    } catch (e) {
      print('❌ HomeScreen: Error loading wallets data: $e');
      if (mounted) {
        setState(() {
          _walletItems = [];
        });
      }
      return 0.0;
    }
  }

  Future<void> _loadRecentTransactions() async {
    try {
      final transactions = await _transactionUseCases.getAllTransactions();
      if (mounted) {
        setState(() {
          _recentTransactions = transactions.take(5).toList();
        });
      }
    } catch (e) {
      print('Error loading transactions: $e');
    }
  }

  void _navigateToTransactionForm({String type = 'E'}) async {
    final result = await NavigationService.navigateTo(AppRoutes.transactionForm,
        arguments: {
          'initialType': type,
        });

    if (result == true) {
      _loadDashboardData();
    }
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _navigateToDashboardWidgets() {
    // ✅ SOLUCION SIMPLE: Usar Navigator directo sin cambiar el sistema de rutas
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DashboardWidgetsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8FAFC), // HTML: bg-slate-50
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Header with blur effect
          Container(
            color: const Color(0xFFF8FAFC)
                .withOpacity(0.8), // HTML: bg-slate-50/80
            child: SafeArea(
              bottom: false,
              child: GreetingHeader(
                onMenuPressed: _openDrawer,
                onEditPressed:
                    _navigateToDashboardWidgets, // ✅ CORREGIDO: Navegar a widgets config
              ),
            ),
          ),

          // Main content
          Expanded(
            child: _isLoading
                ? _buildLoadingState()
                : SingleChildScrollView(
                    padding:
                        const EdgeInsets.only(bottom: 100), // Space for FAB
                    child: Column(
                      children: [
                        const SizedBox(height: 16), // HTML: mt-4

                        // Balance Summary Widget
                        BalanceSummaryWidget(
                          totalBalance: _totalBalance,
                          income: _income,
                          expenses: _expenses,
                          isBalanceVisible: _isBalanceVisible,
                          onVisibilityToggle: () {
                            setState(() {
                              _isBalanceVisible = !_isBalanceVisible;
                            });
                          },
                        ),

                        const SizedBox(height: 24), // HTML: space-y-6

                        // Quick Actions
                        QuickActionsGrid(
                          onExpensePressed: () =>
                              _navigateToTransactionForm(type: 'E'),
                          onIncomePressed: () =>
                              _navigateToTransactionForm(type: 'I'),
                          onTransferPressed: () =>
                              _navigateToTransactionForm(type: 'T'),
                          onAllPressed: () => NavigationService.navigateTo(
                              AppRoutes.transactions),
                        ),

                        const SizedBox(height: 24),

                        // Wallets Widget
                        WalletsDashboardWidget(
                          wallets: _walletItems,
                          totalCount: _totalWalletsCount,
                          onHeaderTap: () =>
                              NavigationService.navigateTo(AppRoutes.wallets),
                          onWalletTap: (wallet) {
                            // TODO: Navigate to wallet detail
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('View ${wallet.name} details'),
                                backgroundColor: const Color(0xFF0c7ff2),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 24),

                        RecentTransactionsWidget(
                            transactions: _recentTransactions),
                        // TODO: Add Chart of Accounts Widget
                      ],
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: _buildExpandableFAB(),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xFF0c7ff2),
      ),
    );
  }

  Widget _buildExpandableFAB() {
    return ExpandableFab(
      actions: [
        FabAction(
          icon: Icons.trending_up,
          label: 'Income',
          onPressed: () => _navigateToTransactionForm(type: 'I'),
          backgroundColor: const Color(0xFF16A34A), // green-500
        ),
        FabAction(
          icon: Icons.trending_down,
          label: 'Expense',
          onPressed: () => _navigateToTransactionForm(type: 'E'),
          backgroundColor: const Color(0xFFDC2626), // red-500
        ),
        FabAction(
          icon: Icons.swap_horiz,
          label: 'Transfer',
          onPressed: () => _navigateToTransactionForm(type: 'T'),
          backgroundColor: const Color(0xFF2563EB), // blue-500
        ),
      ],
    );
  }
}

