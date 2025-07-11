import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/services/paywall_service.dart';
import '../../../domain/entities/transaction_entry.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/usecases/transaction_usecases.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../core/atoms/greeting_header.dart';
import '../../core/atoms/expandable_fab.dart';
import '../../core/molecules/balance_summary_widget.dart';
import '../../core/molecules/quick_actions_grid.dart';
import '../../core/molecules/wallets_dashboard_widget.dart';
import '../../core/molecules/loans_dashboard_widget.dart';
import '../../core/organisms/app_drawer.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import 'dashboard_widgets_screen.dart'; // ✅ AGREGADO: Import de la pantalla de widgets

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _transactionUseCases = GetIt.instance<TransactionUseCases>();
  final _walletUseCases = GetIt.instance<WalletUseCases>();
  
  // Dashboard data
  double _totalBalance = 24567.80;
  double _income = 8420.00;
  double _expenses = 3890.50;
  bool _isBalanceVisible = true;
  
  // Wallets data
  List<WalletDisplayItem> _walletItems = [];
  int _totalWalletsCount = 5;
  
  // Loans data
  double _youLent = 2300.00;
  double _youBorrowed = 1200.00;
  int _activeLoansCount = 3;
  
  List<TransactionEntry> _recentTransactions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
    _showPaywallIfNeeded(); // ✅ AÑADIDO: Llamada para mostrar la paywall.
  }

  // ✅ AÑADIDO: Método para mostrar la paywall si es la primera vez.
  Future<void> _showPaywallIfNeeded() async {
    // Se espera un momento para no interferir con la animación de entrada.
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final prefs = await SharedPreferences.getInstance();
      const paywallShownKey = 'paywall_shown_on_home';
      final bool hasBeenShown = prefs.getBool(paywallShownKey) ?? false;

      if (!hasBeenShown && mounted) {
        print('🔥 HomeScreen: Paywall not shown yet. Triggering event...');
        final paywallService = GetIt.instance<PaywallService>();
        
        // Disparar el evento de Superwall.
        paywallService.registerEvent('campaign_trigger');
        
        // Marcar que la paywall ya se intentó mostrar.
        await prefs.setBool(paywallShownKey, true);
      } else {
        print('✅ HomeScreen: Paywall already shown or widget not mounted. Skipping.');
      }
    } catch (e) {
      print('❌ HomeScreen: Error trying to show paywall: $e');
    }
  }

  Future<void> _loadDashboardData() async {
    setState(() => _isLoading = true);
    
    try {
      // Load wallets and their balances
      await _loadWalletsData();
      
      // Load recent transactions
      await _loadRecentTransactions();
      
      // TODO: Load real balance data from services
      // TODO: Load real loans data from services
      
    } catch (e) {
      print('Error loading dashboard data: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _loadWalletsData() async {
    try {
      final wallets = await _walletUseCases.getAllWallets();
      final activeWallets = wallets.where((w) => w.active).toList();
      
      // Create wallet display items with mock balances
      final walletItems = <WalletDisplayItem>[];
      final mockBalances = [12340.50, 8920.30, 1450.00]; // From HTML
      
      for (int i = 0; i < activeWallets.length && i < 3; i++) {
        final balance = i < mockBalances.length ? mockBalances[i] : 0.0;
        walletItems.add(WalletDisplayItem.fromWallet(activeWallets[i], balance));
      }
      
      if (mounted) {
        setState(() {
          _walletItems = walletItems;
          _totalWalletsCount = activeWallets.length;
        });
      }
    } catch (e) {
      print('Error loading wallets: $e');
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

  void _navigateToTransactionForm({String type = 'all'}) {
    NavigationService.navigateTo(AppRoutes.transactionForm, arguments: {
      'type': type,
    });
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
            color: const Color(0xFFF8FAFC).withOpacity(0.8), // HTML: bg-slate-50/80
            child: SafeArea(
              bottom: false,
              child: GreetingHeader(
                userName: 'Alex', // TODO: Get from user service
                onMenuPressed: _openDrawer,
                onEditPressed: _navigateToDashboardWidgets, // ✅ CORREGIDO: Navegar a widgets config
                onProfilePressed: () {
                  NavigationService.navigateTo(AppRoutes.settings);
                },
              ),
            ),
          ),
          
          // Main content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100), // Space for FAB
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
                    onExpensePressed: () => _navigateToTransactionForm(type: 'expense'),
                    onIncomePressed: () => _navigateToTransactionForm(type: 'income'),
                    onTransferPressed: () => _navigateToTransactionForm(type: 'transfer'),
                    onAllPressed: () => NavigationService.navigateTo(AppRoutes.transactions),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Wallets Widget
                  WalletsDashboardWidget(
                    wallets: _walletItems,
                    totalCount: _totalWalletsCount,
                    onHeaderTap: () => NavigationService.navigateTo(AppRoutes.wallets),
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
                  
                  // Loans Widget
                  LoansDashboardWidget(
                    youLent: _youLent,
                    youBorrowed: _youBorrowed,
                    activeLoansCount: _activeLoansCount,
                    onHeaderTap: () {
                      // TODO: Navigate to loans screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Loans module coming soon'),
                          backgroundColor: Color(0xFF0c7ff2),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // TODO: Add Recent Transactions Widget
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
          label: 'Add Income',
          onPressed: () => _navigateToTransactionForm(type: 'income'),
          backgroundColor: const Color(0xFF16A34A), // green-500
        ),
        FabAction(
          icon: Icons.trending_down,
          label: 'Add Expense',
          onPressed: () => _navigateToTransactionForm(type: 'expense'),
          backgroundColor: const Color(0xFFDC2626), // red-500
        ),
        FabAction(
          icon: Icons.swap_horiz,
          label: 'Transfer Money',
          onPressed: () => _navigateToTransactionForm(type: 'transfer'),
          backgroundColor: const Color(0xFF2563EB), // blue-500
        ),
      ],
    );
  }
}