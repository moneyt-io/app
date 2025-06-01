import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountBalanceCard extends StatelessWidget {
  final String title;
  final double balance;
  final String currencySymbol;
  final VoidCallback? onTap;

  const AccountBalanceCard({
    Key? key,
    required this.title,
    required this.balance,
    this.currencySymbol = '\$',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Card(
      elevation: 0,
      color: colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                NumberFormat.currency(symbol: currencySymbol).format(balance),
                style: textTheme.headlineMedium?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              // Se podría añadir más información, como la fecha de última actualización
              Text(
                'Actualizado: ${DateFormat('dd MMM, yyyy').format(DateTime.now())}',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onPrimaryContainer.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
