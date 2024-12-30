// lib/presentation/screens/transaction_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/account_usecases.dart';
import '../widgets/transactions_list_widget.dart';
import '../widgets/app_drawer.dart';
import '../widgets/transaction_filters_widget.dart';
import '../widgets/expandable_fab_widget.dart';
import '../../routes/app_routes.dart';
import '../../core/l10n/language_manager.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
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

  const TransactionScreen({
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
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _expandableFabKey = GlobalKey<ExpandableFabState>();
  String _selectedType = 'all';
  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedDateRange = 'lastMonth';

  void _navigateToTransactionForm(BuildContext context, {required String type}) async {
    await Navigator.pushNamed(context, AppRoutes.transactionForm, arguments: type);
    if (_expandableFabKey.currentState?.isOpen ?? false) {
      _expandableFabKey.currentState?.toggle();
    }
  }

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    switch (_selectedDateRange) {
      case 'today':
        _startDate = DateTime(now.year, now.month, now.day);
        _endDate = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
        break;
      case 'yesterday':
        final yesterday = now.subtract(const Duration(days: 1));
        _startDate = DateTime(yesterday.year, yesterday.month, yesterday.day);
        _endDate = DateTime(yesterday.year, yesterday.month, yesterday.day, 23, 59, 59, 999);
        break;
      case 'lastWeek':
        _endDate = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
        _startDate = _endDate!.subtract(const Duration(days: 7));
        break;
      case 'lastMonth':
        _endDate = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
        // Restamos un mes y ajustamos por si el día actual no existe en el mes anterior
        DateTime start;
        if (now.month == 1) {
          start = DateTime(now.year - 1, 12, now.day);
        } else {
          final daysInPreviousMonth = DateTime(now.year, now.month, 0).day;
          final day = now.day > daysInPreviousMonth ? daysInPreviousMonth : now.day;
          start = DateTime(now.year, now.month - 1, day);
        }
        _startDate = start;
        break;
      case 'lastThreeMonths':
        _endDate = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
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
        _startDate = start;
        break;
      case 'thisYear':
        _startDate = DateTime(now.year, 1, 1);
        _endDate = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
        break;
      case 'custom':
        _startDate = now.subtract(const Duration(days: 30));
        _endDate = now;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;

    return Scaffold(
      appBar: AppBar(
        title: Text(translations.transactions),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: TransactionFiltersWidget(
            selectedType: _selectedType,
            selectedDateRange: _selectedDateRange,
            startDate: _startDate,
            endDate: _endDate,
            onTypeChanged: (value) => setState(() => _selectedType = value),
            onDateRangeChanged: (range) {
              setState(() {
                _selectedDateRange = range;
                final now = DateTime.now();
                switch (range) {
                  case 'today':
                    _startDate = DateTime(now.year, now.month, now.day);
                    _endDate = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
                    break;
                  case 'yesterday':
                    final yesterday = now.subtract(const Duration(days: 1));
                    _startDate = DateTime(yesterday.year, yesterday.month, yesterday.day);
                    _endDate = DateTime(yesterday.year, yesterday.month, yesterday.day, 23, 59, 59, 999);
                    break;
                  case 'lastWeek':
                    _endDate = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
                    _startDate = _endDate!.subtract(const Duration(days: 7));
                    break;
                  case 'lastMonth':
                    _endDate = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
                    // Restamos un mes y ajustamos por si el día actual no existe en el mes anterior
                    DateTime start;
                    if (now.month == 1) {
                      start = DateTime(now.year - 1, 12, now.day);
                    } else {
                      final daysInPreviousMonth = DateTime(now.year, now.month, 0).day;
                      final day = now.day > daysInPreviousMonth ? daysInPreviousMonth : now.day;
                      start = DateTime(now.year, now.month - 1, day);
                    }
                    _startDate = start;
                    break;
                  case 'lastThreeMonths':
                    _endDate = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
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
                    _startDate = start;
                    break;
                  case 'thisYear':
                    _startDate = DateTime(now.year, 1, 1);
                    _endDate = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
                    break;
                  case 'custom':
                    _startDate = now.subtract(const Duration(days: 30));
                    _endDate = now;
                    break;
                }
              });
            },
            onCustomDateRangeChanged: (start, end) {
              setState(() {
                _startDate = start;
                _endDate = end;
              });
            },
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
