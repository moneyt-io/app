import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/language_manager.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../routes/app_routes.dart';

class HomeTransactionsWidget extends StatelessWidget {
  final TransactionUseCases transactionUseCases;

  const HomeTransactionsWidget({
    Key? key,
    required this.transactionUseCases,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;

    return StreamBuilder<List<TransactionEntity>>(
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
                          transaction.type == 'T' 
                              ? Icons.swap_horiz
                              : transaction.type == 'I'
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                          color: transaction.type == 'T'
                              ? Colors.blue
                              : transaction.type == 'I'
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
                            color: transaction.type == 'T'
                                ? Colors.blue
                                : transaction.type == 'I'
                                    ? Colors.green
                                    : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.transactionDetails,
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
    );
  }
}
