import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import '../../core/l10n/language_manager.dart';
import 'package:provider/provider.dart';

class CategorySelectionModal extends StatelessWidget {
  final List<CategoryEntity> categories;
  final String transactionType;
  final Function(CategoryEntity) onCategorySelected;

  const CategorySelectionModal({
    Key? key,
    required this.categories,
    required this.transactionType,
    required this.onCategorySelected,
  }) : super(key: key);

  CategoryEntity? findParentCategory(List<CategoryEntity> categories, CategoryEntity childCategory) {
    if (childCategory.parentId == null) return null;
    return categories.firstWhere(
      (c) => c.id == childCategory.parentId,
      orElse: () => childCategory,
    );
  }

  List<MapEntry<CategoryEntity, List<CategoryEntity>>> getGroupedCategories() {
    final parentCategories = categories
        .where((c) => c.parentId == null && c.type == transactionType)
        .toList();

    final groupedCategories = parentCategories.map((parent) {
      final children = categories
          .where((c) => c.parentId == parent.id && c.type == transactionType)
          .toList();
      return MapEntry(parent, children);
    }).where((group) => group.value.isNotEmpty).toList();

    return groupedCategories;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final translations = context.watch<LanguageManager>().translations;
    final groupedCategories = getGroupedCategories();
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.viewInsets.bottom + mediaQuery.padding.bottom;
    final screenHeight = mediaQuery.size.height;

    return Container(
      constraints: BoxConstraints(
        maxHeight: screenHeight * 0.7, // Limitamos al 70% de la altura
      ),
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: bottomPadding + 16,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barra de arrastre
          Center(
            child: Container(
              width: 32,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(
            translations.selectCategory,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: groupedCategories.length,
              itemBuilder: (context, index) {
                final parentCategory = groupedCategories[index].key;
                final childCategories = groupedCategories[index].value;

                return ExpansionTile(
                  leading: Icon(
                    Icons.category_rounded,
                    color: colorScheme.primary,
                  ),
                  title: Text(
                    parentCategory.name,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  initiallyExpanded: false,
                  childrenPadding: EdgeInsets.zero,
                  children: childCategories.map((childCategory) {
                    return ListTile(
                      contentPadding: const EdgeInsets.only(left: 72, right: 16),
                      title: Text(childCategory.name),
                      onTap: () {
                        onCategorySelected(childCategory);
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
