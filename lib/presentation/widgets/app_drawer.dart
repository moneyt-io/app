// lib/presentation/widgets/app_drawer.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moneyt_pfm/domain/usecases/transaction_usecases.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../routes/app_routes.dart';
import '../../core/l10n/language_manager.dart';

class AppDrawer extends StatelessWidget {
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

  final TransactionUseCases transactionUseCases;

  const AppDrawer({
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

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_balance_wallet,
                  size: 64,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                Text(
                  translations.appName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.dashboard),
                  title: Text(translations.home),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.receipt_long),
                  title: Text(translations.transactions),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.transactions);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.account_balance),
                  title: Text(translations.accounts),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.accounts,
                      arguments: {
                        'getAccounts': getAccounts,
                        'createAccount': createAccount,
                        'updateAccount': updateAccount,
                        'deleteAccount': deleteAccount,
                      },
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.category),
                  title: Text(translations.categories),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.categories,
                      arguments: {
                        'getCategories': getCategories,
                        'createCategory': createCategory,
                        'updateCategory': updateCategory,
                        'deleteCategory': deleteCategory,
                      },
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(translations.settings),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.settings);
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              translations.getText('version'),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}