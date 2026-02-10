import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../core/services/paywall_service.dart';
import 'package:superwallkit_flutter/superwallkit_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';
import '../wallets/wallet_provider.dart';
import '../../features/transactions/transaction_provider.dart';
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
import '../../core/l10n/generated/strings.g.dart';

class HomeScreen extends StatefulWidget {
  final bool hasJustSeenPaywall;

  const HomeScreen({Key? key, this.hasJustSeenPaywall = false})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _balanceCalculationService =
      GetIt.instance<BalanceCalculationService>();

  double _income = 0.0;
  double _expenses = 0.0;
  bool _isBalanceVisible = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _calculateMonthlySummary();
      }
    });
    _showPaywallIfNeeded();
  }

  // AÑADIDO: Método para mostrar la paywall si el usuario no está suscrito.
  Future<void> _showPaywallIfNeeded() async {
    // Se espera un momento para no interferir con la animación de entrada.
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      // 1. Verificar si el usuario ya tiene una suscripción activa.
      final isSubscribed =
          Superwall.shared.subscriptionStatus is SubscriptionStatusActive;
      if (isSubscribed) {
        print(' HomeScreen: User is already subscribed. Skipping paywall.');
        return;
      }

      // 3. Si no está suscrito y el widget está montado, mostrar el paywall.
      if (mounted) {
        print(
            ' HomeScreen: User is not subscribed. Triggering paywall...');
        _triggerPaywall();
      }
    } catch (e) {
      print(' HomeScreen: Error trying to show paywall: $e');
    }
  }

  void _triggerPaywall() {
    final paywallService = GetIt.instance<PaywallService>();
    paywallService.registerEvent('moneyt_pro');
    print('Paywall event registered');
  }

  void _calculateMonthlySummary() {
    final transactionProvider = context.read<TransactionProvider>();
    final now = DateTime.now();
    final transactions = transactionProvider.transactions
        .where((t) => t.date.year == now.year && t.date.month == now.month)
        .toList();

    final income =
        _balanceCalculationService.calculateTotalIncome(transactions);
    final expenses =
        _balanceCalculationService.calculateTotalExpense(transactions);

    if (mounted) {
      setState(() {
        _income = income;
        _expenses = expenses;
      });
    }
  }

  void _navigateToTransactionForm({String type = 'E'}) {
    NavigationService.navigateTo(AppRoutes.transactionForm, arguments: {
      'initialType': type,
    });
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
    // ✅ OBTENER ALTURA DE LA BARRA DE ESTADO
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    // Altura del contenido del header (ajustar si es necesario) + espaciado deseado
    const double headerContentHeight = 60.0;
    const double spacing = 25.0;
    final double topPadding = statusBarHeight + headerContentHeight + spacing;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8FAFC), // HTML: bg-slate-50
      drawer: const AppDrawer(),
      body: Consumer<WalletProvider>(
        builder: (context, walletProvider, child) {
          if (walletProvider.isLoading) {
            return _buildLoadingState();
          }

          // Map wallets to display items
          final walletItems = walletProvider.wallets
              .where((w) =>
                  w.parentId != null) // Show only child accounts on dashboard
              .map((wallet) => WalletDisplayItem(
                    id: wallet.id,
                    name: wallet.name,
                    balance: walletProvider.walletBalances[wallet.id] ?? 0.0,
                    icon: Icons.account_balance_wallet,
                    iconColor: Colors.white,
                    iconBackgroundColor: Colors.blue,
                  ))
              .toList();

          return Stack(
            children: [
              // ✅ CONTENIDO DESPLAZABLE (EN EL FONDO)
              SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: topPadding, // Padding calculado y preciso
                  bottom: 100, // Space for FAB
                ),
                child: Column(
                  children: [
                    BalanceSummaryWidget(
                      totalBalance: walletProvider.totalBalance,
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
                    QuickActionsGrid(
                      onExpensePressed: () =>
                          _navigateToTransactionForm(type: 'E'),
                      onIncomePressed: () =>
                          _navigateToTransactionForm(type: 'I'),
                      onTransferPressed: () =>
                          _navigateToTransactionForm(type: 'T'),
                      onAllPressed: () =>
                          NavigationService.navigateTo(AppRoutes.transactions),
                    ),
                    const SizedBox(height: 24),
                    WalletsDashboardWidget(
                      wallets: walletItems.take(3).toList(), // Show first 3
                      totalCount: walletProvider.wallets.length,
                      onHeaderTap: () =>
                          NavigationService.navigateTo(AppRoutes.wallets),
                      onWalletTap: (wallet) {
                        // TODO: Navigate to wallet detail
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(t.dashboard.wallets.viewDetails(name: wallet.name)),
                            backgroundColor: const Color(0xFF0c7ff2),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    RecentTransactionsWidget(),
                    const SizedBox(height: 24),
                    _buildCustomizeButton(),
                  ],
                ),
              ),
              // ✅ HEADER FLOTANTE CON BLUR (ENCIMA)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                    child: Container(
                      color: const Color(0xFFF8FAFC).withOpacity(0.8),
                      child: SafeArea(
                        bottom: false,
                        child: GreetingHeader(
                          onMenuPressed: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          onStarPressed: () {
                            _triggerPaywall();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
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
          label: t.dashboard.actions.income,
          onPressed: () => _navigateToTransactionForm(type: 'I'),
          backgroundColor: const Color(0xFF16A34A), // green-500
        ),
        FabAction(
          icon: Icons.trending_down,
          label: t.dashboard.actions.expense,
          onPressed: () => _navigateToTransactionForm(type: 'E'),
          backgroundColor: const Color(0xFFDC2626), // red-500
        ),
        FabAction(
          icon: Icons.swap_horiz,
          label: t.dashboard.actions.transfer,
          onPressed: () => _navigateToTransactionForm(type: 'T'),
          backgroundColor: const Color(0xFF2563EB), // blue-500
        ),
      ],
    );
  }

  Widget _buildCustomizeButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: OutlinedButton.icon(
        onPressed: _navigateToDashboardWidgets,
        icon: const Icon(Icons.edit,
            color: Color(0xFF64748B), size: 20), // text-slate-500
        label: Text(
          t.dashboard.customize,
          style: const TextStyle(color: Color(0xFF64748B)), // text-slate-500
        ),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50), // Full width
          side: const BorderSide(color: Color(0xFFE2E8F0)), // border-slate-200
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
