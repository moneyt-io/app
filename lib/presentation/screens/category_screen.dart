// lib/presentation/screens/category_screen.dart
import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import 'category_form.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryRepository categoryRepository;

  const CategoryScreen({
    Key? key, 
    required this.categoryRepository
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      body: StreamBuilder<List<CategoryEntity>>(
        stream: categoryRepository.watchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final categories = snapshot.data ?? [];

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return ListTile(
                title: Text(category.name),
                subtitle: Text(category.description ?? 'Sin descripción'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await categoryRepository.deleteCategory(category.id);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryForm(
                        categoryRepository: categoryRepository,
                        category: category,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryForm(
                categoryRepository: categoryRepository,
              ),
            ),
          );
        },
      ),
    );
  }
}