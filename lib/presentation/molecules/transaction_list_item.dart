import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/transaction_entry.dart';
import '../../domain/entities/transaction_detail.dart';
import '../../core/presentation/app_dimensions.dart';
import '../atoms/action_menu_button.dart'; // Añadir esta importación

class TransactionListItem extends StatelessWidget {
  final TransactionEntry transaction;
  final String? categoryName;
  final String? contactName;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;

  const TransactionListItem({
    Key? key,
    required this.transaction,
    this.categoryName,
    this.contactName,
    required this.onTap,
    required this.onDelete,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Configurar colores e iconos según el tipo de transacción
    IconData icon;
    Color backgroundColor;
    Color textColor;

    switch (transaction.documentTypeId) {
      case 'I': // Ingreso
        icon = Icons.arrow_upward;
        backgroundColor = colorScheme.primaryContainer;
        textColor = colorScheme.primary;
        break;
      case 'E': // Gasto
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
        icon = Icons.receipt;
        backgroundColor = colorScheme.surfaceVariant;
        textColor = colorScheme.onSurfaceVariant;
    }

    return Card(
      elevation: 0, // Sin elevación para seguir Material Design 3
      margin: const EdgeInsets.only(bottom: AppDimensions.spacing8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        side: BorderSide(
          color: colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.spacing16),
          child: Row(
            children: [
              // Icono de transacción
              Container(
                width: AppDimensions.spacing40,
                height: AppDimensions.spacing40,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: transaction.documentTypeId == 'E' 
                    ? colorScheme.onErrorContainer 
                    : (transaction.documentTypeId == 'I' 
                      ? colorScheme.onPrimaryContainer 
                      : colorScheme.onTertiaryContainer),
                  size: AppDimensions.iconSizeSmall,
                ),
              ),
              SizedBox(width: AppDimensions.spacing16),
              
              // Información principal
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryName ?? transaction.description ?? 'Sin descripción',
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
                      SizedBox(height: AppDimensions.spacing2),
                    ],
                    Text(
                      DateFormat('dd/MM/yyyy').format(transaction.date),
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
              
              // Reemplazar cualquier botón directo por ActionMenuButton
              ActionMenuButton(
                options: [
                  ActionMenuOption.edit,
                  ActionMenuOption.view,
                  ActionMenuOption.delete,
                ],
                onOptionSelected: (option) {
                  switch (option) {
                    case ActionMenuOption.edit:
                      if (onEdit != null) onEdit!();
                      break;
                    case ActionMenuOption.view:
                      onTap();
                      break;
                    case ActionMenuOption.delete:
                      onDelete();
                      break;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
