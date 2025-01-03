// lib/presentation/screens/transaction_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:provider/provider.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../widgets/transactions_list_widget.dart';
import '../widgets/app_drawer.dart';
import '../widgets/transaction_filters_widget.dart';
import '../widgets/expandable_fab_widget.dart';
import '../../routes/app_routes.dart';
import '../../core/l10n/language_manager.dart';
import '../../core/navigation/navigation_service.dart';
import '../../core/utils/date_utils.dart' as date_utils;

class TransactionScreen extends StatefulWidget {
  final TransactionUseCases transactionUseCases;

  const TransactionScreen({
    Key? key,
    required this.transactionUseCases,
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
    _updateDateRange(_selectedDateRange);
  }

  void _updateDateRange(String range) {
    setState(() {
      _selectedDateRange = range;
      final dateRange = date_utils.calculateDateRange(range);
      _startDate = dateRange.start;
      _endDate = dateRange.end;
    });
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return WillPopScope(
      onWillPop: () => NavigationService.handleWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            translations.transactions,
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          backgroundColor: colorScheme.surface,
          elevation: 0,
          iconTheme: IconThemeData(
            color: colorScheme.onSurface,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: TransactionFiltersWidget(
              selectedType: _selectedType,
              selectedDateRange: _selectedDateRange,
              startDate: _startDate,
              endDate: _endDate,
              onTypeChanged: (value) => setState(() => _selectedType = value),
              onDateRangeChanged: _updateDateRange,
              onCustomDateRangeChanged: (start, end) {
                setState(() {
                  _startDate = start;
                  _endDate = end;
                });
              },
            ),
          ),
        ),
        drawer: const AppDrawer(),
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
      ),
    );
  }
}
