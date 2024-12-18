// lib/presentation/screens/category_form.dart
import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../data/models/category_model.dart';

class CategoryForm extends StatefulWidget {
  final CategoryEntity? category;
  final CreateCategory createCategory;
  final UpdateCategory updateCategory;
  final GetCategories getCategories;

  const CategoryForm({
    Key? key,
    this.category,
    required this.createCategory,
    required this.updateCategory,
    required this.getCategories,
  }) : super(key: key);

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  late final ValueNotifier<String> typeValue;
  late final ValueNotifier<bool> isSubcategoryValue;
  CategoryEntity? selectedParentCategory;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.category?.name ?? '';
    descriptionController.text = widget.category?.description ?? '';
    typeValue = ValueNotifier(widget.category?.type ?? 'E');
    isSubcategoryValue = ValueNotifier(widget.category?.parentId != null);

    // Escuchar cambios en el tipo
    typeValue.addListener(_onTypeChanged);
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    typeValue.removeListener(_onTypeChanged);
    typeValue.dispose();
    isSubcategoryValue.dispose();
    super.dispose();
  }

  // Nuevo método para manejar cambios de tipo
  void _onTypeChanged() {
    // Resetear la categoría padre cuando cambia el tipo
    setState(() {
      selectedParentCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category == null ? 'Nueva Categoría' : 'Editar Categoría'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de nombre
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 16),

            // Campo de descripción
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 16),

            // Selector de tipo (Ingreso/Egreso)
            // En el selector de tipo
            ValueListenableBuilder<String>(
              valueListenable: typeValue,
              builder: (context, type, _) => Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Ingreso'),
                      value: 'I',
                      groupValue: type,
                      onChanged: (value) {
                        typeValue.value = value!;
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Egreso'),
                      value: 'E',
                      groupValue: type,
                      onChanged: (value) {
                        typeValue.value = value!;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Selector de tipo de categoría (Principal/Subcategoría)
            ValueListenableBuilder<bool>(
              valueListenable: isSubcategoryValue,
              builder: (context, isSubcategory, _) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tipo de categoría:'),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('Principal'),
                          value: false,
                          groupValue: isSubcategory,
                          onChanged: widget.category == null 
                              ? (value) => isSubcategoryValue.value = value!
                              : null,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('Subcategoría'),
                          value: true,
                          groupValue: isSubcategory,
                          onChanged: widget.category == null 
                              ? (value) => isSubcategoryValue.value = value!
                              : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Selector de categoría padre (solo visible si es subcategoría)
            ValueListenableBuilder<bool>(
              valueListenable: isSubcategoryValue,
              builder: (context, isSubcategory, _) {
                if (!isSubcategory) return const SizedBox.shrink();

                return StreamBuilder<List<CategoryEntity>>(
                  stream: widget.getCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Error al cargar categorías');
                    }

                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    // lib/presentation/screens/category_form.dart
                    // ... código anterior igual ...

                    // Dentro del StreamBuilder, modificamos la lógica de filtrado:
                    final mainCategories = snapshot.data!
                        .where((cat) => cat.isMainCategory && cat.type == typeValue.value)
                        .toList();

                    if (mainCategories.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'No hay categorías principales de ${typeValue.value == 'I' ? 'ingreso' : 'egreso'} disponibles',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      );
                    }

                    return DropdownButtonFormField<CategoryEntity>(
                      decoration: const InputDecoration(
                        labelText: 'Categoría principal',
                      ),
                      value: selectedParentCategory,
                      items: mainCategories.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedParentCategory = value;
                        });
                      },
                      validator: (value) {
                        if (isSubcategory && value == null) {
                          return 'Seleccione una categoría principal';
                        }
                        return null;
                      },
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 24),

            // Botón de guardar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final name = nameController.text.trim();
                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('El nombre es obligatorio')),
                    );
                    return;
                  }

                  if (isSubcategoryValue.value && selectedParentCategory == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Seleccione una categoría principal'),
                      ),
                    );
                    return;
                  }

                  final newCategory = CategoryModel(
                    id: widget.category?.id ?? -1,
                    parentId: isSubcategoryValue.value 
                        ? selectedParentCategory?.id 
                        : null,
                    name: name,
                    description: descriptionController.text.trim(),
                    type: typeValue.value,
                    createdAt: widget.category?.createdAt ?? DateTime.now(),
                  );

                  try {
                    if (widget.category == null) {
                      await widget.createCategory(newCategory);
                    } else {
                      await widget.updateCategory(newCategory);
                    }

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${e.toString()}')),
                      );
                    }
                  }
                },
                child: Text(widget.category == null ? 'Crear' : 'Actualizar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}