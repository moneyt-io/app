// lib/main.dart
import 'package:flutter/material.dart';
import 'data/local/database.dart';
import 'data/local/daos/category_dao.dart';
import 'data/repositories/category_repository_impl.dart';
import 'domain/repositories/category_repository.dart';
import 'presentation/screens/home_screen.dart';
import 'routes/app_routes.dart';

void main() {
  final database = AppDatabase();
  final categoryDao = CategoryDao(database);
  final CategoryRepository categoryRepository = CategoryRepositoryImpl(categoryDao);
  
  runApp(MainApp(categoryRepository: categoryRepository));
}

class MainApp extends StatelessWidget {
  final CategoryRepository categoryRepository;

  const MainApp({
    super.key, 
    required this.categoryRepository
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => 
          AppRoutes.onGenerateRoute(settings, categoryRepository),
      home: HomeScreen(categoryRepository: categoryRepository),
    );
  }
}