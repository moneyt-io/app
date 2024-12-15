import 'package:drift/drift.dart' as drift; // 👈 Usamos un alias "drift"
import 'package:flutter/material.dart';

import '../../data/local/database.dart';
import '../../data/local/daos/category_dao.dart';

class CategoryForm extends StatelessWidget {
  final CategoryDao categoryDao;
  final Category? category;

  const CategoryForm({Key? key, required this.categoryDao, this.category})
      : super(key: key);

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
        child: Column( // 👈 Ya no hay problema con el 'Column' de Flutter
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

                // Usamos drift.Value en lugar de Value
                final companion = CategoriesCompanion(
                  name: drift.Value(name),
                  description: drift.Value(description),
                );

                if (category == null) {
                  await categoryDao.insertCategory(companion);
                } else {
                  await categoryDao.updateCategory(
                    companion.copyWith(id: drift.Value(category!.id)),
                  );
                }

                Navigator.pop(context);
              },
              child: Text(category == null ? 'Crear' : 'Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
