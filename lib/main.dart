import 'package:flutter/material.dart';
import 'data/local/database.dart';
import 'data/local/daos/category_dao.dart';
import 'ui/screens/category_screen.dart';

void main() {
  // Inicializamos la base de datos
  final database = AppDatabase();
  // Creamos el CategoryDao
  final categoryDao = CategoryDao(database);
  
  runApp(MainApp(categoryDao: categoryDao));
}

class MainApp extends StatelessWidget {
  final CategoryDao categoryDao;

  const MainApp({super.key, required this.categoryDao});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Category CRUD App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: CategoryScreen(categoryDao: categoryDao),
    );
  }
}
