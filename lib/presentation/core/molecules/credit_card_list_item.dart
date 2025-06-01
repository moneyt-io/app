import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/credit_card.dart';
import '../../../domain/entities/chart_account.dart';
import '../theme/app_dimensions.dart';
import '../atoms/action_menu_button.dart';

class CreditCardListItem extends StatelessWidget {
  final CreditCard creditCard;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onPay;
  final double? availableCredit; // ← NUEVO parámetro opcional
  final String? nextPaymentDate; // ← NUEVO parámetro opcional

  const CreditCardListItem({
    Key? key,
    required this.creditCard,
    required this.onTap,
    required this.onDelete,
    required this.onPay,
    this.availableCredit, // ← NUEVO
    this.nextPaymentDate, // ← NUEVO
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    // Format the available credit with currency symbol
    final formattedAvailableCredit = NumberFormat.currency(
      symbol: '\$', // Usando símbolo genérico. Idealmente se obtendría de la moneda.
      decimalDigits: 2,
    ).format(availableCredit);

    return Card(
      elevation: 0,
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
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.spacing12,
            horizontal: AppDimensions.spacing16,
          ),
          child: Row(
            children: [
              // Icono principal
              Container(
                width: AppDimensions.spacing40,
                height: AppDimensions.spacing40,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.credit_card,
                  color: colorScheme.onPrimaryContainer,
                  size: AppDimensions.iconSizeSmall,
                ),
              ),
              const SizedBox(width: AppDimensions.spacing12),
              // Información de la tarjeta
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      creditCard.name,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Disponible: $formattedAvailableCredit',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                    Text(
                      'Próximo pago: $nextPaymentDate',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
              // Opciones
              ActionMenuButton(
                options: const [
                  ActionMenuOption.pay,
                  ActionMenuOption.edit,
                  ActionMenuOption.delete,
                ],
                onOptionSelected: (option) {
                  switch (option) {
                    case ActionMenuOption.pay:
                      onPay();
                      break;
                    case ActionMenuOption.edit:
                      onTap();
                      break;
                    case ActionMenuOption.delete:
                      onDelete();
                      break;
                    case ActionMenuOption.view: // ← AGREGAR caso faltante
                      // No aplica para tarjetas de crédito
                      break;
                    default:
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
