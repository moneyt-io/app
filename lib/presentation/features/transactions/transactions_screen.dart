import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:intl/intl.dart';

import 'transaction_provider.dart';
import '../../../domain/entities/transaction_entry.dart';
import '../../core/atoms/app_button.dart';
import '../../core/molecules/empty_state.dart';
import '../../core/molecules/confirm_delete_dialog.dart';
import '../../core/organisms/app_drawer.dart';
import '../../core/molecules/transaction_list_item.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import '../../core/design_system/theme/app_dimensions.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/atoms/expandable_fab.dart';
import 'models/transaction_filter_model.dart';
import 'models/transaction_type_filter_extensions.dart';
import 'widgets/transaction_filter_dialog.dart';
import '../../core/molecules/filter_chip_group.dart';
import '../../core/organisms/transactions_summary.dart';
import '../../../domain/services/balance_calculation_service.dart';
import 'package:get_it/get_it.dart';
import '../../core/molecules/active_filters_bar.dart';

enum TransactionTypeFilter { all, expense, income, transfer }

enum TransactionDateFilter { all, week, month, custom }

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  late TransactionFilterModel _filterModel;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _balanceCalculationService =
      GetIt.instance<BalanceCalculationService>();

  @override
  void initState() {
    super.initState();
    _filterModel = TransactionFilterModel.initial();
  }

  @override
  Widget build(BuildContext context) {
    // Watch for changes in the provider
    final provider = context.watch<TransactionProvider>();
    final transactions = provider.transactions;
    final categoriesMap = provider.categoriesMap;
    final contactsMap = provider.contactsMap;
    final walletsMap = provider.walletsMap;

    // Helper functions
    List<TransactionEntry> getFilteredTransactions() {
      return transactions.where((t) {
        // Date filter
        if (_filterModel.startDate != null && t.date.isBefore(_filterModel.startDate!)) {
          return false;
        }
        if (_filterModel.endDate != null && t.date.isAfter(_filterModel.endDate!.add(const Duration(days: 1)))) {
          return false;
        }

        // Type filter
        if (!_filterModel.transactionTypes.any((type) {
          bool typeMatches = false;
          switch (type) {
            case TransactionType.income:
              typeMatches = t.isIncome;
              break;
            case TransactionType.expense:
              typeMatches = t.isExpense;
              break;
            case TransactionType.transfer:
              typeMatches = t.isTransfer;
              break;
          }
          return typeMatches;
        })) {
            // If the set is empty, it means 'All' is selected, so we don't filter by type.
            // If it's not empty, and we didn't find a match, then we return false.
            if (_filterModel.transactionTypes.isNotEmpty) return false;
        }

        // Category filter
        if (_filterModel.category != null && t.mainCategoryId != _filterModel.category!.id) {
          return false;
        }

        // Account filter
        if (_filterModel.account != null && t.mainWalletId != _filterModel.account!.id) {
          return false;
        }

        // Contact filter
        if (_filterModel.contact != null && t.contactId != _filterModel.contact!.id) {
          return false;
        }

        // Amount filter
        if (_filterModel.minAmount != null && t.amount.abs() < _filterModel.minAmount!) {
          return false;
        }
        if (_filterModel.maxAmount != null && t.amount.abs() > _filterModel.maxAmount!) {
          return false;
        }

        return true;
      }).toList()..sort((a, b) => b.date.compareTo(a.date));
    }

    Map<String, List<TransactionEntry>> groupTransactionsByDate(
        List<TransactionEntry> transactions) {
      final Map<String, List<TransactionEntry>> grouped = {};
      for (var transaction in transactions) {
        final dateKey = DateFormat('yyyy-MM-dd').format(transaction.date);
        if (grouped[dateKey] == null) {
          grouped[dateKey] = [];
        }
        grouped[dateKey]!.add(transaction);
      }
      return grouped;
    }

    String? getAccountName(TransactionEntry transaction) {
      try {
        final detail = transaction.details.firstWhere(
          (d) => d.isWalletPayment && (d.isOutflow || d.isFrom),
        );
        return walletsMap[detail.paymentId];
      } catch (e) {
        try {
          final detail =
              transaction.details.firstWhere((d) => d.isWalletPayment);
          return walletsMap[detail.paymentId];
        } catch (e) {
          return null;
        }
      }
    }

    String? getTargetAccountName(TransactionEntry transaction) {
      if (transaction.documentTypeId != 'T') return null;
      try {
        final detail =
            transaction.details.firstWhere((d) => d.isWalletPayment && d.isTo);
        return walletsMap[detail.paymentId];
      } catch (e) {
        return null;
      }
    }

    // UI Build
    final filteredTransactions = getFilteredTransactions();
    final groupedTransactions = groupTransactionsByDate(filteredTransactions);
    final dateKeys = groupedTransactions.keys.toList();

    final totalIncome =
        _balanceCalculationService.calculateTotalIncome(filteredTransactions);
    final totalExpense =
        _balanceCalculationService.calculateTotalExpense(filteredTransactions);
    final totalTransfer =
        _balanceCalculationService.calculateTotalTransfer(filteredTransactions);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppAppBar(
        title: 'Transactions',
        type: AppAppBarType.blur,
        leading: AppAppBarLeading.drawer,
        onLeadingPressed: () => _scaffoldKey.currentState?.openDrawer(),
        actions: const [AppAppBarAction.search],
        onActionsPressed: [() {}],
      ),
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverFilterHeaderDelegate(
              height: 96,
              blur: true,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    FilterChipGroup<TransactionTypeFilter>(
                      selectedValue: _filterModel.transactionTypes.isEmpty
                          ? TransactionTypeFilter.all
                          : _filterModel.transactionTypes.first.toFilterType(),
                      filters: const {
                        TransactionTypeFilter.all: 'All',
                        TransactionTypeFilter.income: 'Income',
                        TransactionTypeFilter.expense: 'Expense',
                        TransactionTypeFilter.transfer: 'Transfer',
                      },
                      icons: const {
                        TransactionTypeFilter.all: Icons.receipt_long,
                        TransactionTypeFilter.income: Icons.trending_up,
                        TransactionTypeFilter.expense: Icons.trending_down,
                        TransactionTypeFilter.transfer: Icons.swap_horiz,
                      },
                      onFilterChanged: (value) {
                        setState(() {
                          _filterModel = _filterModel.copyWithTransactionTypes(
                            value == TransactionTypeFilter.all
                                ? {}
                                : {value.toTransactionType()},
                          );
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    ActiveFiltersBar(
                      activeFilters: _filterModel.activeFilters(excludeTransactionType: true),
                      onAddFilter: () async {
                        final newFilter = await Navigator.push(
                          context,
                          MaterialPageRoute<TransactionFilterModel>(
                            builder: (context) => TransactionFilterDialog(
                              initialFilter: _filterModel,
                            ),
                            fullscreenDialog: true,
                          ),
                        );

                        if (newFilter != null) {
                          setState(() {
                            _filterModel = newFilter;
                          });
                        }
                      },
                      onRemoveFilter: (key) {
                        setState(() {
                          _filterModel = _filterModel.removeFilter(key);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 12.0),
              child: TransactionsSummary(
                totalIncome: totalIncome,
                totalExpense: totalExpense,
                totalTransfer: totalTransfer,
              ),
            ),
          ),
          provider.isLoading
              ? const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()))
              : provider.error != null
                  ? SliverFillRemaining(
                      child: _buildErrorState(context, provider.error!))
                  : filteredTransactions.isEmpty
                      ? SliverFillRemaining(child: _buildEmptyState())
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final dateKey = dateKeys[index];
                              final transactionsForDate =
                                  groupedTransactions[dateKey]!;
                              final displayDate =
                                  DateFormat('EEEE, d MMMM yyyy', 'es_ES')
                                      .format(DateTime.parse(dateKey));

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 16, 16, 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(displayDate,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                        Text(
                                            '${transactionsForDate.length} transactions',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurfaceVariant)),
                                      ],
                                    ),
                                  ),
                                  ...transactionsForDate.map(
                                    (transaction) => TransactionListItem(
                                      transaction: transaction,
                                      categoryName:
                                          transaction.mainCategoryId != null
                                              ? categoriesMap[
                                                  transaction.mainCategoryId]
                                              : null,
                                      contactName: transaction.contactId != null
                                          ? contactsMap[transaction.contactId]
                                          : null,
                                      accountName: getAccountName(transaction),
                                      targetAccountName:
                                          getTargetAccountName(transaction),
                                      onTap: () => NavigationService.navigateTo(
                                          AppRoutes.transactionDetail,
                                          arguments: transaction),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              );
                            },
                            childCount: dateKeys.length,
                          ),
                        ),
        ],
      ),
      floatingActionButton: ExpandableFab(
        actions: [
          FabAction(
              label: 'Income',
              icon: Icons.trending_up,
              backgroundColor: const Color(0xFF22C55E),
              onPressed: () => NavigationService.navigateTo(
                  AppRoutes.transactionForm,
                  arguments: {'initialType': 'I'})),
          FabAction(
              label: 'Expense',
              icon: Icons.trending_down,
              backgroundColor: const Color(0xFFEF4444),
              onPressed: () => NavigationService.navigateTo(
                  AppRoutes.transactionForm,
                  arguments: {'initialType': 'E'})),
          FabAction(
              label: 'Transfer',
              icon: Icons.swap_horiz,
              backgroundColor: const Color(0xFF3B82F6),
              onPressed: () => NavigationService.navigateTo(
                  AppRoutes.transactionForm,
                  arguments: {'initialType': 'T'})),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: AppDimensions.spacing48,
                color: Theme.of(context).colorScheme.error),
            SizedBox(height: AppDimensions.spacing16),
            Text('Error al cargar las transacciones',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: AppDimensions.spacing8),
            Text(error),
            SizedBox(height: AppDimensions.spacing24),
            ElevatedButton(
              onPressed: () =>
                  context.read<TransactionProvider>().loadInitialData(),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return EmptyState(
      icon: Icons.receipt_long_outlined,
      title: 'No hay transacciones',
      message: 'No se encontraron transacciones con los filtros aplicados',
      action: AppButton(
        text: 'Limpiar filtros',
        onPressed: () {
          setState(() {
            _filterModel = TransactionFilterModel.initial();
          });
        },
        type: AppButtonType.text,
      ),
    );
  }
}

class _SliverFilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;
  final bool blur;

  _SliverFilterHeaderDelegate({
    required this.child,
    required this.height,
    this.blur = false,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final backgroundColor = blur
        ? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.85)
        : Theme.of(context).scaffoldBackgroundColor;

    final content = Container(
      color: backgroundColor,
      child: child,
    );

    if (blur) {
      return ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: content,
        ),
      );
    }

    return content;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant _SliverFilterHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.height != height ||
        oldDelegate.blur != blur;
  }
}
