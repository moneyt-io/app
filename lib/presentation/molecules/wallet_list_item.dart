import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/entities/chart_account.dart';
import '../../core/presentation/app_dimensions.dart';
import '../atoms/action_menu_button.dart';

class WalletListItem extends StatelessWidget {
  final Wallet wallet;
  final ChartAccount? chartAccount;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;
  final double? balance;

  const WalletListItem({
    Key? key,
    required this.wallet,
    this.chartAccount,
    required this.onTap,
    required this.onDelete,
    this.onEdit,
    this.balance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
          padding: const EdgeInsets.all(AppDimensions.spacing16),
          child: Row(
            children: [
              // Icono con fondo circular
              Container(
                width: AppDimensions.spacing40,
                height: AppDimensions.spacing40,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: colorScheme.onPrimaryContainer,
                  size: AppDimensions.iconSizeSmall,
                ),
              ),
              const SizedBox(width: AppDimensions.spacing16),
              
              // Información principal
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wallet.name,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (wallet.description != null && wallet.description!.isNotEmpty) ...[
                      Text(
                        wallet.description!,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    // Información de la cuenta contable
                    if (chartAccount != null) ...[
                      const SizedBox(height: AppDimensions.spacing4),
                      Row(
                        children: [
                          Icon(
                            Icons.account_tree_outlined,
                            size: AppDimensions.iconSizeSmall,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: AppDimensions.spacing4),
                          Text(
                            '${chartAccount!.code}',
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              
              // Monto y divisa
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Monto
                  Text(
                    NumberFormat.currency(symbol: wallet.currencyId, decimalDigits: 2)
                      .format(balance ?? 0),
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Divisa
                  Container(
                    margin: const EdgeInsets.only(top: AppDimensions.spacing4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spacing8,
                      vertical: AppDimensions.spacing2,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                    ),
                    child: Text(
                      wallet.currencyId,
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              
              // Menú de acciones usando el átomo
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
