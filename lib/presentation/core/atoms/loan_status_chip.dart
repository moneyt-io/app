import 'package:flutter/material.dart';
import '../../../../domain/entities/loan_entry.dart';

class LoanStatusChip extends StatelessWidget {
  final LoanStatus status;

  const LoanStatusChip({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    Color backgroundColor;
    Color textColor;
    String text;
    IconData icon;

    switch (status) {
      case LoanStatus.active:
        backgroundColor = theme.colorScheme.primary.withOpacity(0.1);
        textColor = theme.colorScheme.primary;
        text = 'Activo';
        icon = Icons.trending_up;
        break;
      case LoanStatus.paid:
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        text = 'Pagado';
        icon = Icons.check_circle;
        break;
      case LoanStatus.cancelled:
        backgroundColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey;
        text = 'Cancelado';
        icon = Icons.cancel;
        break;
      case LoanStatus.writtenOff:
        backgroundColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        text = 'Cancelado';
        icon = Icons.highlight_off; // Cambiado de Icons.write_off
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: textColor,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
