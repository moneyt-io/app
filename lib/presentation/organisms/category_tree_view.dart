import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import '../molecules/category_list_item.dart';
import '../../core/presentation/app_dimensions.dart';

/// Organismo que muestra una vista jerárquica de categorías.
///
/// Este componente organiza las categorías en una estructura de árbol,
/// mostrando las relaciones padre-hijo.
class CategoryTreeView extends StatefulWidget {
  final Map<Category, List<Category>> categoryTree;
  final Function(Category) onCategoryTap;
  final Function(Category) onCategoryDelete;
  
  const CategoryTreeView({
    Key? key,
    required this.categoryTree,
    required this.onCategoryTap,
    required this.onCategoryDelete,
  }) : super(key: key);

  @override
  State<CategoryTreeView> createState() => _CategoryTreeViewState();
}

class _CategoryTreeViewState extends State<CategoryTreeView> {
  // Set para mantener el seguimiento de qué categorías están expandidas
  final Set<int> _expandedCategories = {};

  @override
  void initState() {
    super.initState();
    // Por defecto, todas las categorías están expandidas al inicio
    for (final category in widget.categoryTree.keys) {
      if (widget.categoryTree[category]?.isNotEmpty ?? false) {
        _expandedCategories.add(category.id);
      }
    }
  }

  // Alternar el estado expandido/colapsado de una categoría
  void _toggleExpanded(Category category) {
    setState(() {
      if (_expandedCategories.contains(category.id)) {
        _expandedCategories.remove(category.id);
      } else {
        _expandedCategories.add(category.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final rootCategories = widget.categoryTree.keys.toList();
    
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.spacing16),
      itemCount: rootCategories.length,
      itemBuilder: (context, index) {
        final rootCategory = rootCategories[index];
        final children = widget.categoryTree[rootCategory] ?? [];
        
        return _buildCategoryWithChildren(
          context, 
          rootCategory, 
          children,
        );
      },
    );
  }
  
  Widget _buildCategoryWithChildren(
    BuildContext context, 
    Category category, 
    List<Category> children,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final isExpanded = _expandedCategories.contains(category.id);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Categoría principal
        CategoryListItem(
          category: category,
          onTap: () => widget.onCategoryTap(category),
          onDelete: () => widget.onCategoryDelete(category),
          trailing: children.isNotEmpty 
              ? IconButton(
                  icon: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: colorScheme.onSurfaceVariant,
                    size: AppDimensions.iconSizeMedium,
                  ),
                  onPressed: () => _toggleExpanded(category),
                )
              : null,
        ),
        
        // Subcategorías (con indentación) - solo mostrar si está expandida
        if (children.isNotEmpty && isExpanded)
          Padding(
            padding: const EdgeInsets.only(
              left: AppDimensions.spacing32,
            ),
            child: Column(
              children: children.map((child) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: AppDimensions.spacing8,
                  ),
                  child: CategoryListItem(
                    category: child,
                    onTap: () => widget.onCategoryTap(child),
                    onDelete: () => widget.onCategoryDelete(child),
                  ),
                );
              }).toList(),
            ),
          ),
          
        // Espacio entre grupos de categorías
        SizedBox(height: AppDimensions.spacing16),
      ],
    );
  }
}
