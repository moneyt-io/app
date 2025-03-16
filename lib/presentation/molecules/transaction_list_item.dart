import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/transaction.dart';

class TransactionListItem extends StatelessWidget {
  final TransactionEntity transaction;
  final String? categoryName;
  final String? contactName;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const TransactionListItem({
    Key? key,
    required this.transaction,
    this.categoryName,
    this.contactName,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Configurar colores e iconos según el tipo de transacción
    IconData icon;
    Color backgroundColor;
    Color textColor;

    switch (transaction.type) {
      case 'I': // Ingreso
        icon = Icons.arrow_upward;
        backgroundColor = colorScheme.primaryContainer;
        textColor = colorScheme.primary;
        break;
      case 'E': // Egreso/Gasto
        icon = Icons.arrow_downward;
        backgroundColor = colorScheme.errorContainer;
        textColor = colorScheme.error;
        break;
      case 'T': // Transferencia
        icon = Icons.swap_horiz;
        backgroundColor = colorScheme.tertiaryContainer;
        textColor = colorScheme.tertiary;
        break;
      default:
        icon = Icons.attach_money;
        backgroundColor = colorScheme.surfaceVariant;
        textColor = colorScheme.onSurfaceVariant;
    }

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icono circular
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: transaction.type == 'E' 
                    ? colorScheme.onErrorContainer 
                    : (transaction.type == 'I' 
                      ? colorScheme.onPrimaryContainer 
                      : colorScheme.onTertiaryContainer),
                ),
              ),
              const SizedBox(width: 16),
              
              // Información principal
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryName ?? transaction.description ?? 'Sin categoría',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (contactName != null) ...[
                      Text(
                        contactName!,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 2),
                    ],
                    Text(
                      DateFormat('dd/MM/yyyy').format(transaction.transactionDate),
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Monto
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(transaction.amount),
                    style: textTheme.titleMedium?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              // Botón eliminar
              IconButton(
                onPressed: onDelete,
                icon: Icon(
                  Icons.delete_outline,
                  color: colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
