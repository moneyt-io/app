// lib/presentation/screens/category_form.dart
import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../../data/models/category_model.dart';

class CategoryForm extends StatelessWidget {
  final CategoryRepository categoryRepository;
  final CategoryEntity? category;

  const CategoryForm({
    Key? key, 
    required this.categoryRepository, 
    this.category
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: category?.name ?? '');
    final descriptionController = TextEditingController(text: category?.description ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(category == null ? 'Nueva Categoría' : 'Editar Categoría'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final description = descriptionController.text.trim();

                if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('El nombre es obligatorio')),
                  );
                  return;
                }

                final newCategory = CategoryModel(
                  id: category?.id ?? -1, // -1 para nueva categoría
                  name: name,
                  description: description,
                  createdAt: category?.createdAt ?? DateTime.now(),
                );

                if (category == null) {
                  await categoryRepository.createCategory(newCategory);
                } else {
                  await categoryRepository.updateCategory(newCategory);
                }

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Text(category == null ? 'Crear' : 'Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}