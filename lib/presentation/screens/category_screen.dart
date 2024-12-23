// lib/presentation/screens/category_screen.dart
import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../routes/app_routes.dart';
import '../widgets/expandable_category_list.dart';
import '../widgets/app_drawer.dart';

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

  // Cambiado para devolver Future<void>
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categorías'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Gastos'),
              Tab(text: 'Ingresos'),
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
            // Tab de categorías de gastos
            StreamBuilder<List<CategoryEntity>>(
              stream: getCategories(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final expenseCategories = snapshot.data!
                    .where((category) => category.type == 'E')
                    .toList();
                return ExpandableCategoryList(
                  categories: expenseCategories,
                  onDelete: (category) => deleteCategory(category.id!),
                  onUpdate: (category) => _navigateToForm(context, category: category),
                );
              },
            ),
            // Tab de categorías de ingresos
            StreamBuilder<List<CategoryEntity>>(
              stream: getCategories(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final incomeCategories = snapshot.data!
                    .where((category) => category.type == 'I')
                    .toList();
                return ExpandableCategoryList(
                  categories: incomeCategories,
                  onDelete: (category) => deleteCategory(category.id!),
                  onUpdate: (category) => _navigateToForm(context, category: category),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToForm(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}