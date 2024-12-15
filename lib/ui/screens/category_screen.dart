import 'package:flutter/material.dart';
import '../../data/local/database.dart';
import '../../data/local/daos/category_dao.dart';
import 'category_form.dart';



class CategoryScreen extends StatelessWidget {
  final CategoryDao categoryDao;

  const CategoryScreen({Key? key, required this.categoryDao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      body: StreamBuilder<List<Category>>(
        stream: categoryDao.watchAllCategories(),
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
                    await categoryDao.deleteCategory(category.id);
                  },
                ),
                onTap: () {
                  // Navegamos al formulario de edición
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryForm(
                        categoryDao: categoryDao,
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
          // Navegamos al formulario de creación
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryForm(
                categoryDao: categoryDao,
              ),
            ),
          );
        },
      ),
    );
  }
}
