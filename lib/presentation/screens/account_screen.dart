// lib/presentation/screens/account_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/account.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../routes/app_routes.dart';
import '../widgets/app_drawer.dart';
import '../../core/l10n/language_manager.dart';
import 'package:intl/intl.dart'; // Import the intl package

class AccountFormArgs {
  final AccountEntity? account;
  final bool isEditing;

  AccountFormArgs({
    this.account,
    this.isEditing = false,
  });
}

class AccountScreen extends StatelessWidget {
  // Cuentas
  final GetAccounts getAccounts;
  final CreateAccount createAccount;
  final UpdateAccount updateAccount;
  final DeleteAccount deleteAccount;

  // Categorías (necesarias para el drawer)
  final GetCategories getCategories;
  final CreateCategory createCategory;
  final UpdateCategory updateCategory;
  final DeleteCategory deleteCategory;

  final TransactionUseCases transactionUseCases;

  const AccountScreen({
    Key? key,
    required this.getAccounts,
    required this.createAccount,
    required this.updateAccount,
    required this.deleteAccount,
    required this.getCategories,
    required this.createCategory,
    required this.updateCategory,
    required this.deleteCategory,
    required this.transactionUseCases,
  }) : super(key: key);

  void _navigateToForm(BuildContext context, {AccountEntity? account}) {
    Navigator.pushNamed(
      context,
      AppRoutes.accountForm,
      arguments: AccountFormArgs(
        account: account,
        isEditing: account != null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;

    return Scaffold(
      appBar: AppBar(
        title: Text(translations.accounts),
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
      body: StreamBuilder<Map<int, double>>(
        stream: transactionUseCases.watchAllAccountBalances(),
        builder: (context, balancesSnapshot) {
          final balances = balancesSnapshot.data ?? {};

          return StreamBuilder<List<AccountEntity>>(
            stream: getAccounts(),
            builder: (context, accountsSnapshot) {
              if (!accountsSnapshot.hasData || !balancesSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              if (accountsSnapshot.hasError) {
                return Center(child: Text('${translations.error}: ${accountsSnapshot.error}'));
              }

              final accounts = accountsSnapshot.data!;

              if (accounts.isEmpty) {
                return Center(child: Text(translations.noAccounts));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: accounts.length,
                itemBuilder: (context, index) {
                  final account = accounts[index];
                  final balance = balances[account.id] ?? 0.0;
                  final isPositive = balance >= 0;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: Icon(
                        Icons.account_balance_wallet,
                        color: Theme.of(context).colorScheme.primary,
                        size: 32,
                      ),
                      title: Text(
                        account.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (account.description?.isNotEmpty ?? false)
                            Text(
                              account.description!,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodySmall?.color,
                              ),
                            ),
                          const SizedBox(height: 4),
                          Text(
                            NumberFormat.currency(
                              symbol: '\$',
                              decimalDigits: 2,
                            ).format(balance),
                            style: TextStyle(
                              color: isPositive ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      trailing: PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) {
                          switch (value) {
                            case 'edit':
                              _navigateToForm(context, account: account);
                              break;
                            case 'delete':
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text(translations.getText('deleteAccount')),
                                  content: Text(translations.getText('deleteAccountConfirmation')),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(ctx).pop(),
                                      child: Text(translations.getText('cancel')),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        deleteAccount(account.id);
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Text(translations.getText('delete')),
                                    ),
                                  ],
                                ),
                              );
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                const Icon(Icons.edit),
                                const SizedBox(width: 8),
                                Text(translations.getText('edit')),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                const Icon(Icons.delete, color: Colors.red),
                                const SizedBox(width: 8),
                                Text(
                                  translations.getText('delete'),
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () => _navigateToForm(context, account: account),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}