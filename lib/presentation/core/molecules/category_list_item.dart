import 'package:flutter/material.dart';
import '../../../domain/entities/category.dart';
import '../atoms/category_icon.dart';
import '../design_system/theme/app_dimensions.dart';

/// Molécula que representa un ítem de categoría en una lista.
///
/// Este componente muestra la información básica de una categoría y
/// proporciona acciones como eliminar o editar.
class CategoryListItem extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final Widget? trailing;

  const CategoryListItem({
    Key? key,
    required this.category,
    required this.onTap,
    required this.onDelete,
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
          width: AppDimensions.cardBorderWidth,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacing12),
          child: Row(
            children: [
              CategoryIcon(
                icon: category.icon,
                bgColor: category.documentTypeId == 'E'
                    ? colorScheme.errorContainer
                    : colorScheme.primaryContainer,
                iconColor: category.documentTypeId == 'E'
                    ? colorScheme.onErrorContainer
                    : colorScheme.onPrimaryContainer,
                size: AppDimensions.iconSizeMedium,
              ),
              SizedBox(width: AppDimensions.spacing12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (category.parentId != null)
                      Text(
                        'Subcategoría', // Placeholder text, might need dynamic count
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: colorScheme.error,
                  size: AppDimensions.iconSizeMedium,
                ),
                onPressed: onDelete,
                tooltip: 'Eliminar categoría',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
