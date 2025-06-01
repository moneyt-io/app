import 'package:flutter/material.dart';
import '../../../domain/entities/loan_entry.dart';
import '../atoms/loan_status_chip.dart';
import '../../navigation/navigation_service.dart';
import '../theme/app_dimensions.dart';

class LoanListItem extends StatelessWidget {
  final LoanEntry loan;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const LoanListItem({
    super.key,
    required this.loan,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLend = loan.documentTypeId == 'L';
    final outstandingBalance = loan.outstandingBalance;
    
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSmall,
        vertical: 4.0, // Usar valor directo en lugar de paddingExtraSmall
      ),
      child: ListTile(
        onTap: onTap ?? () => NavigationService.goToLoanDetail(loan.id),
        onLongPress: onLongPress,
        leading: CircleAvatar(
          backgroundColor: isLend 
              ? theme.colorScheme.primary.withOpacity(0.1)
              : theme.colorScheme.secondary.withOpacity(0.1),
          child: Icon(
            isLend ? Icons.arrow_upward : Icons.arrow_downward,
            color: isLend 
                ? theme.colorScheme.primary
                : theme.colorScheme.secondary,
          ),
        ),
        title: Text(
          loan.contact?.name ?? 'Contacto desconocido',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loan.description ?? (isLend ? 'Préstamo otorgado' : 'Préstamo recibido'),
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Monto: \$${loan.amount.toStringAsFixed(2)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (outstandingBalance > 0) ...[
                  const SizedBox(width: 8),
                  Text(
                    'Pendiente: \$${outstandingBalance.toStringAsFixed(2)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            LoanStatusChip(status: loan.status),
            const SizedBox(height: 4),
            Text(
              '${loan.date.day}/${loan.date.month}/${loan.date.year}',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
