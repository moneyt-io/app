import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/usecases/category_usecases.dart';
import '../../core/atoms/app_app_bar.dart';
import '../../core/atoms/app_button.dart';
import '../../core/atoms/app_floating_action_button.dart';
import '../../core/molecules/empty_state.dart';
import '../../core/molecules/category_type_filter.dart';
import '../../core/molecules/category_card.dart';
import '../../core/organisms/app_drawer.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import '../../core/design_system/tokens/app_dimensions.dart';
import '../../core/l10n/l10n_helper.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _selectedType = 'I';
  List<Category> _categories = [];
  bool _isLoading = true;
  String? _error;

  late final CategoryUseCases _categoryUseCases;

  @override
  void initState() {
    super.initState();
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

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  Map<Category, List<Category>> _buildCategoryTree(List<Category> categories) {
    final Map<Category, List<Category>> categoryTree = {};
    final rootCategories =
        categories.where((cat) => cat.parentId == null).toList();

    for (var rootCategory in rootCategories) {
      final children =
          categories.where((cat) => cat.parentId == rootCategory.id).toList();
      categoryTree[rootCategory] = children;
    }

    return categoryTree;
  }

  List<Category> _getFilteredCategories() {
    return _categories.where((category) {
      return category.documentTypeId == _selectedType &&
          category.parentId == null;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredCategories = _getFilteredCategories();
    final categoryTree = _buildCategoryTree(_categories);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppAppBar(
        title: t.navigation.categories,
        type: AppAppBarType.blur,
        leading: AppAppBarLeading.drawer,
        actions: [AppAppBarAction.search],
        onLeadingPressed: _openDrawer,
        onActionsPressed: [
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Search functionality coming soon')),
            );
          }
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // ✅ CORREGIDO: Agregar padding lateral al CategoryTypeFilter
          Padding(
            padding: const EdgeInsets.all(
                16), // HTML: px-4 py-4 del category_list.html
            child: CategoryTypeFilter(
              selectedType: _selectedType,
              onTypeChanged: (type) {
                setState(() {
                  _selectedType = type;
                });
              },
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshCategories,
              color: const Color(0xFF0c7ff2),
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF0c7ff2),
                      ),
                    )
                  : _error != null
                      ? _buildErrorState()
                      : _buildCategoriesList(filteredCategories, categoryTree),
            ),
          ),
        ],
      ),
      floatingActionButton: AppFloatingActionButton(
        onPressed: () => _navigateToCategoryForm(),
        icon: Icons.add,
        tooltip: 'Add category',
        backgroundColor: const Color(0xFF0c7ff2),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: AppDimensions.spacing64,
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
            AppButton(
              text: 'Reintentar',
              onPressed: _refreshCategories,
              type: AppButtonType.filled,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesList(
      List<Category> categories, Map<Category, List<Category>> categoryTree) {
    if (categories.isEmpty) {
      return EmptyState(
        icon: Icons.category_outlined,
        title: 'No hay categorías',
        message: _selectedType == 'I'
            ? 'Crea tu primera categoría de ingresos'
            : 'Crea tu primera categoría de gastos',
        action: AppButton(
          text: 'Agregar categoría',
          onPressed: () => _navigateToCategoryForm(),
          type: AppButtonType.filled,
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
      itemCount: categories.length,
      separatorBuilder: (context, index) => const SizedBox.shrink(),
      itemBuilder: (context, index) {
        final category = categories[index];
        final subcategories = categoryTree[category] ?? [];

        return CategoryCard(
          category: category,
          subcategories: subcategories,
          onCategoryTap: () => _navigateToCategoryForm(category: category),
          onSubcategoryTap: (subcategory) =>
              _navigateToCategoryForm(category: subcategory),
        );
      },
    );
  }
}
