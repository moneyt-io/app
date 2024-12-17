// lib/routes/app_routes.dart
import 'package:flutter/material.dart';
import '../domain/entities/category.dart';
import '../presentation/screens/category_screen.dart';
import '../presentation/screens/category_form.dart';
import '../domain/repositories/category_repository.dart';

class AppRoutes {
  static const String home = '/';
  static const String categories = '/categories';
  static const String categoryForm = '/category-form';

  static Route<dynamic> onGenerateRoute(
    RouteSettings settings, 
    CategoryRepository categoryRepository
  ) {
    switch (settings.name) {
      case home:
      case categories:
        return MaterialPageRoute(
          builder: (_) => CategoryScreen(categoryRepository: categoryRepository),
        );
      case categoryForm:
        final CategoryFormArgs? args = settings.arguments as CategoryFormArgs?;
        return MaterialPageRoute(
          builder: (_) => CategoryForm(
            categoryRepository: categoryRepository,
            category: args?.category,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => CategoryScreen(categoryRepository: categoryRepository),
        );
    }
  }
}

class CategoryFormArgs {
  final CategoryEntity? category;

  CategoryFormArgs({this.category});
}