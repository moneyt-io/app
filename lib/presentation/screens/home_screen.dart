// lib/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../../domain/usecases/category_usecases.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  final GetCategories getCategories;
  final CreateCategory createCategory;
  final UpdateCategory updateCategory;
  final DeleteCategory deleteCategory;

  const HomeScreen({
    Key? key,
    required this.getCategories,
    required this.createCategory,
    required this.updateCategory,
    required this.deleteCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Aplicación'),
      ),
      drawer: AppDrawer(
        getCategories: getCategories,
        createCategory: createCategory,
        updateCategory: updateCategory,
        deleteCategory: deleteCategory,
      ),
      body: const Center(
        child: Text('Bienvenido a la aplicación'),
      ),
    );
  }
}