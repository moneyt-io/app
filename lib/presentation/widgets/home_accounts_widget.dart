import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/language_manager.dart';
import '../../domain/entities/account.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../routes/app_routes.dart';
import '../../presentation/providers/drawer_provider.dart';

class HomeAccountsWidget extends StatelessWidget {
  final TransactionUseCases transactionUseCases;

  const HomeAccountsWidget({
    Key? key,
    required this.transactionUseCases,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;
    final drawerProvider = context.watch<DrawerProvider>();

    return StreamBuilder<Map<int, double>>(
      stream: transactionUseCases.watchAllAccountBalances(),
      builder: (context, balancesSnapshot) {
        final balances = balancesSnapshot.data ?? {};

        return StreamBuilder<List<AccountEntity>>(
          stream: drawerProvider.getAccounts(),
          builder: (context, accountsSnapshot) {
            if (!accountsSnapshot.hasData || !balancesSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final accounts = accountsSnapshot.data!;

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
                          translations.accounts,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(context, AppRoutes.accounts),
                          child: Text(translations.viewAll),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (accounts.isEmpty)
                      Center(
                        child: Text(translations.noAccounts),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: accounts.length,
                        itemBuilder: (context, index) {
                          final account = accounts[index];
                          final balance = balances[account.id] ?? 0.0;

                          return ListTile(
                            leading: Icon(
                              Icons.account_balance_wallet,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text(account.name),
                            subtitle: Text(account.description ?? ''),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  NumberFormat.currency(
                                    symbol: '\$',
                                    decimalDigits: 2,
                                  ).format(balance),
                                  style: TextStyle(
                                    color: balance >= 0
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios, size: 16),
                              ],
                            ),
                            onTap: () => Navigator.pushNamed(context, AppRoutes.accounts),
                          );
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
