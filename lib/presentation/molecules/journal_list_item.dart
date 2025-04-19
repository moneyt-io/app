import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/journal_entry.dart';
import '../../core/presentation/app_dimensions.dart';

class JournalListItem extends StatelessWidget {
  final JournalEntry journal;
  final VoidCallback onTap;

  const JournalListItem({
    Key? key,
    required this.journal,
    required this.onTap,
  }) : super(key: key);

  Color _getDocumentTypeColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (journal.documentTypeId) {
      case 'I': return Colors.green;
      case 'E': return colorScheme.error;
      case 'T': return colorScheme.tertiary;
      case 'L': return Colors.blue;
      case 'B': return Colors.orange;
      default: return colorScheme.primary;
    }
  }

  IconData _getDocumentTypeIcon() {
    switch (journal.documentTypeId) {
      case 'I': return Icons.arrow_upward;
      case 'E': return Icons.arrow_downward;
      case 'T': return Icons.swap_horiz;
      case 'L': return Icons.attach_money;
      case 'B': return Icons.money_off;
      default: return Icons.receipt;
    }
  }

  String _getDocumentTypeLabel() {
    switch (journal.documentTypeId) {
      case 'I': return 'Ingreso';
      case 'E': return 'Gasto';
      case 'T': return 'Transferencia';
      case 'L': return 'Préstamo Otorgado';
      case 'B': return 'Préstamo Recibido';
      default: return 'Otro';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final typeColor = _getDocumentTypeColor(context);
    
    // Calcular totales
    double totalDebit = 0;
    double totalCredit = 0;
    
    for (final detail in journal.details) {
      totalDebit += detail.debit;
      totalCredit += detail.credit;
    }

    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: AppDimensions.spacing8),
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
                  color: typeColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getDocumentTypeIcon(),
                  color: typeColor,
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
                      journal.description ?? _getDocumentTypeLabel(),
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppDimensions.spacing4),
                    Row(
                      children: [
                        Text(
                          'N° ${journal.secuencial} • ',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          DateFormat('HH:mm').format(journal.date),
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.spacing8,
                            vertical: AppDimensions.spacing4,
                          ),
                          decoration: BoxDecoration(
                            color: journal.isBalanced 
                                ? Colors.green.withOpacity(0.2) 
                                : colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                          ),
                          child: Text(
                            journal.isBalanced ? 'Balanceado' : 'Desbalanceado',
                            style: textTheme.bodySmall?.copyWith(
                              color: journal.isBalanced 
                                  ? Colors.green.shade700 
                                  : colorScheme.error,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Icono de navegación
              Icon(
                Icons.chevron_right,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
