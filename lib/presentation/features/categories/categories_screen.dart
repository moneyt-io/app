import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/usecases/category_usecases.dart';
import '../../core/atoms/app_button.dart';
import '../../core/molecules/empty_state.dart';
import '../../core/molecules/search_field.dart';
import '../../core/organisms/app_drawer.dart';
import '../../core/organisms/category_list_view.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/molecules/confirm_delete_dialog.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Category> _categories = [];
  bool _isLoading = true;
  String? _error;
  
  // Usar el caso de uso a través de GetIt
  late final CategoryUseCases _categoryUseCases;

  @override
  void initState() {
    super.initState();
    // Creamos el TabController con 2 pestañas
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    
    _categoryUseCases = GetIt.instance<CategoryUseCases>();
    _setupCategoriesStream();
  }
  
  void _setupCategoriesStream() {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    
    _categoryUseCases.getAllCategories().then((categories) {
      if (mounted) {
        setState(() {
          _categories = categories;
          _isLoading = false;
        });
      }
    }).catchError((e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _refreshCategories() async {
    try {
      final categories = await _categoryUseCases.getAllCategories();
      
      if (mounted) {
        setState(() {
          _categories = categories;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al actualizar: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _navigateToCategoryForm({Category? category}) async {
    final result = await NavigationService.navigateTo(
      AppRoutes.categoryForm,
      arguments: category,
    );
    
    if (result != null && result is Category) {
      _refreshCategories();
    }
  }

  Future<void> _deleteCategory(Category category) async {
    // Verificar si tiene subcategorías antes de eliminar
    final hasSubcategories = _categories.any((c) => c.parentId == category.id);
    
    if (hasSubcategories) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No se puede eliminar una categoría con subcategorías'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }
    
    // Confirmación para eliminar usando el nuevo diálogo reutilizable
    final confirmed = await ConfirmDeleteDialog.show(
      context: context,
      title: 'Eliminar categoría',
      message: '¿Estás seguro de eliminar',
      itemName: category.name,
      // Opciones personalizadas opcionales
      icon: Icons.category_outlined,
      confirmText: 'Confirmar eliminación',
    );
    
    if (confirmed == true) {
      try {
        await _categoryUseCases.deleteCategory(category.id);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Categoría eliminada con éxito'),
              backgroundColor: Colors.green,
            ),
          );
          
          _refreshCategories();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al eliminar categoría: $e'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }

  // Organiza las categorías en una estructura de árbol
  Map<Category, List<Category>> _buildCategoryTree(List<Category> categories) {
    final Map<Category, List<Category>> categoryTree = {};
    // Obtenemos las categorías principales (sin parentId)
    final rootCategories = categories.where((cat) => cat.parentId == null).toList();
    
    // Para cada categoría principal, encontramos sus hijos
    for (var rootCategory in rootCategories) {
      final children = categories
          .where((cat) => cat.parentId == rootCategory.id)
          .toList();
      categoryTree[rootCategory] = children;
    }
    
    return categoryTree;
  }

  List<Category> _getFilteredCategories() {
    // Invertimos la lógica: index 0 es Ingresos (I), index 1 es Gastos (E)
    final currentType = _tabController.index == 0 ? 'I' : 'E';
    
    return _categories.where((category) {
      final matchesType = category.documentTypeId == currentType;
      final matchesSearch = _searchQuery.isEmpty || 
          category.name.toLowerCase().contains(_searchQuery.toLowerCase());
      
      return matchesType && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final filteredCategories = _getFilteredCategories();
    final categoryTree = _buildCategoryTree(filteredCategories);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categorías',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Ingresos'),
            Tab(text: 'Gastos'),
          ],
          labelColor: colorScheme.primary,
          indicatorColor: colorScheme.primary,
          dividerColor: Colors.transparent,
        ),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Barra de búsqueda con diseño MD3
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.spacing16,
              vertical: AppDimensions.spacing12,
            ),
            child: SearchField(
              controller: _searchController,
              hintText: 'Buscar categorías',
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          
          // Contenido principal
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshCategories,
              color: colorScheme.primary,
              child: _isLoading
                  ? Center(child: CircularProgressIndicator(
                      color: colorScheme.primary,
                    ))
                  : _error != null
                      ? _buildErrorState()
                      : TabBarView(
                          controller: _tabController,
                          children: [
                            // Tab de ingresos
                            _buildCategoriesTab(categoryTree),
                            
                            // Tab de gastos
                            _buildCategoriesTab(categoryTree),
                          ],
                        ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCategoryForm(),
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        elevation: 3,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: AppDimensions.iconSizeXLarge,
            color: Theme.of(context).colorScheme.error,
          ),
          SizedBox(height: AppDimensions.spacing16),
          Text(
            'Error al cargar categorías',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: AppDimensions.spacing8),
          Text(_error ?? 'Error desconocido'),
          SizedBox(height: AppDimensions.spacing24),
          ElevatedButton(
            onPressed: _refreshCategories,
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab(Map<Category, List<Category>> categoryTree) {
    if (categoryTree.isEmpty) {
      return EmptyState(
        icon: Icons.category_outlined,
        title: 'No hay categorías',
        message: _searchQuery.isNotEmpty 
            ? 'No se encontraron categorías que coincidan con la búsqueda'
            : 'Crea tu primera categoría con el botón "+"',
        action: _searchQuery.isNotEmpty ? AppButton(
          text: 'Limpiar búsqueda',
          onPressed: () {
            _searchController.clear();
            setState(() {
              _searchQuery = '';
            });
          },
          type: AppButtonType.text,
        ) : null,
      );
    }

    return CategoryListView(
      categoryTree: categoryTree,
      onCategoryTap: (category) => _navigateToCategoryForm(category: category),
      onCategoryDelete: _deleteCategory,
    );
  }
}
