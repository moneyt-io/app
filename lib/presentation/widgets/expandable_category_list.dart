// lib/presentation/widgets/expandable_category_list.dart
import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import 'list_item.dart';

class ExpandableCategoryList extends StatefulWidget {
  final List<CategoryEntity> categories;
  final Future<void> Function(CategoryEntity) onDelete;
  final Future<void> Function(CategoryEntity) onUpdate;

  const ExpandableCategoryList({
    Key? key,
    required this.categories,
    required this.onDelete,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<ExpandableCategoryList> createState() => _ExpandableCategoryListState();
}

class _ExpandableCategoryListState extends State<ExpandableCategoryList> {
  final Set<int> _expandedCategories = {};

  List<CategoryEntity> _getSubcategories(int parentId) {
    return widget.categories
        .where((category) => category.parentId == parentId)
        .toList();
  }

  Widget _buildCategoryTile(CategoryEntity category) {
    final subcategories = _getSubcategories(category.id);
    final hasSubcategories = subcategories.isNotEmpty;
    final isExpanded = _expandedCategories.contains(category.id);

    return Column(
      children: [
        ListItem<CategoryEntity>(
          item: category,
          onDelete: widget.onDelete,
          onUpdate: widget.onUpdate,
          leading: hasSubcategories
              ? IconButton(
                  icon: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey[600],
                  ),
                  onPressed: () {
                    setState(() {
                      if (isExpanded) {
                        _expandedCategories.remove(category.id);
                      } else {
                        _expandedCategories.add(category.id);
                      }
                    });
                  },
                )
              : const SizedBox(width: 48), // Mantener el alineamiento
        ),
        if (hasSubcategories && isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: subcategories
                  .map((subcategory) => ListItem<CategoryEntity>(
                        item: subcategory,
                        onDelete: widget.onDelete,
                        onUpdate: widget.onUpdate,
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mainCategories = widget.categories
        .where((category) => category.isMainCategory)
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    return ListView.builder(
      itemCount: mainCategories.length,
      itemBuilder: (context, index) => _buildCategoryTile(mainCategories[index]),
    );
  }
} 