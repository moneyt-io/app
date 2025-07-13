import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/transaction_entry.dart';
import '../../../domain/usecases/transaction_usecases.dart';
import '../../../domain/usecases/category_usecases.dart';
import '../../../domain/usecases/contact_usecases.dart';
import '../../../domain/usecases/wallet_usecases.dart';
import '../../core/atoms/app_button.dart';
import '../../core/molecules/empty_state.dart';
import '../../core/atoms/app_search_field.dart';
import '../../core/molecules/confirm_delete_dialog.dart';
import '../../core/organisms/app_drawer.dart';
import '../../core/molecules/transaction_list_item.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import '../../core/design_system/theme/app_dimensions.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/atoms/expandable_fab.dart';
import '../../core/molecules/filter_chip_group.dart';
import '../../core/organisms/transactions_summary.dart';
import '../../../domain/services/balance_calculation_service.dart';
import '../../core/molecules/active_filters_bar.dart';

enum TransactionTypeFilter { all, expense, income, transfer }

enum TransactionDateFilter { all, week, month, custom }

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();
  final _transactionUseCases = GetIt.instance<TransactionUseCases>();
  final _categoryUseCases = GetIt.instance<CategoryUseCases>();
  final _contactUseCases = GetIt.instance<ContactUseCases>();
  final _walletUseCases = GetIt.instance<WalletUseCases>();
  final _balanceCalculationService =
      GetIt.instance<BalanceCalculationService>();

  String _searchQuery = '';
  List<TransactionEntry> _transactions = [];
  Map<int, String> _categoriesMap = {};
  Map<int, String> _contactsMap = {};
  Map<int, String> _walletsMap = {};

  DateTime? _startDate;
  DateTime? _endDate;

  TransactionTypeFilter _selectedTypeFilter = TransactionTypeFilter.all;
  TransactionDateFilter _selectedDateFilter = TransactionDateFilter.all;

  bool _isLoading = true;
  String? _error;

  double _totalIncome = 0.0;
  double _totalExpense = 0.0;
  double _totalTransfer = 0.0;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await _loadCategoriesAndContacts();
    await _loadTransactions();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCategoriesAndContacts() async {
    try {
      // Cargar categorías
      final categories = await _categoryUseCases.getAllCategories();
      final categoriesMap = {for (var c in categories) c.id: c.name};

      // Cargar contactos
      final contacts = await _contactUseCases.getAllContacts();
      final contactsMap = {for (var c in contacts) c.id: c.name};

      // Cargar wallets
      final wallets = await _walletUseCases.getAllWallets();
      final walletsMap = {for (var w in wallets) w.id: w.name};

      setState(() {
        _categoriesMap = categoriesMap;
        _contactsMap = contactsMap;
        _walletsMap = walletsMap;
      });
    } catch (e) {
      // Mostrar error si es necesario
    }
  }

  Future<void> _loadTransactions() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      List<TransactionEntry> transactions;

      // Filtrar por tipo según el segmented control
      switch (_selectedTypeFilter) {
        case TransactionTypeFilter.expense:
          transactions = await _transactionUseCases.getTransactionsByType('E');
          break;
        case TransactionTypeFilter.income:
          transactions = await _transactionUseCases.getTransactionsByType('I');
          break;
        case TransactionTypeFilter.transfer:
          transactions = await _transactionUseCases.getTransactionsByType('T');
          break;
        default: // all
          transactions = await _transactionUseCases.getAllTransactions();
      }

      setState(() {
        _transactions = transactions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _applyDateFilter(TransactionDateFilter filter) {
    setState(() {
      _selectedDateFilter = filter;
      final now = DateTime.now();

      switch (filter) {
        case TransactionDateFilter.all:
          _startDate = null;
          _endDate = null;
          break;
        case TransactionDateFilter.month:
          _startDate = DateTime(now.year, now.month, 1);
          _endDate = DateTime(now.year, now.month + 1, 0);
          break;
        case TransactionDateFilter.week:
          // Calcular el inicio de la semana (lunes)
          final weekDay = now.weekday;
          _startDate = now.subtract(Duration(days: weekDay - 1));
          _endDate = now.add(Duration(days: 7 - weekDay));
          break;
        case TransactionDateFilter.custom:
          // No hacer nada aquí, se llama a _selectCustomDateRange
          break;
      }

      if (filter != TransactionDateFilter.custom) {
        _loadTransactions();
      }
    });
  }

  Future<void> _selectCustomDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: DateTimeRange(
        start: _startDate ?? DateTime.now().subtract(const Duration(days: 30)),
        end: _endDate ?? DateTime.now(),
      ),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
        _selectedDateFilter = TransactionDateFilter.custom;
        _loadTransactions();
      });
    }
  }

  void _navigateToTransactionForm({String type = 'E'}) async {
    final result = await NavigationService.navigateTo(AppRoutes.transactionForm,
        arguments: {
          'initialType': type,
        });

    if (result == true) {
      _loadTransactions();
    }
  }

  void _navigateToTransactionDetail(TransactionEntry transaction) async {
    // Corregir la navegación asegurándose de usar la constante correcta de la ruta
    final result = await NavigationService.navigateTo(
        AppRoutes.transactionDetail, // Usar la constante de ruta correcta
        arguments: transaction);

    if (result == true) {
      _loadTransactions();
    }
  }

  Future<void> _deleteTransaction(TransactionEntry transaction) async {
    // Reemplazar el AlertDialog directo con ConfirmDeleteDialog
    final confirmed = await ConfirmDeleteDialog.show(
      context: context,
      title: 'Eliminar transacción',
      message: '¿Estás seguro de eliminar',
      itemName: transaction.description ?? 'esta transacción',
      icon: Icons.receipt_long_outlined,
      isDestructive: true,
    );

    if (confirmed == true) {
      try {
        await _transactionUseCases.deleteTransaction(transaction.id);
        _loadTransactions();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Transacción eliminada con éxito')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al eliminar: ${e.toString()}'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }

  List<TransactionEntry> _getFilteredTransactions() {
    return _transactions.where((transaction) {
      // Filtrar por búsqueda de texto
      final matchesSearch = _searchQuery.isEmpty ||
          transaction.description
                  ?.toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ==
              true ||
          (_categoriesMap[transaction.mainCategoryId]
                  ?.toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ??
              false);

      // Filtrar por fecha
      final matchesDate = (_startDate == null ||
              transaction.date.isAfter(_startDate!) ||
              transaction.date.isAtSameMomentAs(_startDate!)) &&
          (_endDate == null ||
              transaction.date
                  .isBefore(_endDate!.add(const Duration(days: 1))));

      return matchesSearch && matchesDate;
    }).toList()
      ..sort(
          (a, b) => b.date.compareTo(a.date)); // Ordenar por fecha descendente
  }

  Map<String, List<TransactionEntry>> _groupTransactionsByDate(
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

  String? _getAccountName(TransactionEntry transaction) {
    try {
      final detail = transaction.details.firstWhere(
        (d) => d.isWalletPayment && (d.isOutflow || d.isFrom),
      );
      return _walletsMap[detail.paymentId];
    } catch (e) {
      // Fallback for simple income transactions or if no specific flow matches
      try {
        final detail = transaction.details.firstWhere((d) => d.isWalletPayment);
        return _walletsMap[detail.paymentId];
      } catch (e) {
        return null;
      }
    }
  }

  void _calculateTotals(List<TransactionEntry> transactions) {
    // ✅ CORREGIDO: Usar los nuevos métodos del servicio
    final income =
        _balanceCalculationService.calculateTotalIncome(transactions);
    final expense =
        _balanceCalculationService.calculateTotalExpense(transactions);
    final transfer =
        _balanceCalculationService.calculateTotalTransfer(transactions);

    // Actualizar el estado de forma segura después del build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _totalIncome = income;
          _totalExpense = expense;
          _totalTransfer = transfer;
        });
      }
    });
  }

  String? _getTargetAccountName(TransactionEntry transaction) {
    if (transaction.documentTypeId != 'T') return null;
    try {
      final detail =
          transaction.details.firstWhere((d) => d.isWalletPayment && d.isTo);
      return _walletsMap[detail.paymentId];
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredTransactions = _getFilteredTransactions();
    _calculateTotals(filteredTransactions);
    final groupedTransactions = _groupTransactionsByDate(filteredTransactions);
    final dateKeys = groupedTransactions.keys.toList();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8FAFC), // HTML: bg-slate-50
      appBar: AppAppBar(
        title: 'Transactions',
        type: AppAppBarType.blur,
        leading: AppAppBarLeading.drawer,
        onLeadingPressed: () => _scaffoldKey.currentState?.openDrawer(),
        actions: const [AppAppBarAction.search],
        onActionsPressed: [() {}], // Placeholder
      ),
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          // Filters
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverFilterHeaderDelegate(
              height: 110, // Altura ajustada para los filtros
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    FilterChipGroup<TransactionTypeFilter>(
                      selectedValue: _selectedTypeFilter,
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
                          _selectedTypeFilter = value;
                          _loadTransactions();
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    ActiveFiltersBar(
                      activeFilters: [
                        ActiveFilter(
                          key: 'month',
                          label: 'This Month',
                          icon: Icons.calendar_today,
                          color: const Color(0xFF3B82F6),
                        ),
                      ],
                      onAddFilter: () {},
                      onRemoveFilter: (key) {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Summary
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 12.0), // Padding ajustado
              child: TransactionsSummary(
                totalIncome: _totalIncome,
                totalExpense: _totalExpense,
                totalTransfer: _totalTransfer,
              ),
            ),
          ),
          // List
          _isLoading
              ? const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
              : _error != null
                  ? SliverFillRemaining(child: _buildErrorState())
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
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 16, 16, 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          displayDate,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        Text(
                                          '${transactionsForDate.length} transactions',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ...transactionsForDate.map(
                                      (transaction) => TransactionListItem(
                                            transaction: transaction,
                                            categoryName: transaction
                                                        .mainCategoryId !=
                                                    null
                                                ? _categoriesMap[transaction
                                                    .mainCategoryId]
                                                : null,
                                            contactName: transaction
                                                        .contactId !=
                                                    null
                                                ? _contactsMap[
                                                    transaction.contactId]
                                                : null,
                                            accountName: _getAccountName(
                                                transaction),
                                            targetAccountName:
                                                _getTargetAccountName(
                                                    transaction),
                                            onTap: () =>
                                                _navigateToTransactionDetail(
                                                    transaction),
                                          )),
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
            onPressed: () => _navigateToTransactionForm(type: 'I'),
          ),
          FabAction(
            label: 'Expense',
            icon: Icons.trending_down,
            backgroundColor: const Color(0xFFEF4444),
            onPressed: () => _navigateToTransactionForm(type: 'E'),
          ),
          FabAction(
            label: 'Transfer',
            icon: Icons.swap_horiz,
            backgroundColor: const Color(0xFF3B82F6),
            onPressed: () => _navigateToTransactionForm(type: 'T'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: AppDimensions.spacing48,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: AppDimensions.spacing16),
            Text(
              'Error al cargar las transacciones',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.spacing8),
            Text(_error ?? 'Error desconocido'),
            SizedBox(height: AppDimensions.spacing24),
            ElevatedButton(
              onPressed: _loadTransactions,
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
      message: _searchQuery.isEmpty &&
              _selectedDateFilter == TransactionDateFilter.all
          ? 'Crea una nueva transacción utilizando el botón "+"'
          : 'No se encontraron transacciones con los filtros aplicados',
      action: _searchQuery.isNotEmpty ||
              _selectedDateFilter != TransactionDateFilter.all
          ? AppButton(
              text: 'Limpiar filtros',
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = '';
                  _applyDateFilter(TransactionDateFilter.all);
                });
              },
              type: AppButtonType.text,
            )
          : null,
    );
  }
}

class _SliverFilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _SliverFilterHeaderDelegate({required this.child, required this.height});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant _SliverFilterHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}
