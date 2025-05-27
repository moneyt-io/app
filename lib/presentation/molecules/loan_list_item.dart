import 'package:flutter/material.dart';
import '../../domain/entities/loan_entry.dart';
import '../../core/presentation/app_dimensions.dart';
import '../atoms/action_menu_button.dart';

class LoanListItem extends StatelessWidget {
  final LoanEntry loan;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onMarkPaid;
  final Widget? trailing;

  const LoanListItem({
    super.key,
    required this.loan,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onMarkPaid,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacing16),
          child: Row(
            children: [
              // Icono del tipo de préstamo
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getStatusColor(colorScheme).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  _getLoanIcon(),
                  color: _getStatusColor(colorScheme),
                  size: 24,
                ),
              ),
              const SizedBox(width: AppDimensions.spacing16),

              // Información principal
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Contacto y tipo
                    Text(
                      '${loan.contact?.name ?? 'Contacto #${loan.contactId}'} • ${_getLoanTypeText()}',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppDimensions.spacing4),
                    
                    // Monto y saldo
                    Row(
                      children: [
                        Text(
                          '\$${loan.amount.toStringAsFixed(2)}',
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.primary,
                          ),
                        ),
                        // Calcular saldo pendiente dinámicamente
                        Builder(builder: (context) {
                          final outstandingBalance = loan.amount - loan.totalPaid;
                          if (outstandingBalance > 0) {
                            return Text(
                              ' • Pendiente: \$${outstandingBalance.toStringAsFixed(2)}',
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.error,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }),
                      ],
                    ),
                    
                    // Descripción si existe
                    if (loan.description != null && loan.description!.isNotEmpty) ...[
                      const SizedBox(height: AppDimensions.spacing4), // Cambiar spacing2 por spacing4
                      Text(
                        loan.description!,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              // Chip de estado
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacing8,
                  vertical: AppDimensions.spacing4,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(colorScheme).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getStatusText(),
                  style: textTheme.labelSmall?.copyWith(
                    color: _getStatusColor(colorScheme),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(width: AppDimensions.spacing8),

              // Menú de acciones
              ActionMenuButton(
                options: _getMenuOptions(),
                onOptionSelected: (option) {
                  switch (option) {
                    case ActionMenuOption.edit:
                      onEdit?.call();
                      break;
                    case ActionMenuOption.delete:
                      onDelete?.call();
                      break;
                    case ActionMenuOption.pay:
                      onMarkPaid?.call();
                      break;
                    case ActionMenuOption.view:
                      onTap?.call();
                      break;
                  }
                },
              ),

              // Trailing widget
              if (trailing != null)
                Padding(
                  padding: const EdgeInsets.only(left: AppDimensions.spacing4),
                  child: trailing,
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getLoanIcon() {
    if (loan.isLend) {
      return Icons.trending_up; // Préstamo otorgado
    } else {
      return Icons.trending_down; // Préstamo recibido
    }
  }

  String _getLoanTypeText() {
    return loan.isLend ? 'Prestado a' : 'Recibido de';
  }

  String _getStatusText() {
    switch (loan.status) {
      case LoanStatus.active:
        return 'Activo';
      case LoanStatus.paid:
        return 'Pagado';
      case LoanStatus.cancelled:
        return 'Cancelado';
      case LoanStatus.writtenOff:
        return 'Asumido';
    }
  }

  Color _getStatusColor(ColorScheme colorScheme) {
    switch (loan.status) {
      case LoanStatus.active:
        return colorScheme.primary;
      case LoanStatus.paid:
        return Colors.green;
      case LoanStatus.cancelled:
        return colorScheme.outline;
      case LoanStatus.writtenOff:
        return Colors.orange;
    }
  }

  List<ActionMenuOption> _getMenuOptions() {
    final options = <ActionMenuOption>[ActionMenuOption.view];
    
    if (loan.status == LoanStatus.active) {
      options.addAll([
        ActionMenuOption.pay,
        ActionMenuOption.edit,
      ]);
    }
    
    if (loan.totalPaid == 0) {
      options.add(ActionMenuOption.delete);
    }
    
    return options;
  }
}
