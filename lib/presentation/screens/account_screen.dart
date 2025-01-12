// lib/presentation/screens/account_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/account.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../routes/app_routes.dart';
import '../widgets/app_drawer.dart';
import '../../core/l10n/language_manager.dart';
import 'package:intl/intl.dart';

class AccountFormArgs {
  final AccountEntity? account;
  final bool isEditing;

  AccountFormArgs({
    this.account,
    this.isEditing = false,
  });
}

class AccountScreen extends StatelessWidget {
  final GetAccounts getAccounts;
  final CreateAccount createAccount;
  final UpdateAccount updateAccount;
  final DeleteAccount deleteAccount;
  final TransactionUseCases transactionUseCases;

  const AccountScreen({
    Key? key,
    required this.getAccounts,
    required this.createAccount,
    required this.updateAccount,
    required this.deleteAccount,
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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(translations.accounts),
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      drawer: const AppDrawer(),
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
                return Center(
                  child: Text(
                    '${translations.error}: ${accountsSnapshot.error}',
                    style: TextStyle(color: colorScheme.error),
                  ),
                );
              }

              final accounts = accountsSnapshot.data!;

              if (accounts.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_balance_outlined,
                        size: 48,
                        color: colorScheme.primary.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        translations.noAccounts,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                );
              }

              final totalBalance = balances.values.fold<double>(0, (a, b) => a + b);
              final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text(
                          translations.totalBalance,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currencyFormat.format(totalBalance),
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: colorScheme.outline.withOpacity(0.2),
                        ),
                      ),
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: accounts.length,
                        separatorBuilder: (context, index) => Divider(
                          color: colorScheme.outline.withOpacity(0.2),
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          final account = accounts[index];
                          final balance = balances[account.id] ?? 0;
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: colorScheme.primaryContainer,
                              child: Icon(
                                Icons.account_balance_outlined,
                                color: colorScheme.onPrimaryContainer,
                              ),
                            ),
                            title: Text(
                              account.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            subtitle: account.description?.isNotEmpty ?? false
                                ? Text(
                                    account.description!,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  )
                                : null,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  currencyFormat.format(balance),
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: balance >= 0
                                        ? colorScheme.primary
                                        : colorScheme.error,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                PopupMenuButton<String>(
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      _navigateToForm(context, account: account);
                                    } else if (value == 'delete') {
                                      // Mostrar diálogo de confirmación
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(translations.deleteAccount),
                                          content: Text(translations.deleteAccountConfirmation),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: Text(translations.cancel),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                deleteAccount(account.id);
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text(translations.accountDeleted)),
                                                );
                                              },
                                              child: Text(translations.delete), // Añadimos el child requerido
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 'edit',
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit, color: colorScheme.primary),
                                          const SizedBox(width: 8),
                                          Text(translations.edit),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 'delete',
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete, color: colorScheme.error),
                                          const SizedBox(width: 8),
                                          Text(translations.delete),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
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