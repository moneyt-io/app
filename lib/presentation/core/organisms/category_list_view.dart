import 'package:flutter/material.dart';
import '../../../domain/entities/category.dart';
import '../theme/app_dimensions.dart';
import '../molecules/confirm_delete_dialog.dart';

/// Organismo que muestra una lista jerárquica de categorías con Material Design 3.
///
/// Implementa categorías colapsables con animaciones suaves y metricas adecuadas.
class CategoryListView extends StatefulWidget {
  final Map<Category, List<Category>> categoryTree;
  final Function(Category) onCategoryTap;
  final Function(Category) onCategoryDelete;
  
  const CategoryListView({
    Key? key,
    required this.categoryTree,
    required this.onCategoryTap,
    required this.onCategoryDelete,
  }) : super(key: key);

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  // Por defecto, todas las categorías están colapsadas
  final Set<int> _expandedCategories = {};

  // Método para mostrar confirmación al eliminar
  Future<void> _confirmDelete(BuildContext context, Category category) async {
    final result = await ConfirmDeleteDialog.show(
      context: context,
      title: 'Eliminar ${category.parentId == null ? 'categoría' : 'subcategoría'}',
      message: '¿Estás seguro de que deseas eliminar',
      itemName: category.name,
      isDestructive: true,
    );
    
    // Si el usuario confirmó, eliminar la categoría
    if (result == true) {
      widget.onCategoryDelete(category);
    }
  }

