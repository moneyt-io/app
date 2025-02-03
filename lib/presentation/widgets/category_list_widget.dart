import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/category_usecases.dart';

class CategoryListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final getCategories = context.read<GetCategories>();

    return StreamBuilder<List<CategoryEntity>>(
      stream: getCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final categories = snapshot.data ?? [];

        if (categories.isEmpty) {
          return const Center(child: Text('No hay categorías disponibles'));
        }

        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return ListTile(
              title: Text(category.name),
              subtitle: Text('ID: ${category.id}'),
            );
          },
        );
      },
    );
  }
}
