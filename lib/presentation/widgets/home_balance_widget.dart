import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/language_manager.dart';
import '../../domain/usecases/transaction_usecases.dart';

class HomeBalanceWidget extends StatelessWidget {
  final TransactionUseCases transactionUseCases;

  const HomeBalanceWidget({
    Key? key,
    required this.transactionUseCases,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;
    
    return StreamBuilder<Map<int, double>>(
      stream: transactionUseCases.watchAllAccountBalances(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        final balances = snapshot.data!;
        final totalBalance = balances.values.fold(0.0, (sum, balance) => sum + balance);
        final isPositive = totalBalance >= 0;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translations.totalBalance,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      color: isPositive ? Colors.green : Colors.red,
                      size: 32,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      NumberFormat.currency(
                        symbol: '\$',
                        decimalDigits: 2,
                      ).format(totalBalance),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isPositive ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
