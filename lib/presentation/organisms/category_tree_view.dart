import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import '../molecules/category_list_item.dart';

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
  // Cambiamos a un mapa para manejar el estado de expansión por ID
  final Map<int, bool> _expandedState = {};
  
  @override
  Widget build(BuildContext context) {
    // Obtenemos las categorías principales ordenadas alfabéticamente
    final rootCategories = widget.categoryTree.keys.toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    
    if (rootCategories.isEmpty) {
      return const Center(child: Text('No hay categorías disponibles'));
    }

    return ListView.builder(
      // Agregamos physics para que funcione el pull-to-refresh
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: rootCategories.length,
      itemBuilder: (context, index) {
        final rootCategory = rootCategories[index];
        return _buildCategoryTreeItem(rootCategory, 0);
      },
    );
  }

  // Construye un ítem del árbol y sus hijos recursivamente, similar a ChartAccountTreeView
  Widget _buildCategoryTreeItem(Category category, int level) {
    // Encontrar los hijos de esta categoría
    final children = widget.categoryTree.keys
        .where((cat) => cat.id == category.id)
        .map((cat) => widget.categoryTree[cat] ?? [])
        .expand((item) => item)
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    
    final hasChildren = children.isNotEmpty;
    final isExpanded = _expandedState[category.id] ?? false;
    
    return Column(
      children: [
        // El ítem actual
        InkWell(
          onTap: hasChildren 
            ? () => setState(() => _expandedState[category.id] = !isExpanded)
            : null,
          child: Row(
            children: [
              SizedBox(width: level * 24.0), // Indentación por nivel
              if (hasChildren)
                IconButton(
                  icon: Icon(
                    isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                  ),
                  onPressed: () {
                    setState(() {
                      _expandedState[category.id] = !isExpanded;
                    });
                  },
                ),
              if (!hasChildren)
                const SizedBox(width: 40), // Espacio para alinear ítems sin hijos
              Expanded(
                child: CategoryListItem(
                  category: category,
                  onTap: () => widget.onCategoryTap(category),
                  onDelete: () => widget.onCategoryDelete(category),
                ),
              ),
            ],
          ),
        ),
        
        // Los hijos, si está expandido
        if (hasChildren && isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: children.map((child) => _buildCategoryTreeItem(child, level + 1)).toList(),
            ),
          ),
      ],
    );
  }
}
