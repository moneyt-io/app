import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/category_usecases.dart';
import '../atoms/app_button.dart';
import '../molecules/empty_state.dart';
import '../molecules/search_field.dart';
import '../organisms/app_drawer.dart';
import '../organisms/category_tree_view.dart'; // Nueva importación
import '../routes/navigation_service.dart';
import '../routes/app_routes.dart';

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
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    
    _categoryUseCases = GetIt.instance<CategoryUseCases>();
    // En lugar de llamar a _loadCategories, vamos a suscribirnos al stream
    _setupCategoriesStream();
  }
  
  void _setupCategoriesStream() {
    // Primero marcamos como cargando
    setState(() {
      _isLoading = true;
      _error = null;
    });
    
    // Este es un método temporal para cargar los datos iniciales y luego configurar el stream
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

  // Este método ahora solo se usa para refrescar manualmente (pull-to-refresh)
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
      _refreshCategories(); // Recargar categorías después de crear/editar
    }
  }

  void _deleteCategory(Category category) async {
    // Verificar si tiene subcategorías antes de eliminar
    final hasSubcategories = _categories.any((c) => c.parentId == category.id);
    
    if (hasSubcategories) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('No se puede eliminar. La categoría tiene subcategorías.'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
      return;
    }
    
    // Mostrar diálogo de confirmación
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar categoría'),
        content: Text('¿Estás seguro de eliminar la categoría ${category.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await _categoryUseCases.deleteCategory(category.id);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Categoría eliminada con éxito'),
              backgroundColor: Colors.green,
            ),
          );
          
          _refreshCategories(); // Recargar categorías después de eliminar
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
    final currentType = _tabController.index == 0 ? 'E' : 'I'; // E = Gastos, I = Ingresos
    
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
    final filteredCategories = _getFilteredCategories();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías'),
        centerTitle: true,
        elevation: 0,
        // Eliminamos el botón de actualizar
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Gastos'),
            Tab(text: 'Ingresos'),
          ],
          labelColor: colorScheme.primary,
          indicatorColor: colorScheme.primary,
          dividerColor: Colors.transparent,
        ),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
          Expanded(
            // Corregimos el RefreshIndicator
            child: RefreshIndicator(
              onRefresh: _refreshCategories,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                      ? _buildErrorState()
                      : TabBarView(
                          controller: _tabController,
                          children: [
                            // Tab de gastos - Ahora con vista de árbol
                            _buildCategoriesTree(filteredCategories),
                            // Tab de ingresos - Ahora con vista de árbol
                            _buildCategoriesTree(filteredCategories),
                          ],
                        ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCategoryForm(),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 2,
        child: const Icon(Icons.add),
      ),
    );
  }
  
  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          const Text('Error al cargar las categorías'),
          const SizedBox(height: 8),
          Text(_error ?? 'Error desconocido'),
          const SizedBox(height: 16),
          AppButton(
            text: 'Reintentar',
            onPressed: _refreshCategories,
            type: AppButtonType.primary,
          ),
        ],
      ),
    );
  }

  // Nuevo método para construir la vista de árbol de categorías
  Widget _buildCategoriesTree(List<Category> categories) {
    if (categories.isEmpty) {
      return EmptyState(
        icon: Icons.category_outlined,
        title: 'No hay categorías',
        message: _searchQuery.isEmpty 
          ? 'Crea una nueva categoría utilizando el botón "+"'
          : 'No se encontraron categorías con tu búsqueda',
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

    // Construimos el árbol de categorías
    final categoryTree = _buildCategoryTree(categories);
    
    // Usamos el nuevo widget para visualizar el árbol
    return CategoryTreeView(
      categoryTree: categoryTree,
      // Corregir el error usando una función anónima de adaptación:
      onCategoryTap: (category) => _navigateToCategoryForm(category: category),
      onCategoryDelete: _deleteCategory,
    );
  }
}
