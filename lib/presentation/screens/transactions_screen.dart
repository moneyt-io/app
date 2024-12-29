import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../domain/entities/transaction.dart';
import '../widgets/transactions_list_widget.dart';
import '../widgets/app_drawer.dart';
import '../../routes/app_routes.dart';
import '../../core/l10n/language_manager.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../widgets/expandable_fab_widget.dart';

enum DateRange {
  today,
  yesterday,
  lastWeek,
  lastMonth,
  lastThreeMonths,
  thisYear,
  custom
}

extension DateRangeExtension on DateRange {
  String get label {
    switch (this) {
      case DateRange.today:
        return 'Hoy';
      case DateRange.yesterday:
        return 'Ayer';
      case DateRange.lastWeek:
        return 'Última semana';
      case DateRange.lastMonth:
        return 'Último mes';
      case DateRange.lastThreeMonths:
        return 'Últimos 3 meses';
      case DateRange.thisYear:
        return 'Este año';
      case DateRange.custom:
        return 'Personalizado';
    }
  }

  DateTimeRange get dateRange {
    final now = DateTime.now();
    switch (this) {
      case DateRange.today:
        final start = DateTime(now.year, now.month, now.day);
        final end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
        return DateTimeRange(start: start, end: end);
      case DateRange.yesterday:
        final yesterday = now.subtract(const Duration(days: 1));
        final start = DateTime(yesterday.year, yesterday.month, yesterday.day);
        final end = DateTime(yesterday.year, yesterday.month, yesterday.day, 23, 59, 59, 999);
        return DateTimeRange(start: start, end: end);
      case DateRange.lastWeek:
        final end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
        final start = end.subtract(const Duration(days: 7));
        return DateTimeRange(start: start, end: end);
      case DateRange.lastMonth:
        final end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
        // Restamos un mes y ajustamos por si el día actual no existe en el mes anterior
        DateTime start;
        if (now.month == 1) {
          start = DateTime(now.year - 1, 12, now.day);
        } else {
          final daysInPreviousMonth = DateTime(now.year, now.month, 0).day;
          final day = now.day > daysInPreviousMonth ? daysInPreviousMonth : now.day;
          start = DateTime(now.year, now.month - 1, day);
        }
        return DateTimeRange(start: start, end: end);
      case DateRange.lastThreeMonths:
        final end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
        // Restamos tres meses y ajustamos por si el día actual no existe
        DateTime start;
        if (now.month <= 3) {
          final newMonth = now.month + 9; // Volvemos al año anterior
          final daysInMonth = DateTime(now.year - 1, newMonth, 0).day;
          final day = now.day > daysInMonth ? daysInMonth : now.day;
          start = DateTime(now.year - 1, newMonth, day);
        } else {
          final daysInMonth = DateTime(now.year, now.month - 3, 0).day;
          final day = now.day > daysInMonth ? daysInMonth : now.day;
          start = DateTime(now.year, now.month - 3, day);
        }
        return DateTimeRange(start: start, end: end);
      case DateRange.thisYear:
        return DateTimeRange(
          start: DateTime(now.year, 1, 1),
          end: DateTime(now.year, now.month, now.day, 23, 59, 59, 999),
        );
      case DateRange.custom:
        return DateTimeRange(
          start: now.subtract(const Duration(days: 30)),
          end: now,
        );
    }
  }
}

class TransactionsScreen extends StatefulWidget {
  // Transacciones
  final TransactionUseCases transactionUseCases;

  // Categorías
  final GetCategories getCategories;
  final CreateCategory createCategory;
  final UpdateCategory updateCategory;
  final DeleteCategory deleteCategory;

  // Cuentas
  final GetAccounts getAccounts;
  final CreateAccount createAccount;
  final UpdateAccount updateAccount;
  final DeleteAccount deleteAccount;

  const TransactionsScreen({
    Key? key,
    required this.transactionUseCases,
    required this.getCategories,
    required this.createCategory,
    required this.updateCategory,
    required this.deleteCategory,
    required this.getAccounts,
    required this.createAccount,
    required this.updateAccount,
    required this.deleteAccount,
  }) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final _expandableFabKey = GlobalKey<ExpandableFabState>();
  String _selectedType = 'all';
  DateTime? _startDate;
  DateTime? _endDate;
  DateRange _selectedDateRange = DateRange.lastMonth;

  void _navigateToTransactionForm(BuildContext context, {required String type}) async {
    await Navigator.pushNamed(context, AppRoutes.transactionForm, arguments: type);
    if (_expandableFabKey.currentState?.isOpen ?? false) {
      _expandableFabKey.currentState?.toggle();
    }
  }

