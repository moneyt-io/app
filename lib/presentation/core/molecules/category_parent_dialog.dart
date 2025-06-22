import 'package:flutter/material.dart';
import '../../../domain/entities/category.dart';
import '../design_system/tokens/app_colors.dart';
import '../molecules/dialog_action_bar.dart';

/// Diálogo de selección de categoría padre basado en category_dialog_parent.html
/// 
/// HTML Reference:
/// ```html
/// <div class="flex flex-col items-stretch bg-white rounded-t-2xl shadow-lg max-h-[80vh]">
///   <button class="flex items-center gap-3 w-full px-4 py-3 hover:bg-slate-50">
/// ```
class CategoryParentDialog extends StatefulWidget {
  const CategoryParentDialog({
    Key? key,
    required this.availableCategories,
    required this.selectedParent,
    required this.documentTypeId,
  }) : super(key: key);

  final List<Category> availableCategories;
  final Category? selectedParent;
  final String documentTypeId;

  static Future<Category?> show({
    required BuildContext context,
    required List<Category> availableCategories,
    Category? selectedParent,
    required String documentTypeId,
  }) {
    return showModalBottomSheet<Category?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.3),
      isDismissible: true, // ✅ AGREGADO: Permitir cerrar tocando fuera
      enableDrag: true, // ✅ AGREGADO: Permitir cerrar arrastrando
      builder: (context) => CategoryParentDialog(
        availableCategories: availableCategories,
        selectedParent: selectedParent,
        documentTypeId: documentTypeId,
      ),
    );
  }

  @override
  State<CategoryParentDialog> createState() => _CategoryParentDialogState();
}

class _CategoryParentDialogState extends State<CategoryParentDialog> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  Category? _selectedParent;

  @override
  void initState() {
    super.initState();
    _selectedParent = widget.selectedParent;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Category> get _filteredCategories {
    final filtered = widget.availableCategories.where((category) {
      final matchesSearch = _searchQuery.isEmpty ||
          category.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesType = category.documentTypeId == widget.documentTypeId;
      final isParent = category.parentId == null;
      
      return matchesSearch && matchesType && isParent;
    }).toList();

    filtered.sort((a, b) => a.name.compareTo(b.name));
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // ✅ AGREGADO: Detectar taps fuera del contenido para cerrar
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Colors.transparent, // ✅ AGREGADO: Fondo transparente pero receptivo a taps
        child: GestureDetector(
          // ✅ AGREGADO: Prevenir que taps dentro del contenido cierren el diálogo
          onTap: () {}, // Absorbe los taps
          child: DraggableScrollableSheet(
            initialChildSize: 0.6, // ✅ CORREGIDO: Reducido de 0.8 a 0.6 (60% de altura)
            minChildSize: 0.4, // ✅ CORREGIDO: Reducido de 0.5 a 0.4 (40% mínimo)
            maxChildSize: 0.8, // ✅ CORREGIDO: Reducido de 0.9 a 0.8 (80% máximo)
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 10,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Handle bar
                    Container(
                      height: 24,
                      width: double.infinity,
                      child: Center(
                        child: Container(
                          height: 6,
                          width: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD1D5DB),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                    
                    // Header
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFF1F5F9),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Select parent category',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Choose a parent category or leave empty for root level',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Search
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFF1F5F9),
                          ),
                        ),
                      ),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Icon(
                                Icons.search,
                                color: Color(0xFF64748B),
                                size: 18,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: (value) {
                                  setState(() {
                                    _searchQuery = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Search categories',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF64748B),
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                  isDense: true,
                                ),
                                style: const TextStyle(
                                  color: Color(0xFF0F172A),
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                                textAlignVertical: TextAlignVertical.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Categories List
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        children: [
                          // No Parent Option
                          _buildCategoryOption(
                            icon: Icons.folder_open,
                            iconColor: const Color(0xFF64748B),
                            backgroundColor: const Color(0xFFF1F5F9),
                            title: 'No parent category',
                            subtitle: 'Create as a root category',
                            isSelected: _selectedParent == null,
                            onTap: () {
                              setState(() {
                                _selectedParent = null;
                              });
                            },
                          ),
                          
                          // Categories Section Header
                          if (_filteredCategories.isNotEmpty) ...[
                            Container(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                              color: const Color(0xFFF8FAFC),
                              child: Text(
                                widget.documentTypeId == 'I' ? 'Income Categories' : 'Expense Categories',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF475569),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            
                            // Available Categories
                            ..._filteredCategories.map((category) {
                              return _buildCategoryOption(
                                icon: _getCategoryIcon(category),
                                iconColor: _getCategoryColor(category),
                                backgroundColor: _getCategoryColor(category).withOpacity(0.1),
                                title: category.name,
                                subtitle: '${widget.documentTypeId == 'I' ? 'Income' : 'Expense'} • ${_getSubcategoryCount(category)} subcategories',
                                isSelected: _selectedParent?.id == category.id,
                                onTap: () {
                                  setState(() {
                                    _selectedParent = category;
                                  });
                                },
                              );
                            }),
                          ],
                        ],
                      ),
                    ),
                    
                    // Footer usando DialogActionBar
                    DialogActionBar(
                      onCancel: () => Navigator.of(context).pop(),
                      onConfirm: () => Navigator.of(context).pop(_selectedParent),
                      cancelText: 'Cancel',
                      confirmText: 'Select',
                      isLoading: false,
                      enabled: true,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryOption({
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFF1F5F9),
              ),
            ),
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
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
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Selection indicator
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: isSelected 
                        ? const Color(0xFF0c7ff2)
                        : const Color(0xFFD1D5DB),
                  ),
                  color: isSelected 
                      ? const Color(0xFF0c7ff2)
                      : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 14,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(Category category) {
    switch (category.name.toLowerCase()) {
      case 'salary':
        return Icons.work;
      case 'business':
        return Icons.business;
      case 'investment':
        return Icons.trending_up;
      default:
        return Icons.category;
    }
  }

  Color _getCategoryColor(Category category) {
    if (category.documentTypeId == 'I') {
      return const Color(0xFF22C55E);
    } else {
      return const Color(0xFFEF4444);
    }
  }

  String _getSubcategoryCount(Category category) {
    final subcategories = widget.availableCategories
        .where((cat) => cat.parentId == category.id)
        .length;
    return subcategories.toString();
  }
}