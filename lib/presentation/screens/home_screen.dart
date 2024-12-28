// lib/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../widgets/app_drawer.dart';
import '../widgets/home_accounts_widget.dart';
import '../widgets/home_transactions_widget.dart';
import '../widgets/home_balance_widget.dart';
import '../widgets/home_monthly_stats_widget.dart';
import '../../core/l10n/language_manager.dart';
import '../../routes/app_routes.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class HomeScreen extends StatefulWidget {
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

  // Transacciones
  final TransactionUseCases transactionUseCases;

  const HomeScreen({
    Key? key,
    required this.getCategories,
    required this.createCategory,
    required this.updateCategory,
    required this.deleteCategory,
    required this.getAccounts,
    required this.createAccount,
    required this.updateAccount,
    required this.deleteAccount,
    required this.transactionUseCases,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _expandableFabKey = GlobalKey<ExpandableFabState>();

  void _navigateToTransactionForm(BuildContext context, {required String type}) async {
    await Navigator.pushNamed(context, AppRoutes.transactionForm, arguments: type);
    // Cuando regrese de la navegación, cerrar el FAB si está abierto
    if (_expandableFabKey.currentState?.isOpen ?? false) {
      _expandableFabKey.currentState?.toggle();
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;

    return Scaffold(
      appBar: AppBar(
        title: Text(translations.home),
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
                getAccounts: widget.getAccounts,
                createAccount: widget.createAccount,
                updateAccount: widget.updateAccount,
                deleteAccount: widget.deleteAccount,
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: ExpandableFab(
          key: _expandableFabKey,
          openButtonBuilder: RotateFloatingActionButtonBuilder(
            child: const Icon(Icons.add),
            fabSize: ExpandableFabSize.regular,
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          closeButtonBuilder: DefaultFloatingActionButtonBuilder(
            child: const Icon(Icons.close),
            fabSize: ExpandableFabSize.regular,
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
          overlayStyle: ExpandableFabOverlayStyle(
            // Aumentamos la opacidad para un mejor efecto de difuminado
            color: Colors.black.withOpacity(0.7),
            blur: 3,
          ),
          children: [
            FloatingActionButton.small(
              heroTag: 'expense',
              onPressed: () => _navigateToTransactionForm(context, type: 'E'),
              backgroundColor: Colors.red,
              child: const Icon(Icons.arrow_downward),
            ),
            FloatingActionButton.small(
              heroTag: 'income',
              onPressed: () => _navigateToTransactionForm(context, type: 'I'),
              backgroundColor: Colors.green,
              child: const Icon(Icons.arrow_upward),
            ),
            FloatingActionButton.small(
              heroTag: 'transfer',
              onPressed: () => _navigateToTransactionForm(context, type: 'T'),
              backgroundColor: Colors.blue,
              child: const Icon(Icons.swap_horiz),
            ),
          ],
          type: ExpandableFabType.up,
          distance: 70,
        ),
      ),
    );
  }
}