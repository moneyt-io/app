// lib/presentation/screens/category_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../routes/app_routes.dart';
import '../widgets/app_drawer.dart';
import '../../core/l10n/language_manager.dart';

class CategoryFormArgs {
  final CategoryEntity? category;
  final bool isEditing;

  CategoryFormArgs({
    this.category,
    this.isEditing = false,
  });
}

class CategoryScreen extends StatefulWidget {
  // Categorías
  final GetCategories getCategories;
  final CreateCategory createCategory;
  final UpdateCategory updateCategory;
  final DeleteCategory deleteCategory;

  // Cuentas (necesarias para el drawer)
  final GetAccounts getAccounts;
  final CreateAccount createAccount;
  final UpdateAccount updateAccount;
  final DeleteAccount deleteAccount;

  final TransactionUseCases transactionUseCases;

  const CategoryScreen({
    Key? key,
    required this.getCategories,
    required this.createCategory,
    required this.updateCategory,
    required this.deleteCategory,
    required this.getAccounts,
    required this.createAccount,
    required this.updateAccount,
    required this.deleteAccount,
    required this.transactionUseCases,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final Map<int, bool> _expandedStates = {};

  Future<void> _navigateToForm(BuildContext context, {CategoryEntity? category}) async {
    await Navigator.pushNamed(
      context,
      AppRoutes.categoryForm,
      arguments: CategoryFormArgs(
        category: category,
        isEditing: category != null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(translations.categories),
          backgroundColor: colorScheme.surface,
          elevation: 0,
          bottom: TabBar(
            labelColor: colorScheme.primary,
            unselectedLabelColor: colorScheme.onSurfaceVariant,
            indicatorColor: colorScheme.primary,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(
                text: translations.income,
                icon: Icon(
                  Icons.arrow_upward,
                  color: colorScheme.primary,
                ),
              ),
              Tab(
                text: translations.expense,
                icon: Icon(
                  Icons.arrow_downward,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        drawer: AppDrawer(
          getCategories: widget.getCategories,
          createCategory: widget.createCategory,
          updateCategory: widget.updateCategory,
          deleteCategory: widget.deleteCategory,
          getAccounts: widget.getAccounts,
          createAccount: widget.createAccount,
          updateAccount: widget.updateAccount,
          deleteAccount: widget.deleteAccount,
          transactionUseCases: widget.transactionUseCases,
        ),
        body: TabBarView(
          children: [
            // Tab de categorías de ingresos
            _buildCategoryList(context, 'I'),
            // Tab de categorías de gastos
            _buildCategoryList(context, 'E'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToForm(context),
          backgroundColor: colorScheme.primaryContainer,
          child: Icon(
            Icons.add,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList(BuildContext context, String type) {
    final translations = context.watch<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;

    return StreamBuilder<List<CategoryEntity>>(
      stream: widget.getCategories(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              '${translations.error}: ${snapshot.error}',
              style: TextStyle(color: colorScheme.error),
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final categories = snapshot.data!
            .where((category) => category.type == type)
            .toList();

        if (categories.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  type == 'I' ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 48,
                  color: colorScheme.primary.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  translations.noCategories,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        }

        // Separar categorías padre e hijas
        final parentCategories = categories
            .where((category) => category.parentId == null)
            .toList();
        
        final Map<int, List<CategoryEntity>> childrenByParent = {};
        final childCategories = categories
            .where((category) => category.parentId != null);
        
        for (var child in childCategories) {
          if (!childrenByParent.containsKey(child.parentId)) {
            childrenByParent[child.parentId!] = [];
          }
          childrenByParent[child.parentId!]!.add(child);
        }

        return Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: parentCategories.length,
            itemBuilder: (context, index) {
              final parentCategory = parentCategories[index];
              final children = childrenByParent[parentCategory.id] ?? [];

              return Column(
                children: [
                  // Categoría padre como ExpansionTile
                  Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      key: Key('category_${parentCategory.id}'),
                      initiallyExpanded: _expandedStates[parentCategory.id] ?? false,
                      onExpansionChanged: (expanded) {
                        setState(() {
                          _expandedStates[parentCategory.id] = expanded;
                        });
                      },
                      leading: CircleAvatar(
                        backgroundColor: colorScheme.primaryContainer,
                        child: Icon(
                          Icons.folder_outlined,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                      title: Text(
                        parentCategory.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: parentCategory.description?.isNotEmpty ?? false
                          ? Text(
                              parentCategory.description!,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            )
                          : null,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit_outlined,
                              color: colorScheme.primary,
                            ),
                            onPressed: () => _navigateToForm(context, category: parentCategory),
                          ),
                          Icon(
                            _expandedStates[parentCategory.id] ?? false 
                                ? Icons.keyboard_arrow_up 
                                : Icons.keyboard_arrow_down,
                            color: colorScheme.primary,
                          ),
                        ],
                      ),
                      children: children.map((child) => ListTile(
                        leading: CircleAvatar(
                          backgroundColor: colorScheme.secondaryContainer,
                          child: Icon(
                            Icons.category_outlined,
                            color: colorScheme.onSecondaryContainer,
                          ),
                        ),
                        title: Text(
                          child.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: child.description?.isNotEmpty ?? false
                            ? Text(
                                child.description!,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              )
                            : null,
                        trailing: IconButton(
                          icon: Icon(
                            Icons.edit_outlined,
                            color: colorScheme.primary,
                          ),
                          onPressed: () => _navigateToForm(context, category: child),
                        ),
                        onTap: () => _navigateToForm(context, category: child),
                      )).toList(),
                    ),
                  ),
                  if (index < parentCategories.length - 1)
                    Divider(
                      color: colorScheme.outline.withOpacity(0.2),
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}