  @override
  Widget build(BuildContext context) {
    final rootCategories = widget.categoryTree.keys.toList();
    
    return ListView.builder(
      // Reducir el padding vertical
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing16,
        vertical: AppDimensions.spacing4,
      ),
      itemCount: rootCategories.length,
      itemBuilder: (context, index) {
        final rootCategory = rootCategories[index];
        final children = widget.categoryTree[rootCategory] ?? [];
        
        return _buildCategoryItem(rootCategory, children);
      },
    );
  }
  
  Widget _buildCategoryItem(Category category, List<Category> children) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final hasChildren = children.isNotEmpty;
    final isExpanded = _expandedCategories.contains(category.id);
    
    // Obtener el IconData para la categoría
    IconData categoryIcon;
    try {
      categoryIcon = IconData(
        int.parse(category.icon, radix: 16),
        fontFamily: 'MaterialIcons',
      );
    } catch (e) {
      categoryIcon = Icons.category;
    }
    
    // Determinar colores según el tipo de categoría (ingreso o gasto)
    final isExpense = category.documentTypeId == 'E';
    final containerColor = isExpense 
      ? colorScheme.errorContainer.withOpacity(0.12) 
      : colorScheme.primaryContainer.withOpacity(0.12);
    final iconColor = isExpense
      ? colorScheme.error
      : colorScheme.primary;
    
    return Card(
      // Reducir el margen inferior de las tarjetas
      elevation: 0,
      margin: EdgeInsets.only(bottom: AppDimensions.spacing8),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Column(
        children: [
          // Categoría principal con padding reducido - Ahora sin onTap
          Material(
            color: Colors.transparent,
            child: InkWell(
              // Eliminamos la navegación al tocar
              onTap: null, // Deshabilitamos la edición al tocar
              child: Padding(
                // Reducir el padding del ítem principal
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacing16,
                  vertical: AppDimensions.spacing12,
                ),
                child: Row(
                  children: [
                    // Contenedor del icono siguiendo Material Design 3
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: containerColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        categoryIcon,
                        size: AppDimensions.iconSizeMedium,
                        color: iconColor,
                      ),
                    ),
                    SizedBox(width: AppDimensions.spacing16),
                    
                    // Título de la categoría
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
                          
                          if (hasChildren)
                            Text(
                              '${children.length} subcategoría${children.length > 1 ? 's' : ''}',
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                        ],
                      ),
                    ),
                    
                    // Reemplazar el botón eliminar por un menú de opciones
                    PopupMenuButton<String>(
                      icon: Icon(
                        Icons.more_vert,
                        color: colorScheme.onSurfaceVariant,
                        size: AppDimensions.iconSizeMedium,
                      ),
                      onSelected: (value) {
                        if (value == 'delete') {
                          _confirmDelete(context, category);
                        } else if (value == 'edit') {
                          widget.onCategoryTap(category);
                        }
                        // Aquí puedes agregar más opciones según sea necesario
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem<String>(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: colorScheme.primary),
                              SizedBox(width: AppDimensions.spacing8),
                              Text('Editar'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline, color: colorScheme.error),
                              SizedBox(width: AppDimensions.spacing8),
                              Text('Eliminar'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    // Botón expandir/colapsar (solo si tiene hijos)
                    if (hasChildren)
                      IconButton(
                        icon: AnimatedRotation(
                          turns: isExpanded ? 0.5 : 0.0,
                          duration: Duration(milliseconds: 200),
                          child: Icon(
                            Icons.expand_more,
                            color: colorScheme.onSurfaceVariant,
                          ),
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
                        tooltip: isExpanded ? 'Colapsar' : 'Expandir',
                      ),
                  ],
                ),
              ),
            ),
          ),
          
          // Sección de subcategorías con animación - CORREGIDA
          if (hasChildren)
            AnimatedContainer(
              duration: Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              // Corregimos el problema con la altura
              height: isExpanded ? _calculateExpandedHeight(children) : 0,
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant.withOpacity(0.15),
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outlineVariant.withOpacity(0.5),
                    width: 1,
                  ),
                ),
              ),
              child: isExpanded 
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    // Reducir el padding superior e inferior
                    padding: EdgeInsets.only(
                      top: AppDimensions.spacing4,
                      bottom: AppDimensions.spacing8,
                    ),
                    itemCount: children.length,
                    itemBuilder: (context, index) {
                      final child = children[index];
                      return _buildSubcategoryItem(child);
                    },
                  )
                : null,
            ),
        ],
      ),
    );
  }
  
  // Método para calcular la altura de la sección expandida - MÁS COMPACTO
  double _calculateExpandedHeight(List<Category> children) {
    // Reducir la altura por ítem para hacerlo más compacto
    final double itemHeight = 50.0; 
    
    // Padding superior e inferior reducido
    final double verticalPadding = AppDimensions.spacing4 + AppDimensions.spacing8;
    
    // Margen adicional más pequeño
    final double safetyMargin = 10.0;
    
    // Altura total = altura de cada ítem * número de ítems + padding + margen de seguridad
    return (itemHeight * children.length) + verticalPadding + safetyMargin;
  }
  
  Widget _buildSubcategoryItem(Category subcategory) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    // Obtener el IconData para la subcategoría
    IconData subcategoryIcon;
    try {
      subcategoryIcon = IconData(
        int.parse(subcategory.icon, radix: 16),
        fontFamily: 'MaterialIcons',
      );
    } catch (e) {
      subcategoryIcon = Icons.label;
    }
    
    // Determinar colores según el tipo de categoría
    final isExpense = subcategory.documentTypeId == 'E';
    final containerColor = isExpense 
      ? colorScheme.errorContainer.withOpacity(0.1)
      : colorScheme.primaryContainer.withOpacity(0.1);
    final iconColor = isExpense
      ? colorScheme.error
      : colorScheme.primary;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        // Eliminamos la navegación al tocar
        onTap: null, // Deshabilitamos la edición al tocar
        child: Padding(
          // Reducir el padding vertical para subcategorías
          padding: EdgeInsets.fromLTRB(
            AppDimensions.spacing24,  // Indentación para subcategorías
            AppDimensions.spacing4,
            AppDimensions.spacing16,
            AppDimensions.spacing4,
          ),
          child: Row(
            children: [
              // Contenedor del icono
              Container(
                width: 32,  // Más pequeño para subcategorías
                height: 32,
                decoration: BoxDecoration(
                  color: containerColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  subcategoryIcon,
                  size: AppDimensions.iconSizeSmall,
                  color: iconColor,
                ),
              ),
              SizedBox(width: AppDimensions.spacing16),
              
              // Título de la subcategoría
              Expanded(
                child: Text(
                  subcategory.name,
                  style: textTheme.bodyLarge,
                ),
              ),
              
              // Reemplazar el botón eliminar por un menú de opciones
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  color: colorScheme.onSurfaceVariant,
                  size: AppDimensions.iconSizeSmall,
                ),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
                onSelected: (value) {
                  if (value == 'delete') {
                    _confirmDelete(context, subcategory);
                  } else if (value == 'edit') {
                    widget.onCategoryTap(subcategory);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: colorScheme.primary),
                        SizedBox(width: AppDimensions.spacing8),
                        Text('Editar'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, color: colorScheme.error),
                        SizedBox(width: AppDimensions.spacing8),
                        Text('Eliminar'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
