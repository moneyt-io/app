import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import '../../../../domain/entities/category.dart';
import '../../../../domain/usecases/category_usecases.dart';
import '../../../../core/utils/icon_to_emoji_mapper.dart';
import '../../theme/v2_colors.dart';
import '../../categories/widgets/v2_category_form_bottom_sheet.dart';
import '../../../features/transactions/transaction_provider.dart';

class V2CategorySelectionSheet extends StatefulWidget {
  final List<Category> categories;
  final Category? initialSelection;

  const V2CategorySelectionSheet({
    super.key,
    required this.categories,
    this.initialSelection,
  });

  static Future<Category?> show(
    BuildContext context, {
    required List<Category> categories,
    Category? initialSelection,
  }) {
    return showModalBottomSheet<Category?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => V2CategorySelectionSheet(
        categories: categories,
        initialSelection: initialSelection,
      ),
    );
  }

  @override
  State<V2CategorySelectionSheet> createState() => _V2CategorySelectionSheetState();
}

class _V2CategorySelectionSheetState extends State<V2CategorySelectionSheet> {
  late List<Category> _filteredCategories;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredCategories = widget.categories;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCategories = widget.categories;
      } else {
        _filteredCategories = widget.categories
            .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _showCreateCategory() {
    // Para simplificar, obtenemos el tipo desde las categorías (E o I)
    // Si la lista está vacía, asumimos Gasto (E) por defecto
    final selectedType = widget.categories.isNotEmpty 
        ? widget.categories.first.documentTypeId 
        : 'E';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => V2CategoryFormBottomSheet(
        selectedType: selectedType,
        onSave: (name, emoji) async {
          final categoryUseCases = GetIt.instance<CategoryUseCases>();
          try {
            final allCats = await categoryUseCases.getAllCategories();
            final rootName = selectedType == 'E' ? 'Expense' : 'Income';
            Category? root = allCats.where((c) => c.parentId == null && c.name == rootName && c.documentTypeId == selectedType).firstOrNull;
            
            if (root == null) {
              final newRoot = Category(
                id: 0,
                name: rootName,
                documentTypeId: selectedType,
                chartAccountId: 0,
                icon: Icons.folder.codePoint.toString(),
                active: true,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              );
              root = await categoryUseCases.createCategory(newRoot);
            }

            final newCat = Category(
              id: 0,
              name: name,
              documentTypeId: selectedType,
              parentId: root.id,
              chartAccountId: 0,
              icon: emoji,
              active: true,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            );
            final created = await categoryUseCases.createCategory(newCat);
            
            // Actualizar la caché en el provider para que las demás vistas (Dashboard) la reconozcan
            if (mounted) {
              await context.read<TransactionProvider>().refreshCategories();
            }
            
            // Cerrar el modal actual (el del formulario)
            if (mounted) {
              Navigator.pop(ctx);
            }
            
            // Cerrar este modal (CategorySelectionSheet) enviando la categoría creada
            if (mounted) {
              Navigator.pop(context, created);
            }
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: bottomInset > 0 ? bottomInset + 24 : 48,
      ),
      decoration: const BoxDecoration(
        color: V2Colors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          Center(
            child: Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: V2Colors.outlineVariant.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Seleccionar Categoría',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: V2Colors.onSurface,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: V2Colors.onSurfaceVariant),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Search Field
          TextField(
            controller: _searchController,
            onChanged: _onSearch,
            decoration: InputDecoration(
              hintText: 'Buscar categoría...',
              hintStyle: const TextStyle(
                fontFamily: 'Manrope',
                color: V2Colors.outlineVariant,
              ),
              prefixIcon: const Icon(Icons.search, color: V2Colors.outlineVariant),
              filled: true,
              fillColor: V2Colors.surfaceContainerLowest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: V2Colors.primary, width: 2),
              ),
            ),
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 16,
              color: V2Colors.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          
          Expanded(
            child: _filteredCategories.isEmpty
              ? const Center(
                  child: Text(
                    'No hay categorías disponibles',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      color: V2Colors.outlineVariant,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  itemCount: _filteredCategories.length,
                  itemBuilder: (context, index) {
                    final cat = _filteredCategories[index];
                    final isSelected = widget.initialSelection?.id == cat.id;
                    final isIncome = cat.documentTypeId == 'I';
                    
                    String emoji = IconToEmojiMapper.getEmoji(cat.icon);
                    
                    return GestureDetector(
                      onTap: () => Navigator.pop(context, cat),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: V2Colors.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? V2Colors.primary : Colors.transparent,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: isIncome 
                                    ? V2Colors.secondaryContainer.withValues(alpha: 0.3)
                                    : V2Colors.errorContainer.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(emoji, style: const TextStyle(fontSize: 24)),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                cat.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: V2Colors.onSurface,
                                  fontFamily: 'Manrope',
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: V2Colors.primary,
                                size: 24,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _showCreateCategory,
            icon: const Icon(Icons.add),
            label: const Text(
              'Crear nueva categoría',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: V2Colors.primary.withValues(alpha: 0.1),
              foregroundColor: V2Colors.primary,
              elevation: 0,
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
