// lib/presentation/screens/category_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/category_usecases.dart';
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
  final GetCategories getCategories;
  final CreateCategory createCategory;
  final UpdateCategory updateCategory;
  final DeleteCategory deleteCategory;

  const CategoryScreen({
    Key? key,
    required this.getCategories,
    required this.createCategory,
    required this.updateCategory,
    required this.deleteCategory,
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

  Future<void> _deleteCategory(BuildContext context, CategoryEntity category) async {
    final translations = context.read<LanguageManager>().translations;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(translations.deleteCategory),
        content: Text(translations.deleteCategoryConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(translations.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(translations.delete),
          ),
        ],
      ),
    );

    if (result == true && mounted) {
      await widget.deleteCategory(category.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(translations.categoryDeleted)),
        );
      }
    }
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
        drawer: const AppDrawer(),
        body: TabBarView(
          children: [
            _buildCategoryList(context, 'I'),
            _buildCategoryList(context, 'E'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToForm(context),
          child: const Icon(Icons.add),
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
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: parentCategories.length,
            separatorBuilder: (context, index) => Divider(
              color: colorScheme.outline.withOpacity(0.2),
              height: 1,
            ),
            itemBuilder: (context, index) {
              final category = parentCategories[index];
              final children = childrenByParent[category.id] ?? [];
              final isExpanded = _expandedStates[category.id] ?? false;

              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: colorScheme.primaryContainer,
                      child: Icon(
                        Icons.category_outlined,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    title: Text(
                      category.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: category.description?.isNotEmpty ?? false
                        ? Text(
                            category.description!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          )
                        : null,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (children.isNotEmpty)
                          IconButton(
                            icon: Icon(
                              isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            onPressed: () {
                              setState(() {
                                _expandedStates[category.id] = !isExpanded;
                              });
                            },
                          ),
                        PopupMenuButton<String>(
                          icon: Icon(
                            Icons.more_vert,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          onSelected: (value) {
                            if (value == 'edit') {
                              _navigateToForm(context, category: category);
                            } else if (value == 'delete') {
                              _deleteCategory(context, category);
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(Icons.edit, color: colorScheme.primary),
                                  const SizedBox(width: 8),
                                  Text(translations.edit),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete, color: colorScheme.error),
                                  const SizedBox(width: 8),
                                  Text(translations.delete),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (isExpanded && children.isNotEmpty)
                    Column(
                      children: children.map((child) => ListTile(
                        contentPadding: const EdgeInsets.only(
                          left: 72,
                          right: 16,
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
                        trailing: PopupMenuButton<String>(
                          icon: Icon(
                            Icons.more_vert,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          onSelected: (value) {
                            if (value == 'edit') {
                              _navigateToForm(context, category: child);
                            } else if (value == 'delete') {
                              _deleteCategory(context, child);
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(Icons.edit, color: colorScheme.primary),
                                  const SizedBox(width: 8),
                                  Text(translations.edit),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete, color: colorScheme.error),
                                  const SizedBox(width: 8),
                                  Text(translations.delete),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
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