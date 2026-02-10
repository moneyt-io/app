import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/usecases/category_usecases.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/atoms/app_floating_label_field.dart';
import '../../core/atoms/app_switch.dart';
import '../../core/molecules/form_action_bar.dart';
import '../../core/molecules/category_icon_picker.dart';
import '../../core/molecules/category_color_picker.dart';
import '../../core/molecules/category_type_filter.dart';
import '../../core/molecules/category_parent_dialog.dart'; // ✅ AGREGADO: Import del diálogo
import '../../core/l10n/generated/strings.g.dart';

class CategoryFormScreen extends StatefulWidget {
  final Category? category;

  const CategoryFormScreen({
    Key? key,
    this.category,
  }) : super(key: key);

  @override
  State<CategoryFormScreen> createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  
  late final CategoryUseCases _categoryUseCases;
  
  String _selectedType = 'I'; // 'I' para Income, 'E' para Expense
  IconData _selectedIcon = Icons.category;
  Color _selectedColor = const Color(0xFF3B82F6);
  bool _isActive = true;
  bool _isLoading = false;
  
  List<Category> _parentCategories = [];
  Category? _selectedParent;

  bool get _isEditing => widget.category != null;

  @override
  void initState() {
    super.initState();
    _categoryUseCases = GetIt.instance<CategoryUseCases>();
    _loadParentCategories();
    _loadCategoryData();
  }

  void _loadCategoryData() {
    if (_isEditing) {
      final category = widget.category!;
      _nameController.text = category.name;
      _selectedType = category.documentTypeId;
      _isActive = category.active;
      // TODO: Cargar ícono y color desde category cuando se agreguen estos campos
    }
  }

  Future<void> _loadParentCategories() async {
    try {
      final categories = await _categoryUseCases.getAllCategories();
      setState(() {
        _parentCategories = categories.where((cat) => 
          cat.parentId == null && cat.documentTypeId == _selectedType
        ).toList();
      });
    } catch (e) {
      debugPrint('Error loading parent categories: $e');
    }
  }

  // ✅ AGREGADO: Método para mostrar diálogo de selección de padre
  Future<void> _showParentDialog() async {
    final allCategories = await _categoryUseCases.getAllCategories();
    
    final selectedParent = await CategoryParentDialog.show(
      context: context,
      availableCategories: allCategories,
      selectedParent: _selectedParent,
      documentTypeId: _selectedType,
    );
    
    if (selectedParent != _selectedParent) {
      setState(() {
        _selectedParent = selectedParent;
      });
    }
  }

  String? _validateName(String? value) {
    if (value?.trim().isEmpty == true) {
      return t.categories.form.nameRequired;
    }
    return null;
  }

  Future<void> _saveCategory() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final category = Category(
        id: _isEditing ? widget.category!.id : 0,
        name: _nameController.text.trim(),
        documentTypeId: _selectedType,
        parentId: _selectedParent?.id,
        chartAccountId: _isEditing ? widget.category!.chartAccountId : 0, // ✅ CORREGIDO: Usar 0 en lugar de null
        icon: _selectedIcon.codePoint.toString(),
        active: _isActive,
        createdAt: _isEditing ? widget.category!.createdAt : DateTime.now(),
        updatedAt: DateTime.now(),
        deletedAt: null,
      );

      if (_isEditing) {
        await _categoryUseCases.updateCategory(category);
      } else {
        await _categoryUseCases.createCategory(category);
      }

      if (mounted) {
        Navigator.of(context).pop(category);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.categories.form.saveError(error: e)),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      
      appBar: AppAppBar(
        title: _isEditing ? t.categories.form.editTitle : t.categories.form.newTitle,
        type: AppAppBarType.blur,
        leading: AppAppBarLeading.close,
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      
      body: Column(
        children: [
          // ✅ CORREGIDO: CategoryTypeFilter atomizado con consistencia visual
          Padding(
            padding: const EdgeInsets.all(16),
            child: CategoryTypeFilter(
              selectedType: _selectedType,
              onTypeChanged: (type) {
                setState(() {
                  _selectedType = type;
                  _selectedParent = null;
                });
                _loadParentCategories();
              },
            ),
          ),
          
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Name
                    AppFloatingLabelField(
                      controller: _nameController,
                      label: t.categories.form.name,
                      placeholder: t.categories.form.namePlaceholder,
                      validator: _validateName,
                      textCapitalization: TextCapitalization.words,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Parent Category Selector
                    Text(
                      t.categories.form.parent,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF374151),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _showParentDialog,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                          ),
                          child: Row(
                            children: [
                              // Icon
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: _selectedParent != null
                                      ? _getCategoryColor(_selectedParent!).withOpacity(0.1)
                                      : const Color(0xFFF1F5F9),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _selectedParent != null
                                      ? _getCategoryIcon(_selectedParent!)
                                      : Icons.folder_open,
                                  color: _selectedParent != null
                                      ? _getCategoryColor(_selectedParent!)
                                      : const Color(0xFF64748B),
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
                                      _selectedParent?.name ?? t.categories.form.noParent,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF1E293B),
                                      ),
                                    ),
                                    Text(
                                      _selectedParent != null 
                                          ? t.categories.form.asSubcategory
                                          : t.categories.form.asRoot,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Arrow
                              const Icon(
                                Icons.chevron_right,
                                color: Color(0xFF9CA3AF),
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Icon Picker
                    CategoryIconPicker(
                      selectedIcon: _selectedIcon,
                      selectedColor: _selectedColor,
                      onIconSelected: (icon) {
                        setState(() {
                          _selectedIcon = icon;
                        });
                      },
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Color Picker
                    CategoryColorPicker(
                      selectedColor: _selectedColor,
                      onColorSelected: (color) {
                        setState(() {
                          _selectedColor = color;
                        });
                      },
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Active Switch
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                t.categories.form.active,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF111827),
                                ),
                              ),
                              Text(
                                t.categories.form.activeDescription,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                          AppSwitch(
                            value: _isActive,
                            onChanged: (value) {
                              setState(() {
                                _isActive = value;
                              });
                            },
                            // ✅ MANTENIDO: Color fijo del sistema (corrección anterior)
                            activeColor: const Color(0xFF0c7ff2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Footer con FormActionBar
          FormActionBar(
            onCancel: () => Navigator.of(context).pop(),
            onSave: _saveCategory,
            isLoading: _isLoading,
            enabled: !_isLoading,
          ),
        ],
      ),
    );
  }

  // ✅ AGREGADO: Métodos helper para íconos y colores
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
      return const Color(0xFF22C55E); // green para income
    } else {
      return const Color(0xFFEF4444); // red para expense
    }
  }
}

