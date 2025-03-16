import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import '../atoms/category_icon.dart';

class CategoryListItem extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const CategoryListItem({
    Key? key,
    required this.category,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
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
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  category.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: colorScheme.error,
                ),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
