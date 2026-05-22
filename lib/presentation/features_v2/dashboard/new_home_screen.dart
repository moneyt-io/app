import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/organisms/app_drawer.dart';
import '../../core/providers/currency_filter_provider.dart';
import '../../core/providers/currency_provider.dart';
import '../../features/transactions/transaction_provider.dart';
import '../../features/wallets/wallet_provider.dart';
import '../../../domain/entities/transaction_entry.dart';
import '../../../core/utils/number_formatter.dart';

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

  @override
  void initState() {
    super.initState();
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
    if (_selectedWalletId == null) return "Todas las billeteras";
    final wallet = provider.wallets.where((w) => w.id == _selectedWalletId).firstOrNull;
    if (wallet == null) return "Todas las billeteras";
    // Para el dashboard, mostramos solo el nombre corto para que no se vea muy largo
    return wallet.name;
  }

  String _getDateRangeLabel() {
    final current = _getCurrentMonthRange();
    final previous = _getPreviousMonthRange();

    if (_isSameDay(_selectedDateRange.start, current.start) && _isSameDay(_selectedDateRange.end, current.end)) {
      return "Este mes";
    } else if (_isSameDay(_selectedDateRange.start, previous.start) && _isSameDay(_selectedDateRange.end, previous.end)) {
      return "Mes anterior";
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

  double _calculateBalanceForCurrency(WalletProvider provider, String currencyId) {
    double total = 0.0;
    final allWallets = provider.wallets;
    for (final wallet in allWallets) {
      if (!wallet.active || wallet.currencyId != currencyId) continue;
      double balance = provider.walletBalances[wallet.id] ?? 0.0;
      if (wallet.parentId == null) {
        for (final child in allWallets.where((w) => w.parentId == wallet.id)) {
          balance -= (provider.walletBalances[child.id] ?? 0.0);
        }
      }
      total += balance;
    }
    return total;
  }

  double _calculateIncomeForCurrency(List<TransactionEntry> transactions, String currencyId) {
    return transactions
        .where((t) => t.documentTypeId == 'I' && t.currencyId == currencyId)
        .fold(0.0, (sum, t) => sum + t.amount.abs());
  }

  double _calculateExpensesForCurrency(List<TransactionEntry> transactions, String currencyId) {
    return transactions
        .where((t) => t.documentTypeId == 'E' && t.currencyId == currencyId)
        .fold(0.0, (sum, t) => sum + t.amount.abs());
  }

  @override
  Widget build(BuildContext context) {
    // Escuchar el proveedor de moneda para que se reconstruya si cambia la configuración
    context.watch<CurrencyProvider>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, // Fuerza íconos blancos en la barra de estado
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF8FF), // surface-container-lowest
        drawer: const AppDrawer(),
      body: Consumer3<WalletProvider, TransactionProvider, CurrencyFilterProvider>(
        builder: (context, walletProvider, transactionProvider, currencyFilter, child) {
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
          final currentRangeTransactions = transactionProvider.transactions.where((t) {
            final isAfterOrSame = t.date.isAfter(_selectedDateRange.start) || t.date.isAtSameMomentAs(_selectedDateRange.start);
            final isBeforeOrSame = t.date.isBefore(_selectedDateRange.end) || t.date.isAtSameMomentAs(_selectedDateRange.end);
            final matchesDate = isAfterOrSame && isBeforeOrSame;
            final matchesWallet = _selectedWalletId == null || t.details.any((d) => d.paymentId == _selectedWalletId);
            return matchesDate && matchesWallet;
          }).toList();

          // Financial Calcs
          final totalBalance = _selectedWalletId != null 
              ? (walletProvider.walletBalances[_selectedWalletId] ?? 0.0)
              : _calculateBalanceForCurrency(walletProvider, selectedCurrency);
              
          final income = _calculateIncomeForCurrency(currentRangeTransactions, selectedCurrency);
          final expenses = _calculateExpensesForCurrency(currentRangeTransactions, selectedCurrency);

          // Render Main Stack
          return Stack(
            children: [
              SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 140), // padding for bottom nav and extra spacing
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Transform.translate(
                            offset: const Offset(0, -16),
                            child: Dashboard2IncomeExpense(
                              income: income,
                              expenses: expenses,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Dashboard2ActivityList(
                            transactions: currentRangeTransactions
                                .where((t) => t.currencyId == selectedCurrency)
                                .toList()
                              ..sort((a, b) => b.date.compareTo(a.date)),
                            totalExpenses: expenses,
                            categoriesDataMap: transactionProvider.categoriesDataMap,
                          ),
                        ],
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
  ) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: [
          // Background Image with Parallax
          const ParallaxBackground(
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBwYJtbLoiRlK81HfQ0l7k4ySGsyJeulQ5JpR_i0oIcnwM_9Pw_1IBnZ81Yk48phFd11NOlBX-OHgmovM__zWyLxpcfQ721O5NjjvLM_7LkERh01LoHkOddGXkwHpoI-AHMuT8bcbMn849_lNZ7Su4h9TYOpv_qUTD6XXWe7Yps8HV7sQVkcNQKhhaIzTrwgESMzN-MvMbARMYlmjgpHQSr0vFRfsEkwAJWwGYqohbqQuSGjFSOnqyq7eDOq6wiFI3-d2d74TspvgIC',
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
                    Colors.black.withValues(alpha: 0.0),
                    const Color(0xFFFAF8FF),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          "¡Buenos días!",
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
                            icon: const Icon(Icons.tune_rounded, color: Colors.white),
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
                const Text(
                  "BALANCE TOTAL",
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
                  NumberFormatter.formatCurrencyWithDecimals(totalBalance),
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      offset: const Offset(0, 40),
                      onSelected: (value) async {
                        if (value == 'current') {
                          setState(() => _selectedDateRange = _getCurrentMonthRange());
                        } else if (value == 'previous') {
                          setState(() => _selectedDateRange = _getPreviousMonthRange());
                        } else if (value == 'custom') {
                          final picked = await showDateRangePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            initialDateRange: _selectedDateRange,
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Color(0xFF004AC6),
                                  ),
                                ),
                                child: child!,
                              );
                            }
                          );
                          if (picked != null) {
                            setState(() => _selectedDateRange = DateTimeRange(
                              start: picked.start,
                              end: DateTime(picked.end.year, picked.end.month, picked.end.day, 23, 59, 59),
                            ));
                          }
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'current',
                          child: Text('Este mes', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w500)),
                        ),
                        const PopupMenuItem(
                          value: 'previous',
                          child: Text('Mes anterior', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w500)),
                        ),
                        const PopupMenuItem(
                          value: 'custom',
                          child: Text('Rango personalizado...', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w500)),
                        ),
                      ],
                      child: _buildFilterChip(_getDateRangeLabel()),
                    ),
                    const SizedBox(width: 8),
                    PopupMenuButton<int>(
                      color: const Color(0xFFFAF8FF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      offset: const Offset(0, 40),
                      onSelected: (value) {
                        if (value == -1) {
                          setState(() => _selectedWalletId = null);
                        } else {
                          setState(() => _selectedWalletId = value);
                        }
                      },
                      itemBuilder: (context) {
                        final availableWallets = walletProvider.wallets.where((w) {
                          if (!w.active) return false;
                          if (w.parentId == null) return false;
                          final balance = walletProvider.walletBalances[w.id] ?? 0.0;
                          if (balance <= 0) return false;
                          return true;
                        }).toList();

                        final items = <PopupMenuEntry<int>>[
                          const PopupMenuItem(
                            value: -1,
                            child: Text('Todas', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w500)),
                          ),
                        ];

                        for (final w in availableWallets) {
                          final parent = walletProvider.wallets.where((p) => p.id == w.parentId).firstOrNull;
                          final fullName = parent != null ? '${parent.name} - ${w.name}' : w.name;
                          items.add(PopupMenuItem(
                            value: w.id,
                            child: Text(fullName, style: const TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w500)),
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
                ),
                const SizedBox(height: 56), // Added more space to prevent overlap con income/expense cards
              ],
            ),
          ),
        ],
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
