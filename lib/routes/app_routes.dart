// lib/routes/app_routes.dart
import 'package:flutter/material.dart';
import '../domain/entities/category.dart';
import '../domain/usecases/category_usecases.dart';
import '../presentation/screens/category_screen.dart';
import '../presentation/screens/category_form.dart';
import '../presentation/screens/home_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String categories = '/categories';
  static const String categoryForm = '/category-form';

  static Route<dynamic> onGenerateRoute(
    RouteSettings settings,
    {
      required GetCategories getCategories,
      required CreateCategory createCategory,
      required UpdateCategory updateCategory,
      required DeleteCategory deleteCategory,
    }
  ) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
            getCategories: getCategories,
            createCategory: createCategory,
            updateCategory: updateCategory,
            deleteCategory: deleteCategory,
          ),
        );
      
      case categories:
        return MaterialPageRoute(
          builder: (_) => CategoryScreen(
            getCategories: getCategories,
            createCategory: createCategory,
            updateCategory: updateCategory,
            deleteCategory: deleteCategory,
          ),
        );
      
      case categoryForm:
        final args = settings.arguments as CategoryFormArgs;
        return MaterialPageRoute(
          builder: (_) => CategoryForm(
            category: args.category,
            createCategory: createCategory,
            updateCategory: updateCategory,
            getCategories: getCategories,  // Agregado
          ),
        );
      
      default:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
            getCategories: getCategories,
            createCategory: createCategory,
            updateCategory: updateCategory,
            deleteCategory: deleteCategory,
          ),
        );
    }
  }
}

// lib/routes/app_routes.dart
class CategoryFormArgs {
  final CategoryEntity? category;
  final CreateCategory createCategory;
  final UpdateCategory updateCategory;
  final GetCategories getCategories;  // Agregado

  CategoryFormArgs({
    this.category,
    required this.createCategory,
    required this.updateCategory,
    required this.getCategories,  // Agregado
  });
}