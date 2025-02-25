// lib/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:moneyt_pfm/presentation/widgets/sync_action_button.dart';
import 'package:provider/provider.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../widgets/app_drawer.dart';
import '../widgets/home_accounts_widget.dart';
import '../widgets/home_transactions_widget.dart';
import '../widgets/home_balance_widget.dart';
import '../widgets/home_monthly_stats_widget.dart';
import '../widgets/expandable_fab_widget.dart';
import '../../core/l10n/language_manager.dart';
import '../routes/app_routes.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import '../../core/navigation/navigation_service.dart';

class HomeScreen extends StatefulWidget {
  final TransactionUseCases transactionUseCases;

  const HomeScreen({
    Key? key,
    required this.transactionUseCases,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _expandableFabKey = GlobalKey<ExpandableFabState>();

  void _navigateToTransactionForm(BuildContext context, {required String type}) async {
    await Navigator.pushNamed(context, AppRoutes.transactionForm, arguments: type);
    if (_expandableFabKey.currentState?.isOpen ?? false) {
      _expandableFabKey.currentState?.toggle();
    }
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
          centerTitle: true,
          title: Text(
            translations.home,
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          backgroundColor: colorScheme.surface,
          elevation: 0,
          iconTheme: IconThemeData(
            color: colorScheme.onSurface,
          ),
          actions: [
            const SyncActionButton(),
          ],
        ),
        drawer: const AppDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                HomeBalanceWidget(
                  transactionUseCases: widget.transactionUseCases,
                ),
                const SizedBox(height: 8),
                HomeMonthlyStatsWidget(
                  transactionUseCases: widget.transactionUseCases,
                ),
                const SizedBox(height: 8),
                HomeAccountsWidget(
                  transactionUseCases: widget.transactionUseCases,
                ),
                const SizedBox(height: 8),
                HomeTransactionsWidget(
                  transactionUseCases: widget.transactionUseCases,
                ),
              ],
            ),
          ),
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