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

class HomeScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;

    return Scaffold(
      appBar: AppBar(
        title: Text(translations.home),
      ),
      drawer: AppDrawer(
        getCategories: getCategories,
        createCategory: createCategory,
        updateCategory: updateCategory,
        deleteCategory: deleteCategory,
        getAccounts: getAccounts,
        createAccount: createAccount,
        updateAccount: updateAccount,
        deleteAccount: deleteAccount,
        transactionUseCases: transactionUseCases,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              HomeBalanceWidget(
                transactionUseCases: transactionUseCases,
              ),
              const SizedBox(height: 8),
              HomeMonthlyStatsWidget(
                transactionUseCases: transactionUseCases,
              ),
              const SizedBox(height: 8),
              HomeAccountsWidget(
                getAccounts: getAccounts,
                createAccount: createAccount,
                updateAccount: updateAccount,
                deleteAccount: deleteAccount,
                transactionUseCases: transactionUseCases,
              ),
              const SizedBox(height: 8),
              HomeTransactionsWidget(
                transactionUseCases: transactionUseCases,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.transactionForm);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}