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

class CategoryScreen extends StatelessWidget {
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
          getCategories: getCategories,
          createCategory: createCategory,
          updateCategory: updateCategory,
          deleteCategory: deleteCategory,
          getAccounts: getAccounts,
          createAccount: createAccount,
          updateAccount: updateAccount,
          deleteAccount: deleteAccount,
          transactionUseCases: transactionUseCases,
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
      stream: getCategories(),
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
            itemCount: categories.length,
            separatorBuilder: (context, index) => Divider(
              color: colorScheme.outline.withOpacity(0.2),
              height: 1,
            ),
            itemBuilder: (context, index) {
              final category = categories[index];
              return ListTile(
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
                trailing: IconButton(
                  icon: Icon(
                    Icons.edit_outlined,
                    color: colorScheme.primary,
                  ),
                  onPressed: () => _navigateToForm(context, category: category),
                ),
                onTap: () => _navigateToForm(context, category: category),
              );
            },
          ),
        );
      },
    );
  }
}