import 'package:flutter/material.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../routes/app_routes.dart';
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
          transaction.transactionDate.hour,
          transaction.transactionDate.minute,
          transaction.transactionDate.second,
        );
        
        return date.isAtSameMomentAs(startDate!) || 
               date.isAtSameMomentAs(endDate!) ||
               (date.isAfter(startDate!) && date.isBefore(endDate!));
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TransactionEntity>>(
      stream: transactionUseCases.watchAllTransactions(),
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

        return ListView.builder(
          itemCount: filteredTransactions.length,
          itemBuilder: (context, index) {
            final transaction = filteredTransactions[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListTile(
                leading: _buildTransactionIcon(transaction),
                title: Text(
                  transaction.description ?? 'Sin descripción',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat('dd/MM/yyyy').format(transaction.transactionDate)),
                    if (transaction.reference != null)
                      Text('Ref: ${transaction.reference}'),
                  ],
                ),
                trailing: Text(
                  '\$${transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: transaction.flow == 'I' ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.transactionForm,
                    arguments: {
                      'transaction': transaction,
                      'type': transaction.type,
                    },
                  );
                },
              ),
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
