import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/account.dart';
import '../../core/l10n/language_manager.dart';
import '../../domain/usecases/transaction_usecases.dart';
import 'package:provider/provider.dart';

class AccountSelectionModal extends StatelessWidget {
  final List<AccountEntity> accounts;
  final Function(AccountEntity) onAccountSelected;
  final AccountEntity? excludeAccount;
  final TransactionUseCases transactionUseCases;

  const AccountSelectionModal({
    Key? key,
    required this.accounts,
    required this.onAccountSelected,
    required this.transactionUseCases,
    this.excludeAccount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final translations = context.watch<LanguageManager>().translations;
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.viewInsets.bottom + mediaQuery.padding.bottom;
    final numberFormat = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 2,
    );

    // Filtrar cuentas si hay una para excluir (caso de transferencias)
    final displayAccounts = excludeAccount != null 
        ? accounts.where((account) => account.id != excludeAccount!.id).toList()
        : accounts;

    return Container(
      constraints: BoxConstraints(
        maxHeight: mediaQuery.size.height * 0.75,
      ),
      padding: EdgeInsets.only(
        top: 16 + mediaQuery.padding.top,
        left: 16,
        right: 16,
        bottom: bottomPadding + 16,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 32,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(
            translations.selectAccount,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: StreamBuilder<Map<int, double>>(
              stream: transactionUseCases.watchAllAccountBalances(),
              builder: (context, snapshot) {
                final balances = snapshot.data ?? {};

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: displayAccounts.length,
                  itemBuilder: (context, index) {
                    final account = displayAccounts[index];
                    final balance = balances[account.id] ?? 0.0;
                    
                    return Card(
                      elevation: 0,
                      color: colorScheme.surfaceVariant.withOpacity(0.3),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Icon(
                          Icons.account_balance_wallet,
                          color: colorScheme.primary,
                        ),
                        title: Text(
                          account.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${translations.availableBalance}: ${numberFormat.format(balance)}',
                          style: TextStyle(
                            color: balance >= 0 
                                ? Colors.green 
                                : Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () {
                          onAccountSelected(account);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
