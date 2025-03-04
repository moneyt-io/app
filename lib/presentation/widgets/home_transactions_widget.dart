import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/language_manager.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/contact.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../routes/app_routes.dart';
import '../../presentation/providers/drawer_provider.dart';

class HomeTransactionsWidget extends StatelessWidget {
  final TransactionUseCases transactionUseCases;
  final int maxTransactions = 5; // Nueva constante

  const HomeTransactionsWidget({
    Key? key,
    required this.transactionUseCases,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;
    final drawerProvider = context.watch<DrawerProvider>();

    return StreamBuilder<List<CategoryEntity>>(
      stream: drawerProvider.getCategories(),
      builder: (context, categoriesSnapshot) {
        if (!categoriesSnapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final categories = {
          for (var category in categoriesSnapshot.data!)
            category.id: category
        };

        return StreamBuilder<List<Contact>>(
          stream: drawerProvider.getContacts(),
          builder: (context, contactsSnapshot) {
            if (!contactsSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final contacts = {
              for (var contact in contactsSnapshot.data!)
                contact.id: contact
            };

            return StreamBuilder<List<TransactionEntity>>(
              stream: transactionUseCases.watchAllTransactions(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Crear una lista mutable y ordenarla
                final sortedTransactions = List<TransactionEntity>.from(snapshot.data!)
                  ..sort((a, b) => b.transactionDate.compareTo(a.transactionDate));
                
                // Tomar los primeros elementos
                final recentTransactions = sortedTransactions.take(maxTransactions).toList();

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
                              translations.recentTransactions,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pushNamed(context, AppRoutes.transactions),
                              child: Text(translations.viewAll),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (recentTransactions.isEmpty)
                          Center(
                            child: Text(translations.noRecentTransactions),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: recentTransactions.length,
                            itemBuilder: (context, index) {
                              final transaction = recentTransactions[index];
                              final category = transaction.categoryId != null 
                                  ? categories[transaction.categoryId]
                                  : null;
                              final contact = transaction.contactId != null
                                  ? contacts[transaction.contactId]
                                  : null;

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
                                  category?.name ?? translations.unknown,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (contact != null)
                                      Text(
                                        contact.name,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                      ),
                                    Text(
                                      DateFormat('dd/MM/yyyy')
                                          .format(transaction.transactionDate),
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
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
          },
        );
      },
    );
  }
}
