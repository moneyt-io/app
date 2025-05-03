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
  final double? balance; // Keep parameter, but won't display in list for now
  final Widget? trailing;

  const WalletListItem({
    Key? key,
    required this.wallet,
    this.chartAccount,
    required this.onTap,
    required this.onDelete,
    this.onEdit,
    this.balance,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: AppDimensions.spacing8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        side: BorderSide(
          color: colorScheme.outline.withOpacity(0.2),
          width: 1, // Assuming AppDimensions.cardBorderWidth is 1
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
              // Icono principal (similar a CategoryListItem)
              Container(
                width: AppDimensions.spacing40, // Check if matches CategoryIcon size
                height: AppDimensions.spacing40,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer, // Consistent background
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_balance_wallet, // Mantener icono de wallet
                  color: colorScheme.onPrimaryContainer,
                  size: AppDimensions.iconSizeSmall, // Check if matches CategoryIcon internal size
                ),
              ),
              const SizedBox(width: AppDimensions.spacing16), // Check vs Category spacing12

              // Información principal (Título y Subtítulo)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Nombre (Título)
                    Text(
                      wallet.name,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Descripción (Subtítulo, si existe)
                    if (wallet.description != null && wallet.description!.isNotEmpty) ...[
                      const SizedBox(height: AppDimensions.spacing2), // Check vs Category subtitle spacing
                      Text(
                        wallet.description!,
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

              // Correct order: Action Menu Button first, then Trailing (expand/collapse)
              // Menú de acciones
              ActionMenuButton( // Compare with Category's IconButton(delete)
                options: const [
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

              // Trailing widget (para botón expandir/colapsar)
              if (trailing != null)
                Padding(
                  padding: const EdgeInsets.only(left: AppDimensions.spacing4), // Check vs Category trailing padding
                  child: trailing,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
