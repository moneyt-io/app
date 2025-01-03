import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../routes/app_routes.dart';
import '../../core/l10n/language_manager.dart';
import '../../presentation/providers/drawer_provider.dart';
import 'package:intl/intl.dart';

class TransactionsListWidget extends StatelessWidget {
  final TransactionUseCases transactionUseCases;
  final String? typeFilter;
  final DateTime? startDate;
  final DateTime? endDate;

  const TransactionsListWidget({
    Key? key,
    required this.transactionUseCases,
    this.typeFilter,
    this.startDate,
    this.endDate,
  }) : super(key: key);

  List<TransactionEntity> _filterTransactions(List<TransactionEntity> transactions) {
    return transactions.where((transaction) {
      // Filtrar por tipo
      if (typeFilter != null && transaction.type != typeFilter) {
        return false;
      }

      // Filtrar por fecha
      if (startDate != null && endDate != null) {
        final date = DateTime(
          transaction.transactionDate.year,
          transaction.transactionDate.month,
          transaction.transactionDate.day,
        );
        
        final start = DateTime(
          startDate!.year,
          startDate!.month,
          startDate!.day,
        );
        
        final end = DateTime(
          endDate!.year,
          endDate!.month,
          endDate!.day,
          23, 59, 59  // End of day
        );
        
        return !date.isBefore(start) && !date.isAfter(end);
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;
    final drawerProvider = context.watch<DrawerProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    return StreamBuilder<List<TransactionEntity>>(
      stream: startDate != null && endDate != null
          ? transactionUseCases.watchTransactionsByDateRange(startDate!, endDate!)
          : transactionUseCases.watchAllTransactions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.receipt_long,
                  size: 64,
                  color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  translations.noTransactions,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        }

        final filteredTransactions = _filterTransactions(snapshot.data!);

        if (filteredTransactions.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.filter_list,
                  size: 64,
                  color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  translations.noTransactions,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        // Calcular resumen de transacciones filtradas
        double totalIncome = 0;
        double totalExpense = 0;
        double totalTransfer = 0;

        for (var transaction in filteredTransactions) {
          switch (transaction.type) {
            case 'I':
              totalIncome += transaction.amount;
              break;
            case 'E':
              totalExpense += transaction.amount;
              break;
            case 'T':
              totalTransfer += transaction.amount;
              break;
          }
        }

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

            return Column(
              children: [
                // Resumen de transacciones
                Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translations.income,
                              style: TextStyle(color: colorScheme.primary),
                            ),
                            Text(
                              NumberFormat.currency(symbol: '\$', decimalDigits: 2)
                                  .format(totalIncome),
                              style: TextStyle(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translations.expense,
                              style: TextStyle(color: colorScheme.error),
                            ),
                            Text(
                              NumberFormat.currency(symbol: '\$', decimalDigits: 2)
                                  .format(totalExpense),
                              style: TextStyle(
                                color: colorScheme.error,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translations.transfer,
                              style: TextStyle(color: colorScheme.tertiary),
                            ),
                            Text(
                              NumberFormat.currency(symbol: '\$', decimalDigits: 2)
                                  .format(totalTransfer),
                              style: TextStyle(
                                color: colorScheme.tertiary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translations.balance,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              NumberFormat.currency(symbol: '\$', decimalDigits: 2)
                                  .format(totalIncome - totalExpense),
                              style: TextStyle(
                                color: totalIncome - totalExpense >= 0
                                    ? colorScheme.primary
                                    : colorScheme.error,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Lista de transacciones
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = filteredTransactions[index];
                      final category = transaction.categoryId != null
                          ? categories[transaction.categoryId]
                          : null;

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: transaction.type == 'T'
                              ? colorScheme.tertiary
                              : transaction.type == 'I'
                                  ? colorScheme.primary
                                  : colorScheme.error,
                          child: Icon(
                            transaction.type == 'T'
                                ? Icons.swap_horiz
                                : transaction.type == 'I'
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        title: Text(
                          category?.name ?? translations.unknown,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (transaction.contact != null &&
                                transaction.contact!.isNotEmpty)
                              Text(
                                transaction.contact!,
                                style: TextStyle(
                                  color: colorScheme.primary,
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
                          NumberFormat.currency(symbol: '\$', decimalDigits: 2)
                              .format(transaction.amount),
                          style: TextStyle(
                            color: transaction.type == 'T'
                                ? colorScheme.tertiary
                                : transaction.type == 'I'
                                    ? colorScheme.primary
                                    : colorScheme.error,
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
                ),
              ],
            );
          },
        );
      },
    );
  }
}
