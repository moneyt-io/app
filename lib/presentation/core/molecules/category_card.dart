import 'package:flutter/material.dart';
import '../../../domain/entities/category.dart';
import '../molecules/category_options_dialog.dart';

/// Tarjeta de categoría expandible basada en category_list.html
/// 
/// HTML Reference:
/// ```html
/// <div class="bg-white rounded-xl shadow-sm border border-slate-200 mb-3 overflow-hidden">
///   <button class="flex items-center gap-3 w-full text-left p-4 hover:bg-slate-50">
/// ```
class CategoryCard extends StatefulWidget { // ✅ CORREGIDO: Cambiar a StatefulWidget
  const CategoryCard({
    Key? key,
    required this.category,
    required this.subcategories,
    this.onCategoryTap,
    this.onSubcategoryTap,
    this.isExpanded = false, // ✅ AGREGADO: Parámetro faltante
  }) : super(key: key);

  final Category category;
  final List<Category> subcategories;
  final VoidCallback? onCategoryTap;
  final ValueChanged<Category>? onSubcategoryTap;
  final bool isExpanded; // ✅ AGREGADO: Propiedad faltante

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    if (_isExpanded) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header de la categoría principal
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _toggleExpansion,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Ícono de expansión
                    Icon(
                      _isExpanded ? Icons.expand_more : Icons.chevron_right,
                      color: const Color(0xFF64748B),
                      size: 18,
                    ),
                    
                    const SizedBox(width: 12),
                    
                    // Información de la categoría
                    Expanded(
                      child: _buildCategoryRow(
                        category: widget.category,
                        isSubcategory: false,
                        onTap: widget.onCategoryTap,
                        context: context,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Subcategorías (si están expandidas y existen)
          if (_isExpanded && widget.subcategories.isNotEmpty)
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFF1F5F9)),
                ),
              ),
              child: Column(
                children: widget.subcategories.map((subcategory) {
                  return _buildCategoryRow(
                    category: subcategory,
                    isSubcategory: true,
                    onTap: () => widget.onSubcategoryTap?.call(subcategory),
                    context: context,
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoryRow({
    required Category category,
    required bool isSubcategory,
    required BuildContext context, // ✅ AGREGADO: Recibir context
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.fromLTRB(
            isSubcategory ? 32 : 16, // HTML: pl-8 para subcategorías
            12,
            16,
            12,
          ),
          decoration: BoxDecoration(
            border: isSubcategory ? const Border(
              bottom: BorderSide(
                color: Color(0xFFF1F5F9), // HTML: border-slate-100
              ),
            ) : null,
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getIconBackgroundColor(category),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getIconData(category),
                  color: _getIconColor(category),
                  size: 20,
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      _getSubtitle(category),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              
              // More button
              SizedBox(
                width: 40,
                height: 40,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _showCategoryOptions(context, category), // ✅ CORREGIDO: Usar método interno
                    borderRadius: BorderRadius.circular(20),
                    child: const Center(
                      child: Icon(
                        Icons.more_vert,
                        color: Color(0xFF64748B),
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCategoryOptions(BuildContext context, Category category) { // ✅ CORREGIDO: Recibir context
    CategoryOptionsDialog.show(
      context: context,
      category: category,
      onOptionSelected: (option) => _handleCategoryOption(context, category, option),
    );
  }

  void _handleCategoryOption(BuildContext context, Category category, CategoryOption option) { // ✅ CORREGIDO: Recibir context
    switch (option) {
      case CategoryOption.edit:
        widget.onCategoryTap?.call(); // Usar el callback existente para editar
        break;
      case CategoryOption.duplicate:
        _duplicateCategory(category);
        break;
      case CategoryOption.viewTransactions:
        _viewTransactions(category);
        break;
      case CategoryOption.delete:
        _deleteCategory(category);
        break;
    }
  }
  // ✅ AGREGADO: Métodos placeholder para las opciones
  void _duplicateCategory(Category category) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Duplicating ${category.name}'),
        backgroundColor: const Color(0xFF0c7ff2),
      ),
    );
  }

  void _viewTransactions(Category category) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing transactions for ${category.name}'),
        backgroundColor: const Color(0xFF0c7ff2),
      ),
    );
  }

  void _deleteCategory(Category category) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Delete ${category.name} - confirmation needed'),
        backgroundColor: Colors.red,
      ),
    );
  }

  Color _getCategoryColor(Category category) {
    // Mapeo de colores basado en el HTML
    switch (category.name.toLowerCase()) {
      case 'salary':
        return const Color(0xFF3B82F6); // blue
      case 'business':
        return const Color(0xFFF97316); // orange
      case 'freelance':
        return const Color(0xFF14B8A6); // teal
      case 'investments':
        return const Color(0xFF6366F1); // indigo
      default:
        return const Color(0xFF64748B); // slate
    }
  }

  IconData _getCategoryIcon(Category category) {
    // Mapeo de íconos basado en el HTML
    switch (category.name.toLowerCase()) {
      case 'salary':
        return Icons.work;
      case 'business':
        return Icons.business;
      case 'freelance':
        return Icons.laptop_mac;
      case 'investments':
        return Icons.trending_up;
      default:
        return Icons.category;
    }
  }

  Color _getIconBackgroundColor(Category category) {
    // Color de fondo del ícono (subcategoría)
    return _getCategoryColor(category).withOpacity(0.1);
  }

  Color _getIconColor(Category category) {
    // Color del ícono
    return _getCategoryColor(category);
  }

  IconData _getIconData(Category category) {
    // Ícono para la categoría o subcategoría
    return _getCategoryIcon(category);
  }

  String _getSubtitle(Category category) {
    // Subtítulo para la categoría o subcategoría
    return category.documentTypeId == 'I' ? 'Income category' : 'Expense category';
  }
}

