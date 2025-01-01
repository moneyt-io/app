import 'package:flutter/material.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../routes/app_routes.dart';
import 'package:intl/intl.dart';

class TransactionsListWidget extends StatelessWidget {
  final TransactionUseCases transactionUseCases;
  final GetCategories getCategories;
  final String? typeFilter;
  final DateTime? startDate;
  final DateTime? endDate;

  const TransactionsListWidget({
    Key? key,
    required this.transactionUseCases,
    required this.getCategories,
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
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No hay transacciones',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
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
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No hay resultados para los filtros seleccionados',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
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
          stream: getCategories(),
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
                            Text('Ingresos:', style: TextStyle(color: Colors.green[700])),
                            Text(
                              '\$${totalIncome.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Gastos:', style: TextStyle(color: Colors.red[700])),
                            Text(
                              '\$${totalExpense.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.red[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Transferencias:', style: TextStyle(color: Colors.blue[700])),
                            Text(
                              '\$${totalTransfer.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.blue[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Balance:', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              '\$${(totalIncome - totalExpense).toStringAsFixed(2)}',
                              style: TextStyle(
                                color: totalIncome - totalExpense >= 0 ? Colors.green[700] : Colors.red[700],
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

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: _buildTransactionIcon(transaction),
                          title: Text(
                            category?.name ?? 'Unknown',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (transaction.contact != null && transaction.contact!.isNotEmpty)
                                Text(
                                  transaction.contact!,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              Text(
                                DateFormat('dd/MM/yyyy').format(transaction.transactionDate),
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
                              color: transaction.type == 'I' ? Colors.green : transaction.type == 'E' ? Colors.red : Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.transactionDetails,
                            arguments: transaction,
                          ),
                        ),
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

  Widget _buildTransactionIcon(TransactionEntity transaction) {
    IconData icon;
    Color color;

    switch (transaction.type) {
      case 'E':
        icon = Icons.arrow_downward;
        color = Colors.red;
        break;
      case 'I':
        icon = Icons.arrow_upward;
        color = Colors.green;
        break;
      case 'T':
        icon = Icons.swap_horiz;
        color = Colors.blue;
        break;
      default:
        icon = Icons.attach_money;
        color = Colors.grey;
    }

    return CircleAvatar(
      backgroundColor: color.withOpacity(0.2),
      child: Icon(icon, color: color),
    );
  }
}