  void _setDateRange(DateRange range) {
    setState(() {
      _selectedDateRange = range;
      if (range == DateRange.custom) {
        _selectCustomDateRange(context);
      } else {
        final dateRange = range.dateRange;
        _startDate = dateRange.start;
        _endDate = dateRange.end;
      }
    });
  }

  Future<void> _selectCustomDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: _startDate ?? DateTime.now().subtract(const Duration(days: 30)),
      end: _endDate ?? DateTime.now(),
    );

    final pickedDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: initialDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDateRange != null) {
      setState(() {
        _startDate = pickedDateRange.start;
        _endDate = pickedDateRange.end;
      });
    }
  }

  String get _dateRangeText {
    if (_selectedDateRange == DateRange.custom) {
      if (_startDate == null || _endDate == null) {
        return 'Personalizado';
      }
      final dateFormat = DateFormat('dd/MM/yyyy');
      return '${dateFormat.format(_startDate!)} - ${dateFormat.format(_endDate!)}';
    }
    return _selectedDateRange.label;
  }

  @override
  void initState() {
    super.initState();
    final dateRange = _selectedDateRange.dateRange;
    _startDate = dateRange.start;
    _endDate = dateRange.end;
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;

    return Scaffold(
      appBar: AppBar(
        title: Text(translations.transactions),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                // Filtro de tipo
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: PopupMenuButton<String>(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'all',
                        child: Text(translations.all),
                      ),
                      PopupMenuItem(
                        value: 'I',
                        child: Text(translations.income),
                      ),
                      PopupMenuItem(
                        value: 'E',
                        child: Text(translations.expense),
                      ),
                      PopupMenuItem(
                        value: 'T',
                        child: Text(translations.transfer),
                      ),
                    ],
                    onSelected: (value) {
                      setState(() {
                        _selectedType = value;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedType == 'all'
                                ? translations.all
                                : _selectedType == 'I'
                                    ? translations.income
                                    : _selectedType == 'E'
                                        ? translations.expense
                                        : translations.transfer,
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Filtro de fecha
                Expanded(
                  child: PopupMenuButton<DateRange>(
                    itemBuilder: (context) => DateRange.values
                        .map((range) => PopupMenuItem(
                              value: range,
                              child: Text(range.label),
                            ))
                        .toList(),
                    onSelected: _setDateRange,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              _dateRangeText,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: AppDrawer(
        getCategories: widget.getCategories,
        createCategory: widget.createCategory,
        updateCategory: widget.updateCategory,
        deleteCategory: widget.deleteCategory,
        getAccounts: widget.getAccounts,
        createAccount: widget.createAccount,
        updateAccount: widget.updateAccount,
        deleteAccount: widget.deleteAccount,
        transactionUseCases: widget.transactionUseCases,
      ),
      body: Column(
        children: [
          Expanded(
            child: TransactionsListWidget(
              transactionUseCases: widget.transactionUseCases,
              typeFilter: _selectedType == 'all' ? null : _selectedType,
              startDate: _startDate,
              endDate: _endDate,
            ),
          ),
          // Total de valores
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: StreamBuilder<List<TransactionEntity>>(
              stream: widget.transactionUseCases.watchAllTransactions(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                }

                final transactions = snapshot.data!;
                final filteredTransactions = transactions.where((transaction) {
                  // Filtrar por tipo
                  if (_selectedType != 'all' && transaction.type != _selectedType) {
                    return false;
                  }

                  // Filtrar por fecha
                  if (_startDate != null && _endDate != null) {
                    final date = transaction.transactionDate;
                    return date.isAfter(_startDate!.subtract(const Duration(days: 1))) &&
                           date.isBefore(_endDate!.add(const Duration(days: 1)));
                  }

                  return true;
                }).toList();

                double totalIngresos = 0;
                double totalGastos = 0;

                for (var transaction in filteredTransactions) {
                  if (transaction.flow == 'I') {
                    totalIngresos += transaction.amount;
                  } else {
                    totalGastos += transaction.amount;
                  }
                }

                final numberFormat = NumberFormat.currency(
                  symbol: '\$',
                  decimalDigits: 2,
                );

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Ingresos',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          numberFormat.format(totalIngresos),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Gastos',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          numberFormat.format(totalGastos),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Balance',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          numberFormat.format(totalIngresos - totalGastos),
                          style: TextStyle(
                            fontSize: 16,
                            color: totalIngresos - totalGastos >= 0
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFabWidget(
        fabKey: _expandableFabKey,
        onTransactionPressed: _navigateToTransactionForm,
      ),
    );
  }
}
