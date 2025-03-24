import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/chart_account.dart';
import '../../domain/usecases/category_usecases.dart';
import '../atoms/app_button.dart';
import '../molecules/form_field_container.dart';
import '../routes/navigation_service.dart';

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
  
  String _selectedIcon = 'category';
  String _selectedType = 'E'; // E = Gastos (por defecto), I = Ingresos
  int? _selectedParentId;
  bool _isLoading = false;
  bool _isLoadingData = true;
  String? _error;
  
  List<Category> _parentCategories = [];
  ChartAccount? _linkedChartAccount;
  
  late final CategoryUseCases _categoryUseCases;
  
  bool get isEditing => widget.category != null;

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
          // Filtrar la categoría actual si estamos editando
          _parentCategories = isEditing
              ? categories.where((cat) => cat.id != widget.category!.id).toList()
              : categories;
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
                              decoration: const InputDecoration(
                                labelText: 'Nombre de categoría',
                                prefixIcon: Icon(Icons.label_outline),
                                border: InputBorder.none,
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
                              decoration: const InputDecoration(
                                labelText: 'Tipo',
                                prefixIcon: Icon(Icons.category_outlined),
                                border: InputBorder.none,
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'E',
                                  child: Text('Gasto'),
                                ),
                                DropdownMenuItem(
                                  value: 'I',
                                  child: Text('Ingreso'),
                                ),
                              ],
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
                          FormFieldContainer(
                            child: DropdownButtonFormField<int?>(
                              value: _selectedParentId,
                              decoration: InputDecoration(
                                labelText: 'Categoría Padre',
                                prefixIcon: Icon(
                                  Icons.account_tree_outlined, 
                                  color: colorScheme.primary
                                ),
                                border: InputBorder.none,
                              ),
                              items: [
                                const DropdownMenuItem(
                                  value: null,
                                  child: Text('Ninguna (Categoría Principal)'),
                                ),
                                ..._parentCategories.map((category) => DropdownMenuItem(
                                  value: category.id,
                                  child: Text(category.name),
                                )),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedParentId = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Mostrar cuenta contable vinculada (si existe)
                          if (isEditing && _linkedChartAccount != null) ...[
                            FormFieldContainer(
                              child: TextFormField(
                                initialValue: '${_linkedChartAccount!.code} - ${_linkedChartAccount!.name}',
                                decoration: const InputDecoration(
                                  labelText: 'Cuenta Contable Vinculada',
                                  prefixIcon: Icon(Icons.account_balance),
                                  border: InputBorder.none,
                                ),
                                enabled: false, // Campo de solo lectura
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                          
                          // Selector de icono
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
                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  _buildIconOption('food', Icons.restaurant, colorScheme),
                                  _buildIconOption('transport', Icons.directions_car, colorScheme),
                                  _buildIconOption('entertainment', Icons.movie, colorScheme),
                                  _buildIconOption('health', Icons.medical_services, colorScheme),
                                  _buildIconOption('salary', Icons.payments, colorScheme),
                                  _buildIconOption('investment', Icons.trending_up, colorScheme),
                                  _buildIconOption('shopping', Icons.shopping_bag, colorScheme),
                                  _buildIconOption('home', Icons.home, colorScheme),
                                  _buildIconOption('utilities', Icons.lightbulb, colorScheme),
                                  _buildIconOption('education', Icons.school, colorScheme),
                                  _buildIconOption('gift', Icons.card_giftcard, colorScheme),
                                  _buildIconOption('travel', Icons.flight, colorScheme),
                                ],
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

  Widget _buildIconOption(String iconName, IconData iconData, ColorScheme colorScheme) {
    final isSelected = _selectedIcon == iconName;
    final bgColor = isSelected
        ? (_selectedType == 'E' ? colorScheme.errorContainer : colorScheme.primaryContainer)
        : colorScheme.surfaceVariant;
    final iconColor = isSelected
        ? (_selectedType == 'E' ? colorScheme.onErrorContainer : colorScheme.onPrimaryContainer)
        : colorScheme.onSurfaceVariant;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedIcon = iconName;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? iconColor.withOpacity(0.5) : Colors.transparent,
              width: 2,
            ),
          ),
          child: Icon(
            iconData,
            color: iconColor,
            size: 24,
          ),
        ),
      ),
    );
  }
}
