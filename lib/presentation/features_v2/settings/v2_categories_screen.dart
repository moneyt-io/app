import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/usecases/category_usecases.dart';
import '../../../core/utils/icon_to_emoji_mapper.dart';
import '../categories/widgets/v2_category_form_bottom_sheet.dart';
import '../../core/l10n/generated/strings.g.dart';
import '../theme/v2_colors.dart';
import '../../features/transactions/transaction_provider.dart';

class V2CategoriesScreen extends StatefulWidget {
  const V2CategoriesScreen({super.key});

  @override
  State<V2CategoriesScreen> createState() => _V2CategoriesScreenState();
}

class _V2CategoriesScreenState extends State<V2CategoriesScreen> {
  late final CategoryUseCases _categoryUseCases;
  
  List<Category> _categories = [];
  bool _isLoading = true;
  String _selectedType = 'E'; // 'E' para Gastos, 'I' para Ingresos

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
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading categories: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _getDeleteCategoryHasTransactionsMessage() {
    switch (LocaleSettings.currentLocale) {
      case AppLocale.es:
        return 'No es posible eliminar esta categoría porque tiene transacciones registradas.';
      case AppLocale.fil:
        return 'Hindi maaaring tanggalin ang kategoryang ito dahil mayroon itong mga transaksyon.';
      case AppLocale.fr:
        return 'Impossible de supprimer cette catégorie car elle contient des transactions existantes.';
      case AppLocale.id:
        return 'Tidak dapat menghapus kategori ini karena memiliki transaksi yang ada.';
      case AppLocale.pt:
        return 'Não é possível excluir esta categoria porque ela possui transações existentes.';
      case AppLocale.vi:
        return 'Không thể xóa danh mục này vì nó có các giao dịch hiện có.';
      case AppLocale.en:
        return 'Cannot delete this category because it has existing transactions.';
    }
  }

  Future<void> _deleteCategory(Category category) async {
    final txProvider = context.read<TransactionProvider>();
    
    // Check if category has transactions (standardized behavior with wallets)
    final hasTransactions = txProvider.transactions.any((tx) {
      final matchesHeader = tx.category?.id == category.id;
      final matchesDetails = tx.details.any((d) => d.categoryId == category.id);
      return matchesHeader || matchesDetails;
    });

    if (hasTransactions) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _getDeleteCategoryHasTransactionsMessage(),
                  style: const TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: V2Colors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(t.v2.settings.deleteCategory, style: const TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
        content: Text(t.v2.settings.cannotUndo, style: const TextStyle(fontFamily: 'Manrope', color: V2Colors.onSurfaceVariant)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t.v2.settings.cancel, style: const TextStyle(color: V2Colors.onSurfaceVariant, fontFamily: 'Manrope', fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(t.v2.settings.delete, style: const TextStyle(color: V2Colors.error, fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _categoryUseCases.deleteCategory(category.id);
        _loadCategories();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(t.v2.settings.deleteError(error: e.toString()))),
          );
        }
      }
    }
  }

  void _showAddOrEditCategoryDialog({Category? categoryToEdit}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => V2CategoryFormBottomSheet(
        categoryToEdit: categoryToEdit,
        selectedType: _selectedType,
        onSave: (name, emoji) async {
          if (categoryToEdit != null) {
            final updatedCat = categoryToEdit.copyWith(
              name: name,
              icon: emoji,
              updatedAt: DateTime.now(),
            );
            await _categoryUseCases.updateCategory(updatedCat);
          } else {
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
          }
          _loadCategories();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: V2Colors.background,
        appBar: AppBar(
          backgroundColor: V2Colors.background,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: V2Colors.onSurface),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            t.v2.settings.categories,
            style: TextStyle(
              color: V2Colors.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'Manrope',
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(height: 16),
            _buildTypeToggle(),
            const SizedBox(height: 24),
            Expanded(
              child: _isLoading 
                ? const Center(child: CircularProgressIndicator())
                : _categories.isEmpty
                  ? Center(
                      child: Text(t.v2.settings.noCategoriesCreated, 
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: V2Colors.outlineVariant, fontFamily: 'Manrope')
                      )
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final cat = _categories[index];
                        
                        // Determinar emoji visual
                        String emoji = IconToEmojiMapper.getEmoji(cat.icon);
                        
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: V2Colors.surfaceContainerLowest,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ListTile(
                            onTap: () => _showAddOrEditCategoryDialog(categoryToEdit: cat),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            leading: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: _selectedType == 'E' 
                                  ? V2Colors.errorContainer.withValues(alpha: 0.3)
                                  : V2Colors.secondaryContainer.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(emoji, style: const TextStyle(fontSize: 24)),
                            ),
                            title: Text(
                              cat.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: V2Colors.onSurface,
                                fontFamily: 'Manrope',
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline, color: V2Colors.error),
                              onPressed: () => _deleteCategory(cat),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: V2Colors.primary,
          onPressed: () => _showAddOrEditCategoryDialog(),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTypeToggle() {
    final isExpense = _selectedType == 'E';
    
    return Container(
      width: 200,
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: V2Colors.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: isExpense ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: 96,
              decoration: BoxDecoration(
                color: V2Colors.surface,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (!isExpense) {
                      setState(() => _selectedType = 'E');
                      _loadCategories();
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        color: isExpense ? V2Colors.error : V2Colors.outline,
                        fontWeight: isExpense ? FontWeight.w700 : FontWeight.w500,
                        fontSize: 14,
                        fontFamily: 'Manrope',
                      ),
                      child: Text(t.v2.settings.expenses),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (isExpense) {
                      setState(() => _selectedType = 'I');
                      _loadCategories();
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        color: !isExpense ? const Color(0xFF00714D) : V2Colors.outline,
                        fontWeight: !isExpense ? FontWeight.w700 : FontWeight.w500,
                        fontSize: 14,
                        fontFamily: 'Manrope',
                      ),
                      child: Text(t.v2.settings.income),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


