import 'package:flutter/material.dart';
import '../../core/presentation/app_dimensions.dart';

class LoanSummaryCard extends StatelessWidget {
  final double totalLent;
  final double totalBorrowed;
  final double outstandingLent;
  final double outstandingBorrowed;
  final double netBalance;
  final bool isLoading;

  const LoanSummaryCard({
    super.key,
    required this.totalLent,
    required this.totalBorrowed,
    required this.outstandingLent,
    required this.outstandingBorrowed,
    required this.netBalance,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (isLoading) {
      return Card(
        child: Container(
          height: 120,
          padding: const EdgeInsets.all(AppDimensions.spacing16),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Text(
              'Resumen de Préstamos',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppDimensions.spacing16),

            // Balance neto
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimensions.spacing12),
              decoration: BoxDecoration(
                color: _getBalanceColor(colorScheme).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    'Balance Neto',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacing4),
                  Text(
                    '\$${netBalance.toStringAsFixed(2)}',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _getBalanceColor(colorScheme),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.spacing16),

            // Estadísticas detalladas
            Row(
              children: [
                // Préstamos otorgados
                Expanded(
                  child: _buildStatColumn(
                    context,
                    'Prestado',
                    totalLent,
                    outstandingLent,
                    Icons.trending_up,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: AppDimensions.spacing16),
                
                // Préstamos recibidos
                Expanded(
                  child: _buildStatColumn(
                    context,
                    'Recibido',
                    totalBorrowed,
                    outstandingBorrowed,
                    Icons.trending_down,
                    Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(
    BuildContext context,
    String title,
    double total,
    double outstanding,
    IconData icon,
    Color color,
  ) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        // Icono y título
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: AppDimensions.spacing4),
            Text(
              title,
              style: textTheme.labelMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spacing8),
        
        // Total
        Text(
          '\$${total.toStringAsFixed(2)}',
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        
        // Pendiente
        if (outstanding > 0) ...[
          const SizedBox(height: AppDimensions.spacing2),
          Text(
            'Pendiente: \$${outstanding.toStringAsFixed(2)}',
            style: textTheme.bodySmall?.copyWith(
              color: Colors.red,
            ),
          ),
        ],
      ],
    );
  }

  Color _getBalanceColor(ColorScheme colorScheme) {
    if (netBalance > 0) {
      return Colors.green; // Positivo: más prestado que recibido
    } else if (netBalance < 0) {
      return Colors.red; // Negativo: más recibido que prestado
    } else {
      return colorScheme.onSurfaceVariant; // Neutro
    }
  }
}
