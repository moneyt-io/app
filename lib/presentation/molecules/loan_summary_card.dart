import 'package:flutter/material.dart';
import '../../core/presentation/app_dimensions.dart';

class LoanSummaryCard extends StatelessWidget {
  final Map<String, double> statistics;
  final bool isLoading;

  const LoanSummaryCard({
    super.key,
    required this.statistics,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (isLoading) {
      return Card(
        margin: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: const Padding(
          padding: EdgeInsets.all(AppDimensions.paddingLarge),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    final totalLent = statistics['totalLent'] ?? 0.0;
    final totalBorrowed = statistics['totalBorrowed'] ?? 0.0;
    final outstandingLent = statistics['outstandingLent'] ?? 0.0;
    final outstandingBorrowed = statistics['outstandingBorrowed'] ?? 0.0;
    final netBalance = statistics['netBalance'] ?? 0.0;

    return Card(
      margin: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumen de Préstamos',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            
            // Balance neto
            _buildBalanceRow(
              context,
              'Balance Neto',
              netBalance,
              isTotal: true,
            ),
            
            const Divider(height: AppDimensions.paddingLarge),
            
            // Préstamos otorgados
            _buildSectionHeader(context, 'Préstamos Otorgados', Icons.arrow_upward),
            _buildBalanceRow(context, 'Total prestado', totalLent),
            _buildBalanceRow(context, 'Pendiente por cobrar', outstandingLent),
            
            const SizedBox(height: AppDimensions.paddingMedium),
            
            // Préstamos recibidos
            _buildSectionHeader(context, 'Préstamos Recibidos', Icons.arrow_downward),
            _buildBalanceRow(context, 'Total recibido', totalBorrowed),
            _buildBalanceRow(context, 'Pendiente por pagar', outstandingBorrowed),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingSmall),
      child: Row(
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceRow(
    BuildContext context,
    String label,
    double amount, {
    bool isTotal = false,
  }) {
    final theme = Theme.of(context);
    final isNegative = amount < 0;
    
    Color amountColor = theme.colorScheme.onSurface;
    if (isTotal) {
      amountColor = isNegative ? Colors.red : Colors.green;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            '\$${amount.abs().toStringAsFixed(2)}',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}
