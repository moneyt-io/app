// lib/main.dart
import 'package:flutter/material.dart';
import 'core/di/injection_container.dart';
import 'domain/usecases/category_usecases.dart';
import 'presentation/screens/home_screen.dart';
import 'routes/app_routes.dart';

void main() {
  setupDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'moneyt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => AppRoutes.onGenerateRoute(
        settings,
        getCategories: getIt<GetCategories>(),
        createCategory: getIt<CreateCategory>(),
        updateCategory: getIt<UpdateCategory>(),
        deleteCategory: getIt<DeleteCategory>(),
      ),
      home: HomeScreen(
        getCategories: getIt<GetCategories>(),
        createCategory: getIt<CreateCategory>(),
        updateCategory: getIt<UpdateCategory>(),
        deleteCategory: getIt<DeleteCategory>(),
      ),
    );
  }
}