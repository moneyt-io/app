// lib/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../../domain/repositories/category_repository.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  final CategoryRepository categoryRepository;

  const HomeScreen({
    Key? key,
    required this.categoryRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Aplicación'),
      ),
      drawer: AppDrawer(categoryRepository: categoryRepository),
      body: const Center(
        child: Text('Bienvenido a la aplicación'),
      ),
    );
  }
}