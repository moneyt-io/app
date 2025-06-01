import 'package:flutter/material.dart';
import '../../../domain/entities/chart_account.dart';

class ChartAccountListItem extends StatelessWidget {
  final ChartAccount account;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final int indentation;
  
  const ChartAccountListItem({
    Key? key,
    required this.account,
    required this.onTap,
    this.onDelete,
    this.indentation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    // Seleccionar color según el tipo de cuenta
    Color typeColor;
    IconData typeIcon;
    
    if (account.isAssetAccount) {
      typeColor = Colors.green.shade700;
      typeIcon = Icons.account_balance;
    } else if (account.isLiabilityAccount) {
      typeColor = Colors.red.shade700;
      typeIcon = Icons.credit_card;
    } else if (account.isEquityAccount) {
      typeColor = Colors.purple.shade700;
      typeIcon = Icons.pie_chart;
    } else if (account.isIncomeAccount) {
      typeColor = Colors.blue.shade700;
      typeIcon = Icons.arrow_upward;
    } else if (account.isExpenseAccount) {
      typeColor = Colors.orange.shade700;
      typeIcon = Icons.arrow_downward;
    } else {
      typeColor = Colors.grey;
      typeIcon = Icons.help_outline;
    }
    
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.only(
            left: 8.0 + (indentation * 20.0), // Indentación según nivel
            right: 8.0,
            top: 12.0,
            bottom: 12.0,
          ),
          child: Row(
            children: [
              // Icono tipo de cuenta
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: typeColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(typeIcon, color: typeColor, size: 18),
              ),
              const SizedBox(width: 12),
              
              // Información de la cuenta
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          account.code,
                          style: textTheme.bodyMedium?.copyWith(
                            color: typeColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            account.name,
                            style: textTheme.titleMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    if (!account.isRootAccount) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Nivel: ${account.level}',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              // Botón eliminar (opcional)
              if (onDelete != null)
                IconButton(
                  icon: Icon(Icons.delete_outline, color: colorScheme.error),
                  onPressed: onDelete,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
