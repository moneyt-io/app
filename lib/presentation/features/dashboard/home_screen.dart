import 'dart:ui';
import 'dart:convert'; // Added for JSON
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Added
import '../../../core/services/paywall_service.dart';
import 'package:superwallkit_flutter/superwallkit_flutter.dart';

import 'package:provider/provider.dart';
import '../wallets/wallet_provider.dart';
import '../../features/transactions/transaction_provider.dart';
import '../../../domain/services/balance_calculation_service.dart';
import '../../core/atoms/greeting_header.dart';
import '../../core/atoms/expandable_fab.dart';
import '../../core/molecules/balance_summary_widget.dart';
import '../../core/molecules/quick_actions_grid.dart';
import '../../core/molecules/wallets_dashboard_widget.dart';
import '../../core/molecules/widget_config_item.dart'; // Added

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

  bool _isBalanceVisible = true;
  List<WidgetConfig> _widgetConfigs = []; // Stores widget configuration

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Ensure widgets config is loaded
        _loadWidgetConfiguration(); // Load widgets on init
      }
    });
    _showPaywallIfNeeded();
  }

  /// Carga la configuración de widgets desde SharedPreferences
  Future<void> _loadWidgetConfiguration() async {
    final prefs = await SharedPreferences.getInstance();
    final String? configString = prefs.getString('dashboard_widgets_config');

    if (configString != null) {
      try {
        final List<dynamic> jsonList = jsonDecode(configString);
        if (mounted) {
          setState(() {
            _widgetConfigs = jsonList
                .map((item) => WidgetConfig(
                      type: DashboardWidgetType.values.firstWhere(
                          (e) => e.toString() == item['type'],
                          orElse: () => DashboardWidgetType.balance),
                      enabled: item['enabled'],
                      order: item['order'],
                    ))
                .toList();
            // Sort by order
            _widgetConfigs.sort((a, b) => a.order.compareTo(b.order));
          });
        }
        return;
      } catch (e) {
        debugPrint('Error parsing widget config: $e');
      }
    }

    // Default configuration if nothing saved
    if (mounted) {
      setState(() {
        _widgetConfigs = [
          const WidgetConfig(
              type: DashboardWidgetType.balance, enabled: true, order: 1),
          const WidgetConfig(
              type: DashboardWidgetType.quickActions, enabled: true, order: 2),
          const WidgetConfig(
              type: DashboardWidgetType.wallets, enabled: true, order: 3),
          const WidgetConfig(
              type: DashboardWidgetType.transactions, enabled: true, order: 4),
           // Add others hidden by default to match DashboardWidgetsScreen default
          const WidgetConfig(
              type: DashboardWidgetType.loans, enabled: false, order: 5),
          const WidgetConfig(
              type: DashboardWidgetType.chartAccounts, enabled: false, order: 6),
          const WidgetConfig(
              type: DashboardWidgetType.creditCards, enabled: false, order: 7),
        ];
      });
    }
  }

  // AÑADIDO: Método para mostrar la paywall si el usuario no está suscrito.
  Future<void> _showPaywallIfNeeded() async {
    // Esperar un momento para no interferir con la animación de entrada.
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      // isPremiumNotifier ya tiene el valor correcto porque PaywallService.init()
      // espera activamente el primer estado de Superwall antes de retornar.
      final isSubscribed = GetIt.instance<PaywallService>().isPremiumNotifier.value;
      if (isSubscribed) {
        print(' HomeScreen: User is already subscribed. Skipping paywall.');
        return;
      }

      if (mounted) {
        print(' HomeScreen: User is not subscribed. Triggering paywall...');
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

  void _navigateToTransactionForm({String type = 'E'}) {
    NavigationService.navigateTo(AppRoutes.transactionForm, arguments: {
      'initialType': type,
    });
  }

  Future<void> _navigateToDashboardWidgets() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DashboardWidgetsScreen(),
      ),
    );

    // Reload widgets if changes were made (result is true)
    if (result == true) {
      _loadWidgetConfiguration();
    }
  }

  /// Calcular el balance total excluyendo cuentas archivadas
  double _calculateActiveTotalBalance(WalletProvider provider) {
    // 1. Obtener todas las wallets
    final allWallets = provider.wallets;
    
    // 2. Filtrar solo las wallets ACTIVAS
    // Un hijo se considera activo si él mismo es activo Y su padre (si tiene) tambien es activo.
    // Sin embargo, por simplicidad y siguiendo la lógica de WalletsScreen:
    // "Active" filter sums "Own Balance" of active wallets.
    
    double total = 0.0;
    
    for (var wallet in allWallets) {
      if (wallet.active) {
        // Obtenemos el balance del wallet
        double balance = provider.walletBalances[wallet.id] ?? 0.0;
        
        // Si es PADRE, su balance en el provider es consolidado (suma de hijos).
        // Debemos restar los hijos para obtener su "Own Balance" puro antes de sumar,
        // ya que los hijos activos se sumarán individualmente en su turno del bucle.
        if (wallet.parentId == null) {
          final children = allWallets.where((w) => w.parentId == wallet.id);
          for (var child in children) {
            balance -= (provider.walletBalances[child.id] ?? 0.0);
          }
        }
        
        total += balance;
      }
    }
    
    return total;
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
      body: Consumer2<WalletProvider, TransactionProvider>(
        builder: (context, walletProvider, transactionProvider, child) {
          if (walletProvider.isLoading) {
            return _buildLoadingState();
          }

          // Calcular resumen mensual dinámicamente
          final now = DateTime.now();
          final currentMonthTransactions = transactionProvider.transactions
              .where((t) => t.date.year == now.year && t.date.month == now.month)
              .toList();
          
          final income = _balanceCalculationService.calculateTotalIncome(currentMonthTransactions);
          final expenses = _balanceCalculationService.calculateTotalExpense(currentMonthTransactions);

          // Map wallets to display items
          final walletItems = walletProvider.wallets
              .where((w) =>
                  w.parentId != null && w.active) // Show only active child accounts on dashboard
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
                    // Dynamic Widget Rendering Loop
                    ..._widgetConfigs.where((config) => config.enabled).map((config) {
                      switch (config.type) {
                        case DashboardWidgetType.balance:
                          return Column(
                            children: [
                              BalanceSummaryWidget(
                                totalBalance: _calculateActiveTotalBalance(
                                    walletProvider), // ✅ Usando cálculo filtrado
                                income: income,
                                expenses: expenses,
                                isBalanceVisible: _isBalanceVisible,
                                onVisibilityToggle: () {
                                  setState(() {
                                    _isBalanceVisible = !_isBalanceVisible;
                                  });
                                },
                              ),
                              const SizedBox(height: 24),
                            ],
                          );
                        case DashboardWidgetType.quickActions:
                          return Column(
                            children: [
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
                            ],
                          );
                        case DashboardWidgetType.wallets:
                          return Column(
                            children: [
                              WalletsDashboardWidget(
                                wallets: walletItems.take(3).toList(), // Show first 3
                                totalCount: walletProvider.wallets.length,
                                onHeaderTap: () => NavigationService.navigateTo(
                                    AppRoutes.wallets),
                                onWalletTap: (wallet) {
                                  // TODO: Navigate to wallet detail if needed in the future
                                },
                              ),
                              const SizedBox(height: 24),
                            ],
                          );
                        case DashboardWidgetType.transactions:
                          return Column(
                            children: [
                              RecentTransactionsWidget(),
                              const SizedBox(height: 24),
                            ],
                          );
                        // Add handlers for other widget types if implemented in the future (loans, charts, etc.)
                         case DashboardWidgetType.loans:
                           // Placeholder for Loans widget
                           return const SizedBox.shrink();
                         case DashboardWidgetType.chartAccounts:
                           // Placeholder for Chart Accounts widget
                           return const SizedBox.shrink(); 
                         case DashboardWidgetType.creditCards:
                           // Placeholder for Credit Cards widget
                           return const SizedBox.shrink();   
                        default:
                          return const SizedBox.shrink();
                      }
                    }).toList(),

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
                        child: ValueListenableBuilder<bool>(
                          valueListenable: GetIt.instance<PaywallService>().isPremiumNotifier,
                          builder: (context, isPremium, _) {
                            return GreetingHeader(
                              isPremium: isPremium,
                              onMenuPressed: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                              onStarPressed: () {
                                _triggerPaywall();
                              },
                            );
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
