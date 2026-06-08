import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

import '../../core/l10n/generated/strings.g.dart';
import '../../../core/services/paywall_service.dart';
import '../../core/organisms/app_drawer.dart';
import '../../core/providers/background_provider.dart';
import '../../core/providers/currency_filter_provider.dart';
import '../theme/v2_colors.dart';
import '../../core/providers/currency_provider.dart';
import '../../../core/services/exchange_rate_service.dart';
import '../../features/transactions/transaction_provider.dart';
import '../../features/wallets/wallet_provider.dart';
import '../../../domain/entities/transaction_entry.dart';
import '../../core/l10n/generated/strings.g.dart';
import '../../../core/utils/number_formatter.dart';

import '../shared/widgets/v2_date_selection_sheet.dart';
import 'widgets/dashboard2_gauge.dart';
import 'widgets/dashboard2_income_expense.dart';
import 'widgets/dashboard2_activity_list.dart';
import 'widgets/dashboard2_bottom_nav.dart';
import 'widgets/parallax_background.dart';
import '../settings/new_settings_screen.dart';

class NewHomeScreen extends StatefulWidget {
  final bool hasJustSeenPaywall;
  final VoidCallback onToggleLegacy;

  const NewHomeScreen({
    super.key,
    this.hasJustSeenPaywall = false,
    required this.onToggleLegacy,
  });

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  DateTimeRange _selectedDateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0, 23, 59, 59),
  );

  int? _selectedWalletId;
  List<int> _activeWalletsInDateRange = [];

  @override
  void initState() {
    super.initState();
    _showPaywallIfNeeded();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateActiveWalletsInDateRange();
    });
  }

  void _updateActiveWalletsInDateRange() async {
    if (!mounted) return;
    final tp = context.read<TransactionProvider>();
    final activeIds = await tp.getActiveWalletIdsInDateRange(
        _selectedDateRange.start, _selectedDateRange.end);
    if (mounted) {
      setState(() {
        _activeWalletsInDateRange = activeIds;
      });
    }
  }

  Future<void> _showPaywallIfNeeded() async {
    // Wait for initial animations to run
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      final isSubscribed =
          GetIt.instance<PaywallService>().isPremiumNotifier.value;
      if (isSubscribed) {
        debugPrint(' NewHomeScreen: User is already subscribed. Skipping paywall.');
        return;
      }

      if (mounted) {
        debugPrint(' NewHomeScreen: User is not subscribed. Triggering paywall...');
        _triggerPaywall();
      }
    } catch (e) {
      debugPrint(' NewHomeScreen: Error trying to show paywall: $e');
    }
  }

  void _triggerPaywall() {
    final paywallService = GetIt.instance<PaywallService>();
    paywallService.registerEvent('moneyt_pro');
    debugPrint('Paywall event registered from NewHomeScreen');
  }

  DateTimeRange _getCurrentMonthRange() {
    final now = DateTime.now();
    return DateTimeRange(
      start: DateTime(now.year, now.month, 1),
      end: DateTime(now.year, now.month + 1, 0, 23, 59, 59),
    );
  }

  DateTimeRange _getPreviousMonthRange() {
    final now = DateTime.now();
    return DateTimeRange(
      start: DateTime(now.year, now.month - 1, 1),
      end: DateTime(now.year, now.month, 0, 23, 59, 59),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _getWalletLabel(WalletProvider provider) {
    if (_selectedWalletId == null) return t.v2.dashboard.walletFilters.allWallets;
    final wallet =
        provider.wallets.where((w) => w.id == _selectedWalletId).firstOrNull;
    if (wallet == null) return t.v2.dashboard.walletFilters.allWallets;
    // Para el dashboard, mostramos solo el nombre corto para que no se vea muy largo
    return wallet.name;
  }

  String _getDateRangeLabel() {
    final current = _getCurrentMonthRange();
    final previous = _getPreviousMonthRange();

    if (_isSameDay(_selectedDateRange.start, current.start) &&
        _isSameDay(_selectedDateRange.end, current.end)) {
      return t.v2.dashboard.dateFilters.thisMonth;
    } else if (_isSameDay(_selectedDateRange.start, previous.start) &&
        _isSameDay(_selectedDateRange.end, previous.end)) {
      return t.v2.dashboard.dateFilters.lastMonth;
    }

    final startStr = DateFormat('d MMM', 'es').format(_selectedDateRange.start);
    final endStr = DateFormat('d MMM', 'es').format(_selectedDateRange.end);
    return "$startStr - $endStr";
  }

  // Helper functions for data extraction (same logic as legacy HomeScreen)
  List<String> _getAvailableCurrencies(WalletProvider provider) {
    return provider.wallets
        .where((w) => w.active)
        .map((w) => w.currencyId)
        .toSet()
        .toList();
  }

  double _calculateBalanceForCurrency(
      WalletProvider provider, String baseCurrencyId, bool shouldConvert) {
    double total = 0.0;
    final allWallets = provider.wallets;
    final exchangeRateService = GetIt.instance<ExchangeRateService>();
    
    for (final wallet in allWallets) {
      if (!wallet.active) continue; // Remove currencyId filter
      double balance = provider.walletBalances[wallet.id] ?? 0.0;
      if (wallet.parentId == null) {
        for (final child in allWallets.where((w) => w.parentId == wallet.id)) {
          balance -= (provider.walletBalances[child.id] ?? 0.0);
        }
      }
      
      final amt = shouldConvert ? exchangeRateService.convert(balance, wallet.currencyId, baseCurrencyId) : balance;
      total += amt;
    }
    return total;
  }

  String _getTrueCurrency(TransactionEntry t, WalletProvider walletProvider) {
    // Si la transacción tiene paymentId en sus detalles (billetera/cuenta), usamos su moneda
    if (t.details.isNotEmpty) {
      final detail = t.details.first;
      if (detail.paymentId != null) {
        final wallet = walletProvider.wallets.where((w) => w.id == detail.paymentId).firstOrNull;
        if (wallet != null) return wallet.currencyId;
      }
    }
    // Fallback a la moneda guardada en la transacción (podría estar desactualizada)
    return t.currencyId;
  }

  double _calculateIncomeForCurrency(
      List<TransactionEntry> transactions, String baseCurrencyId, WalletProvider provider, bool shouldConvert) {
    final exchangeRateService = GetIt.instance<ExchangeRateService>();
    return transactions
        .where((t) => t.documentTypeId == 'I') // Remove currencyId filter
        .fold(0.0, (sum, t) {
          final trueCurrency = _getTrueCurrency(t, provider);
          final amt = shouldConvert ? exchangeRateService.convert(t.amount.abs(), trueCurrency, baseCurrencyId) : t.amount.abs();
          return sum + amt;
        });
  }

  double _calculateExpensesForCurrency(
      List<TransactionEntry> transactions, String baseCurrencyId, WalletProvider provider, bool shouldConvert) {
    final exchangeRateService = GetIt.instance<ExchangeRateService>();
    return transactions
        .where((t) => t.documentTypeId == 'E') // Remove currencyId filter
        .fold(0.0, (sum, t) {
          final trueCurrency = _getTrueCurrency(t, provider);
          final amt = shouldConvert ? exchangeRateService.convert(t.amount.abs(), trueCurrency, baseCurrencyId) : t.amount.abs();
          return sum + amt;
        });
  }

  @override
  Widget build(BuildContext context) {
    // Escuchar el proveedor de moneda para que se reconstruya si cambia la configuración
    context.watch<CurrencyProvider>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle
          .light, // Fuerza íconos blancos en la barra de estado
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF8FF), // surface-container-lowest
        drawer: const AppDrawer(),
        body: Consumer3<WalletProvider, TransactionProvider,
            CurrencyFilterProvider>(
          builder: (context, walletProvider, transactionProvider,
              currencyFilter, child) {
            if (walletProvider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF004AC6)),
              );
            }

            // Currency Filter Sync
            final availableCurrencies = _getAvailableCurrencies(walletProvider);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted && availableCurrencies.isNotEmpty) {
                currencyFilter.syncWithAvailable(availableCurrencies);
              }
            });
            final selectedCurrency = currencyFilter.selectedCurrencyId;

            // Transactions Filtered by Date Range and Wallet
            final currentRangeTransactions =
                transactionProvider.transactions.where((t) {
              final isAfterOrSame = t.date.isAfter(_selectedDateRange.start) ||
                  t.date.isAtSameMomentAs(_selectedDateRange.start);
              final isBeforeOrSame = t.date.isBefore(_selectedDateRange.end) ||
                  t.date.isAtSameMomentAs(_selectedDateRange.end);
              final matchesDate = isAfterOrSame && isBeforeOrSame;
              final matchesWallet = _selectedWalletId == null ||
                  t.details.any((d) => d.paymentId == _selectedWalletId);
              return matchesDate && matchesWallet;
            }).toList();

            // Financial Calcs
            final bool shouldConvert = _selectedWalletId == null;
            final totalBalance = _selectedWalletId != null
                ? (walletProvider.walletBalances[_selectedWalletId] ?? 0.0)
                : _calculateBalanceForCurrency(
                    walletProvider, selectedCurrency, shouldConvert);

            final income = _calculateIncomeForCurrency(
                currentRangeTransactions, selectedCurrency, walletProvider, shouldConvert);
            final expenses = _calculateExpensesForCurrency(
                currentRangeTransactions, selectedCurrency, walletProvider, shouldConvert);

            // Render Main Stack
            return Stack(
              children: [
                SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.only(
                      bottom: 140), // padding for bottom nav and extra spacing
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        _buildHeaderWithBackground(
                          context,
                          totalBalance,
                          expenses,
                          income,
                          walletProvider,
                          currentRangeTransactions,
                          transactionProvider,
                          currencyFilter,
                        ),
                      Transform.translate(
                        offset: const Offset(0, -32),
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFAF8FF),
                            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 32, left: 20, right: 20),
                            child: Column(
                              children: [
                                Dashboard2IncomeExpense(
                                  income: income,
                                  expenses: expenses,
                                  currencyId: currencyFilter.selectedCurrencyId,
                                ),
                                const SizedBox(height: 24),
                                Dashboard2ActivityList(
                                  transactions: currentRangeTransactions
                                    ..sort((a, b) => b.date.compareTo(a.date)),
                                  totalExpenses: expenses,
                                  categoriesDataMap:
                                      transactionProvider.categoriesDataMap,
                                  currencyId: currencyFilter.selectedCurrencyId,
                                  walletProvider: walletProvider,
                                  shouldConvert: shouldConvert,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Dashboard2BottomNav(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderWithBackground(
    BuildContext context,
    double totalBalance,
    double expenses,
    double income,
    WalletProvider walletProvider,
    List<TransactionEntry> currentRangeTransactions,
    TransactionProvider transactionProvider,
    CurrencyFilterProvider currencyFilter,
  ) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Stack(
        children: [
          // Background Image with Parallax
          const ParallaxBackground(
            imageUrl:
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBwYJtbLoiRlK81HfQ0l7k4ySGsyJeulQ5JpR_i0oIcnwM_9Pw_1IBnZ81Yk48phFd11NOlBX-OHgmovM__zWyLxpcfQ721O5NjjvLM_7LkERh01LoHkOddGXkwHpoI-AHMuT8bcbMn849_lNZ7Su4h9TYOpv_qUTD6XXWe7Yps8HV7sQVkcNQKhhaIzTrwgESMzN-MvMbARMYlmjgpHQSr0vFRfsEkwAJWwGYqohbqQuSGjFSOnqyq7eDOq6wiFI3-d2d74TspvgIC',
            parallaxFactor: 20.0,
          ),
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.6),
                    Colors.black.withValues(alpha: 0.3),
                    Colors.black,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          // Content
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Top App Bar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          t.v2.dashboard.greetingMorning,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontFamily: 'Manrope',
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) => NewSettingsScreen(
                                    onToggleLegacy: widget.onToggleLegacy,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.settings_outlined,
                                color: Colors.white),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Total Balance Text
                Text(
                  t.v2.dashboard.totalBalance,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontFamily: 'Manrope',
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  NumberFormatter.formatCurrencyWithDecimals(totalBalance, currencyId: currencyFilter.selectedCurrencyId),
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -1.0,
                    fontFamily: 'Manrope',
                    height: 1.1,
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Filter Chips
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PopupMenuButton<String>(
                      color: const Color(0xFFFAF8FF), // match dashboard surface
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      offset: const Offset(0, 40),
                      onSelected: (value) async {
                        if (value == 'current') {
                          setState(() =>
                              _selectedDateRange = _getCurrentMonthRange());
                          _updateActiveWalletsInDateRange();
                        } else if (value == 'previous') {
                          setState(() =>
                              _selectedDateRange = _getPreviousMonthRange());
                          _updateActiveWalletsInDateRange();
                        } else if (value == 'custom') {
                          final picked = await V2DateSelectionSheet.showRange(
                            context,
                            initialRange: _selectedDateRange,
                          );
                          if (picked != null) {
                            setState(() => _selectedDateRange = DateTimeRange(
                                  start: picked.start,
                                  end: DateTime(
                                      picked.end.year,
                                      picked.end.month,
                                      picked.end.day,
                                      23,
                                      59,
                                      59),
                                ));
                            _updateActiveWalletsInDateRange();
                          }
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'current',
                          child: Text(t.v2.dashboard.dateFilters.thisMonth,
                              style: const TextStyle(
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w500)),
                        ),
                        PopupMenuItem(
                          value: 'previous',
                          child: Text(t.v2.dashboard.dateFilters.lastMonth,
                              style: const TextStyle(
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w500)),
                        ),
                        PopupMenuItem(
                          value: 'custom',
                          child: Text(t.v2.dashboard.dateFilters.customRange,
                              style: const TextStyle(
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                      child: _buildFilterChip(_getDateRangeLabel()),
                    ),
                    const SizedBox(width: 8),
                    PopupMenuButton<int>(
                      color: const Color(0xFFFAF8FF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      offset: const Offset(0, 40),
                      onSelected: (value) {
                        if (value == -1) {
                          setState(() => _selectedWalletId = null);
                          final globalCurrency = context.read<CurrencyProvider>().currencyId;
                          currencyFilter.selectCurrency(globalCurrency);
                        } else {
                          setState(() => _selectedWalletId = value);
                          
                          // Sync global currency to match the selected wallet's currency
                          final selectedWallet = walletProvider.wallets.where((w) => w.id == value).firstOrNull;
                          if (selectedWallet != null) {
                            currencyFilter.selectCurrency(selectedWallet.currencyId);
                          }
                        }
                      },
                      itemBuilder: (context) {
                        final availableWallets =
                            walletProvider.wallets.where((w) {
                          if (!w.active) return false;
                          if (w.parentId == null) return false;
                          
                          // Ignorar hijos de padres inactivos
                          final parent = walletProvider.wallets.where((p) => p.id == w.parentId).firstOrNull;
                          if (parent == null || !parent.active) return false;

                          final balance =
                              walletProvider.walletBalances[w.id] ?? 0.0;
                          if (balance <= 0 && !_activeWalletsInDateRange.contains(w.id)) return false;
                          return true;
                        }).toList();

                        // Contar SOLO los nombres únicos de los padres de las billeteras que realmente se van a mostrar
                        final activeParentNames = availableWallets.map((w) {
                          final parent = walletProvider.wallets.where((p) => p.id == w.parentId).firstOrNull;
                          return parent?.name ?? '';
                        }).where((name) => name.isNotEmpty).toSet();
                        final parentWalletsCount = activeParentNames.length;

                        final items = <PopupMenuEntry<int>>[
                          PopupMenuItem(
                            value: -1,
                            child: Text(t.v2.dashboard.walletFilters.all,
                                style: const TextStyle(
                                    fontFamily: 'Manrope',
                                    fontWeight: FontWeight.w500)),
                          ),
                        ];

                        for (final w in availableWallets) {
                          final parent = walletProvider.wallets
                              .where((p) => p.id == w.parentId)
                              .firstOrNull;
                              
                          final currencySymbol = CurrencyProvider.availableCurrencies
                              .firstWhere((c) => c.id == w.currencyId, orElse: () => CurrencyProvider.availableCurrencies.first)
                              .symbol;
                              
                          final fullName = (parent != null && parentWalletsCount > 1)
                              ? '${parent.name} - ${w.name} ($currencySymbol)'
                              : '${w.name} ($currencySymbol)';
                              
                          items.add(PopupMenuItem(
                            value: w.id,
                            child: Text(fullName,
                                style: const TextStyle(
                                    fontFamily: 'Manrope',
                                    fontWeight: FontWeight.w500)),
                          ));
                        }
                        return items;
                      },
                      child: _buildFilterChip(_getWalletLabel(walletProvider)),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Gauge Chart
                Dashboard2Gauge(
                  income: income,
                  expenses: expenses,
                  transactions: currentRangeTransactions,
                  categoriesDataMap: transactionProvider.categoriesDataMap,
                  currencyId: currencyFilter.selectedCurrencyId,
                ),
                const SizedBox(
                    height:
                        64), // Space before the overlapping sheet
              ],
            ),
          ),
          Positioned(
            right: 14, // Ajustado para alinear perfectamente el centro con el icono de settings de arriba
            bottom: 58, // Raised to clear the overlap
            child: _buildCameraFab(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraFab(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showMetaBackgroundBottomSheet(context),
        customBorder: const CircleBorder(),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.camera_alt_outlined,
            color: Colors.white,
            size: 18,
            shadows: [
              Shadow(
                color: Colors.black45,
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMetaBackgroundBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: V2Colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: V2Colors.outlineVariant.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                t.v2.dashboard.background.title,
                style: const TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: V2Colors.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined,
                    color: V2Colors.primary),
                title: Text(t.v2.dashboard.background.chooseFromGallery,
                    style: const TextStyle(
                        fontFamily: 'Manrope', fontWeight: FontWeight.w600)),
                onTap: () async {
                  Navigator.pop(sheetContext);
                  final picker = ImagePicker();
                  final image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null && context.mounted) {
                    final appDir = await getApplicationDocumentsDirectory();
                    final fileName = path.basename(image.path);
                    final savedImage =
                        await File(image.path).copy('${appDir.path}/$fileName');

                    if (context.mounted) {
                      context
                          .read<BackgroundProvider>()
                          .setBackground(savedImage.path);
                    }
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.restore, color: V2Colors.primary),
                title: Text(t.v2.dashboard.background.restoreDefault,
                    style: const TextStyle(
                        fontFamily: 'Manrope', fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(sheetContext);
                  context.read<BackgroundProvider>().clearBackground();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'Manrope',
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.unfold_more, size: 14, color: Colors.white),
        ],
      ),
    );
  }
}
