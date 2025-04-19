import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/chart_account.dart';
import '../../../domain/usecases/category_usecases.dart';
import '../../atoms/app_button.dart';
import '../../molecules/form_field_container.dart';
import '../../molecules/icon_selector.dart';
import '../../routes/navigation_service.dart';
import '../../../core/presentation/app_dimensions.dart';

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
  
  String _selectedIcon = 'e88a'; // Código para Icons.home (por defecto)
  String _selectedType = 'I'; // I = Ingresos (por defecto), E = Gastos
  int? _selectedParentId;
  bool _isLoading = false;
  bool _isLoadingData = true;
  String? _error;
  
  List<Category> _parentCategories = [];
  ChartAccount? _linkedChartAccount;
  
  late final CategoryUseCases _categoryUseCases;
  
  bool get isEditing => widget.category != null;

  // El orden ya está correcto (primero Ingresos, luego Gastos)
  final List<Map<String, dynamic>> _documentTypes = [
    {'id': 'I', 'name': 'Ingreso', 'icon': Icons.arrow_upward},
    {'id': 'E', 'name': 'Gasto', 'icon': Icons.arrow_downward},
  ];

  @override
  void initState() {
    super.initState();
    _categoryUseCases = GetIt.instance<CategoryUseCases>();
    
    if (isEditing) {
      _nameController.text = widget.category!.name;
      _selectedIcon = widget.category!.icon;
      _selectedType = widget.category!.documentTypeId;
      _selectedParentId = widget.category!.parentId;
      _loadChartAccountInfo();
    }
    
    _loadParentCategories();
  }
  
  Future<void> _loadChartAccountInfo() async {
    if (isEditing && widget.category!.chartAccountId > 0) {
      try {
        final chartAccount = await _categoryUseCases.getCategoryChartAccount(widget.category!.chartAccountId);
        if (mounted) {
          setState(() {
            _linkedChartAccount = chartAccount;
          });
        }
      } catch (e) {
        // Silenciar errores al cargar la cuenta contable
      }
    }
  }
  
  Future<void> _loadParentCategories() async {
    try {
      setState(() {
        _isLoadingData = true;
      });
      
      // Obtener categorías del mismo tipo que podrían ser padres
      final categories = await _categoryUseCases.getCategoriesByType(_selectedType);
      
      if (mounted) {
        setState(() {
          // Filtrar la categoría actual si estamos editando y también solo mostrar categorías principales
          _parentCategories = isEditing
              ? categories
                  .where((cat) => cat.id != widget.category!.id)
                  .where((cat) => cat.parentId == null) // Solo categorías principales
                  .toList()
              : categories.where((cat) => cat.parentId == null).toList(); // Solo categorías principales
          _isLoadingData = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingData = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveCategory() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final now = DateTime.now();
      
      final category = Category(
        id: isEditing ? widget.category!.id : 0, 
        name: _nameController.text.trim(),
        icon: _selectedIcon,
        documentTypeId: _selectedType,
        parentId: _selectedParentId, // Ahora asignamos el padre seleccionado
        chartAccountId: isEditing ? widget.category!.chartAccountId : 0, 
        active: true,
        createdAt: isEditing ? widget.category!.createdAt : now,
        updatedAt: now, 
        deletedAt: null,
      );

      Category savedCategory;
      if (isEditing) {
        await _categoryUseCases.updateCategory(category);
        savedCategory = category;
      } else {
        savedCategory = await _categoryUseCases.createCategory(category);
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isEditing ? 'Categoría actualizada con éxito' : 'Categoría creada con éxito'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
        
        NavigationService.goBack(savedCategory);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar categoría' : 'Nueva categoría'),
        centerTitle: true,
      ),
      body: _isLoadingData
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Error (si existe)
                  if (_error != null) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: colorScheme.error,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _error!,
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onErrorContainer,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: colorScheme.onErrorContainer,
                            ),
                            onPressed: () => setState(() => _error = null),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  
                  // Tarjeta principal
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: colorScheme.outline.withOpacity(0.2),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Información de la categoría',
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // Nombre de categoría
                          FormFieldContainer(
                            child: TextFormField(
                              controller: _nameController,
                              decoration: FormFieldContainer.getOutlinedDecoration(
                                context,
                                labelText: 'Nombre de categoría',
                                prefixIcon: Icon(Icons.label_outline),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Ingrese un nombre para la categoría';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Selector de tipo (gasto/ingreso)
                          FormFieldContainer(
                            child: DropdownButtonFormField<String>(
                              value: _selectedType,
                              decoration: FormFieldContainer.getOutlinedDecoration(
                                context,
                                labelText: 'Tipo',
                                prefixIcon: Icon(Icons.category_outlined),
                              ),
                              items: _documentTypes.map((type) {
                                return DropdownMenuItem<String>(
                                  value: type['id'],
                                  child: Row(
                                    children: [
                                      Icon(
                                        type['icon'],
                                        color: type['id'] == 'E' ? Colors.red : Colors.green,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(type['name']),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: isEditing ? null : (value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedType = value;
                                    _selectedParentId = null; // Resetear parent al cambiar tipo
                                  });
                                  _loadParentCategories(); // Recargar categorías padre
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Selector de categoría padre
                          _buildParentCategorySelector(),
                          const SizedBox(height: 16),
                          
                          // Mostrar cuenta contable vinculada (si existe)
                          if (isEditing && _linkedChartAccount != null) ...[
                            FormFieldContainer(
                              child: TextFormField(
                                initialValue: '${_linkedChartAccount!.code} - ${_linkedChartAccount!.name}',
                                decoration: FormFieldContainer.getOutlinedDecoration(
                                  context,
                                  labelText: 'Cuenta Contable Vinculada',
                                  prefixIcon: Icon(Icons.account_balance),
                                ),
                                enabled: false, // Campo de solo lectura
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                          
                          // Selector de iconos (ahora usando el nuevo componente)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selecciona un icono:',
                                style: textTheme.titleSmall?.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 16),
                              
                              // Eliminamos cualquier contenedor adicional que pueda agregar padding
                              IconSelector(
                                selectedIconCode: _selectedIcon,
                                categoryType: _selectedType,
                                onIconSelected: (iconCode) {
                                  setState(() {
                                    _selectedIcon = iconCode;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).padding.bottom + 16,
          top: 16,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: AppButton(
          text: 'Guardar',
          onPressed: _isLoadingData || _isLoading ? null : _saveCategory,
          isLoading: _isLoading,
          type: AppButtonType.primary,
          isFullWidth: true,
        ),
      ),
    );
  }

  Widget _buildParentCategorySelector() {
    return FormFieldContainer(
      child: DropdownButtonFormField<int?>(
        value: _selectedParentId,
        decoration: FormFieldContainer.getOutlinedDecoration(
          context,
          labelText: 'Categoría Padre (Opcional)',
          prefixIcon: Icon(
            Icons.account_tree_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        items: [
          const DropdownMenuItem<int?>(
            value: null,
            child: Text('Ninguna (Categoría Principal)'),
          ),
          ..._parentCategories.map((category) {
            // Buscar el icono para esta categoría
            IconData iconData;
            try {
              iconData = IconData(
                int.parse(category.icon, radix: 16),
                fontFamily: 'MaterialIcons',
              );
            } catch (e) {
              iconData = Icons.category;
            }
            
            return DropdownMenuItem<int?>(
              value: category.id,
              child: Row(
                children: [
                  Icon(
                    iconData,
                    size: AppDimensions.iconSizeSmall,
                    color: category.documentTypeId == 'E' ? Colors.red : Colors.green,
                  ),
                  SizedBox(width: AppDimensions.spacing8),
                  Text(category.name),
                ],
              ),
            );
          }).toList(),
        ],
        onChanged: (value) {
          setState(() {
            _selectedParentId = value;
          });
        },
      ),
    );
  }
}
