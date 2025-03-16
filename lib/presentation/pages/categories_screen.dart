import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import '../atoms/app_button.dart';
import '../molecules/empty_state.dart';
import '../molecules/search_field.dart';
import '../molecules/category_list_item.dart';
import '../organisms/app_drawer.dart';
import '../routes/navigation_service.dart';
import '../routes/app_routes.dart';

// Datos simulados para categorías
final mockCategories = [
  Category(
    id: 1, 
    name: 'Alimentación', 
    icon: 'food', 
    parentId: null, 
    documentTypeId: 'E',
    active: true, 
    createdAt: DateTime.now(), 
    chartAccountId: 1,
  ),
  Category(
    id: 2, 
    name: 'Transporte', 
    icon: 'transport', 
    parentId: null, 
    documentTypeId: 'E',
    active: true, 
    createdAt: DateTime.now(),
    chartAccountId: 1,
  ),
  Category(
    id: 3, 
    name: 'Entretenimiento', 
    icon: 'entertainment', 
    parentId: null, 
    documentTypeId: 'E',
    active: true, 
    createdAt: DateTime.now(),
    chartAccountId: 1,
  ),
  Category(
    id: 4, 
    name: 'Salud', 
    icon: 'health', 
    parentId: null, 
    documentTypeId: 'E',
    active: true, 
    createdAt: DateTime.now(),
    chartAccountId: 1,
  ),
  Category(
    id: 5, 
    name: 'Salario', 
    icon: 'salary', 
    parentId: null, 
    documentTypeId: 'I',
    active: true, 
    createdAt: DateTime.now(),
    chartAccountId: 1,
  ),
  Category(
    id: 6, 
    name: 'Inversiones', 
    icon: 'investment', 
    parentId: null, 
    documentTypeId: 'I',
    active: true, 
    createdAt: DateTime.now(),
    chartAccountId: 1,
  ),
];

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Category> _categories = [...mockCategories];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
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
      setState(() {
        if (category != null) {
          // Edición de categoría existente
          final index = _categories.indexWhere((c) => c.id == category.id);
          if (index >= 0) {
            _categories[index] = result;
          }
        } else {
          // Nueva categoría
          _categories.add(result);
        }
      });
    }
  }

  void _deleteCategory(Category category) async {
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

    if (confirmed == true) {
      setState(() {
        _categories.removeWhere((c) => c.id == category.id);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Categoría eliminada con éxito'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
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
            child: TabBarView(
              controller: _tabController,
              children: [
                // Tab de gastos
                _buildCategoriesList(filteredCategories),
                // Tab de ingresos
                _buildCategoriesList(filteredCategories),
              ],
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

  Widget _buildCategoriesList(List<Category> categories) {
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

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final category = categories[index];
        return CategoryListItem(
          category: category,
          onTap: () => _navigateToCategoryForm(category: category),
          onDelete: () => _deleteCategory(category),
        );
      },
    );
  }
}
