// lib/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/account.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../widgets/app_drawer.dart';
import '../../routes/app_routes.dart';
import '../../core/l10n/language_manager.dart';

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección de Cuentas
            StreamBuilder<List<AccountEntity>>(
              stream: getAccounts(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final accounts = snapshot.data!;
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translations.accounts,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: accounts.length,
                          itemBuilder: (context, index) {
                            final account = accounts[index];
                            return ListTile(
                              title: Text(account.name),
                              subtitle: Text(account.description ?? ''),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                // Navegar a los detalles de la cuenta
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Sección de Transacciones Recientes
            StreamBuilder<List<TransactionEntity>>(
              stream: transactionUseCases.watchAllTransactions(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final transactions = snapshot.data!;
                final recentTransactions = transactions.take(5).toList();

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translations.getText('recentTransactions'),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.transactions,
                                );
                              },
                              child: Text(translations.getText('viewAll')),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (recentTransactions.isEmpty)
                          Center(
                            child: Text(translations.getText('noRecentTransactions')),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: recentTransactions.length,
                            itemBuilder: (context, index) {
                              final transaction = recentTransactions[index];
                              return ListTile(
                                leading: Icon(
                                  transaction.type == 'I'
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward,
                                  color: transaction.type == 'I'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                title: Text(
                                  transaction.description ?? translations.getText('noDescription'),
                                ),
                                subtitle: Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(transaction.transactionDate),
                                ),
                                trailing: Text(
                                  NumberFormat.currency(
                                    symbol: '\$',
                                    decimalDigits: 2,
                                  ).format(transaction.amount),
                                  style: TextStyle(
                                    color: transaction.flow == 'I'
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.transactionForm,
                                    arguments: transaction,
                                  );
                                },
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
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