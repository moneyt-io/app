import 'package:flutter/material.dart';
import '../../../domain/entities/category.dart';
import 'category_icon.dart';
import '../theme/app_dimensions.dart';

/// Átomo que representa un subelemento de categoría en una lista.
///
/// Este componente muestra la información de una subcategoría con un diseño
/// más compacto que el CategoryListItem estándar.
class CategorySubListItem extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  
  const CategorySubListItem({
    Key? key,
    required this.category,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing16,
          vertical: AppDimensions.spacing8,
        ),
        child: Row(
          children: [
            CategoryIcon(
              icon: category.icon,
              bgColor: category.documentTypeId == 'E' 
                  ? colorScheme.errorContainer.withOpacity(0.7) 
                  : colorScheme.primaryContainer.withOpacity(0.7),
              iconColor: category.documentTypeId == 'E'
                  ? colorScheme.onErrorContainer
                  : colorScheme.onPrimaryContainer,
              size: AppDimensions.iconSizeSmall,
            ),
            SizedBox(width: AppDimensions.spacing12),
            Expanded(
              child: Text(
                category.name,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: colorScheme.error,
                size: AppDimensions.iconSizeSmall,
              ),
              onPressed: onDelete,
              tooltip: 'Eliminar subcategoría',
              constraints: const BoxConstraints(
                minWidth: 32,
                minHeight: 32,
              ),
              padding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}
