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
      body: StreamBuilder<List<AccountEntity>>(
        stream: getAccounts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('${translations.error}: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final accounts = snapshot.data!;

          if (accounts.isEmpty) {
            return Center(child: Text(translations.noAccounts));
          }

          return ListView.builder(
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              final account = accounts[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  title: Text(account.name),
                  subtitle: Text(account.description ?? translations.noDescription),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) async {
                      switch (value) {
                        case 'edit':
                          _navigateToForm(context, account: account);
                          break;
                        case 'delete':
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(translations.deleteAccount),
                              content: Text(translations.deleteAccountConfirmation),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: Text(translations.cancel),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: Text(translations.delete),
                                ),
                              ],
                            ),
                          );
                          
                          if (confirm == true) {
                            await deleteAccount(account.id!);
                          }
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
                            Text(translations.edit),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            const Icon(Icons.delete),
                            const SizedBox(width: 8),
                            Text(translations.delete),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}