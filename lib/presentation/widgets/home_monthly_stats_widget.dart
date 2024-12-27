import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/language_manager.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/usecases/transaction_usecases.dart';

class HomeMonthlyStatsWidget extends StatelessWidget {
  final TransactionUseCases transactionUseCases;

  const HomeMonthlyStatsWidget({
    Key? key,
    required this.transactionUseCases,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;

    // Obtener el primer y último día del mes actual
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    return StreamBuilder<List<TransactionEntity>>(
      stream: transactionUseCases.watchTransactionsByDateRange(
        firstDayOfMonth,
        lastDayOfMonth,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        final transactions = snapshot.data!;
        
        // Calcular ingresos y gastos
        double income = 0;
        double expenses = 0;

        for (var transaction in transactions) {
          if (transaction.type == 'T') continue; // Ignorar transferencias
          if (transaction.flow == 'I') {
            income += transaction.amount;
          } else {
            expenses += transaction.amount;
          }
        }

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translations.monthlyStats,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildStatRow(
                  context,
                  Icons.arrow_upward,
                  translations.income,
                  income,
                  Colors.green,
                ),
                const Divider(),
                _buildStatRow(
                  context,
                  Icons.arrow_downward,
                  translations.expenses,
                  expenses,
                  Colors.red,
                ),
                const Divider(),
                _buildStatRow(
                  context,
                  income > expenses ? Icons.trending_up : Icons.trending_down,
                  translations.monthlyBalance,
                  income - expenses,
                  income > expenses ? Colors.green : Colors.red,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatRow(
    BuildContext context,
    IconData icon,
    String label,
    double amount,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            NumberFormat.currency(
              symbol: '\$',
              decimalDigits: 2,
            ).format(amount),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
