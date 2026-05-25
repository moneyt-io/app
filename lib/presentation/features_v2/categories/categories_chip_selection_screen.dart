import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../domain/entities/category.dart';
import '../../../../domain/usecases/category_usecases.dart';
import '../../../../core/utils/icon_to_emoji_mapper.dart';
import '../../core/l10n/generated/strings.g.dart';
import 'widgets/v2_category_form_bottom_sheet.dart';

class CategoriesChipSelectionScreen extends StatefulWidget {
  const CategoriesChipSelectionScreen({super.key});

  @override
  State<CategoriesChipSelectionScreen> createState() => _CategoriesChipSelectionScreenState();
}

class _CategoriesChipSelectionScreenState extends State<CategoriesChipSelectionScreen> {
  late final CategoryUseCases _categoryUseCases;
  List<Category> _categories = [];
  List<Category> _filteredCategories = [];
  bool _isLoading = true;
  String _searchQuery = '';
  final String _selectedType = 'E'; // Por defecto Gastos, podría recibirse por parámetro

  @override
  void initState() {
    super.initState();
    _categoryUseCases = GetIt.instance<CategoryUseCases>();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoading = true);
    try {
      final allCategories = await _categoryUseCases.getAllCategories();

      if (mounted) {
        setState(() {
          // Mostrar todos los "hijos" del tipo seleccionado
          _categories = allCategories.where((c) => 
            c.documentTypeId == _selectedType && c.parentId != null
          ).toList();
          _filterCategories(_searchQuery);
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading V2 categories: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _filterCategories(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCategories = _categories;
      } else {
        _filteredCategories = _categories.where((c) => 
          c.name.toLowerCase().contains(query.toLowerCase())
        ).toList();
      }
    });
  }

  void _showAddCategoryDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => V2CategoryFormBottomSheet(
        selectedType: _selectedType,
        onSave: (name, emoji) async {
          final allCats = await _categoryUseCases.getAllCategories();
          final rootName = _selectedType == 'E' ? 'Expense' : 'Income';
          Category? root = allCats.where((c) => c.parentId == null && c.name == rootName && c.documentTypeId == _selectedType).firstOrNull;
          
          if (root == null) {
            final newRoot = Category(
              id: 0,
              name: rootName,
              documentTypeId: _selectedType,
              chartAccountId: 0,
              icon: Icons.folder.codePoint.toString(),
              active: true,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            );
            root = await _categoryUseCases.createCategory(newRoot);
          }

          final newCat = Category(
            id: 0,
            name: name,
            documentTypeId: _selectedType,
            parentId: root.id,
            chartAccountId: 0,
            icon: emoji,
            active: true,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          await _categoryUseCases.createCategory(newCat);
          _loadCategories(); // Refrescar
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(t.v2.categories.title),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: theme.colorScheme.onSurfaceVariant),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.search, color: theme.colorScheme.outline),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                      decoration: InputDecoration(
                        hintText: t.v2.categories.searchPlaceholder,
                        hintStyle: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.outlineVariant,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: false,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: _filterCategories,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // New Category Button
            ElevatedButton(
              onPressed: _showAddCategoryDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                shadowColor: Colors.black.withValues(alpha: 0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_circle_outline, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    t.v2.categories.newCategory,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: 18,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Categories Grid
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_filteredCategories.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    t.v2.categories.noCategories,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.start,
                children: _filteredCategories.map((cat) {
                  final emoji = IconToEmojiMapper.getEmoji(cat.icon);
                  return _buildCategoryPill(context, cat, emoji, cat.name);
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryPill(BuildContext context, Category category, String emoji, String label) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        // Al seleccionar la categoría, podríamos devolverla
        Navigator.of(context).pop(category);
      },
      child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: theme.colorScheme.surfaceContainerHigh.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
