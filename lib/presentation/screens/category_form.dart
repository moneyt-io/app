// lib/presentation/screens/category_form.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/category_usecases.dart';
import '../../data/models/category_model.dart';
import '../../core/l10n/language_manager.dart';

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
  final _formKey = GlobalKey<FormState>();
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

  void _onTypeChanged() {
    setState(() {
      selectedParentCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category == null
              ? translations.newCategory
              : translations.editCategory,
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(
          color: colorScheme.onSurface,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Información básica
                Card(
                  elevation: 0,
                  color: colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: colorScheme.outlineVariant,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translations.basicInformation,
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: translations.name,
                            filled: true,
                            fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return translations.nameRequired;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                            labelText: translations.description,
                            filled: true,
                            fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Tipo de categoría
                Card(
                  elevation: 0,
                  color: colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: colorScheme.outlineVariant,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          translations.categoryType,
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ValueListenableBuilder<String>(
                          valueListenable: typeValue,
                          builder: (context, type, _) => Column(
                            children: [
                              _buildTypeOption(
                                context: context,
                                title: translations.expense,
                                subtitle: translations.expenseDescription,
                                value: 'E',
                                groupValue: type,
                                icon: Icons.remove_circle_outline_rounded,
                                onChanged: widget.category == null
                                    ? (String? value) {
                                        if (value != null) {
                                          typeValue.value = value;
                                        }
                                      }
                                    : null,
                              ),
                              const SizedBox(height: 8),
                              _buildTypeOption(
                                context: context,
                                title: translations.income,
                                subtitle: translations.incomeDescription,
                                value: 'I',
                                groupValue: type,
                                icon: Icons.add_circle_outline_rounded,
                                onChanged: widget.category == null
                                    ? (String? value) {
                                        if (value != null) {
                                          typeValue.value = value;
                                        }
                                      }
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Jerarquía de categoría
                Card(
                  elevation: 0,
                  color: colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: colorScheme.outlineVariant,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translations.categoryHierarchy,
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ValueListenableBuilder<bool>(
                          valueListenable: isSubcategoryValue,
                          builder: (context, isSubcategory, _) => Column(
                            children: [
                              _buildHierarchyOption(
                                context: context,
                                title: translations.mainCategory,
                                subtitle: translations.mainCategoryDescription,
                                value: false,
                                groupValue: isSubcategory,
                                icon: Icons.folder_rounded,
                                onChanged: widget.category == null
                                    ? (value) => isSubcategoryValue.value = value!
                                    : null,
                              ),
                              const SizedBox(height: 8),
                              _buildHierarchyOption(
                                context: context,
                                title: translations.subcategory,
                                subtitle: translations.subcategoryDescription,
                                value: true,
                                groupValue: isSubcategory,
                                icon: Icons.subdirectory_arrow_right_rounded,
                                onChanged: widget.category == null
                                    ? (value) => isSubcategoryValue.value = value!
                                    : null,
                              ),
                              if (isSubcategory) ...[
                                const SizedBox(height: 16),
                                StreamBuilder<List<CategoryEntity>>(
                                  stream: widget.getCategories(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text(
                                        translations.errorLoadingCategories,
                                        style: TextStyle(color: colorScheme.error),
                                      );
                                    }

                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: colorScheme.primary,
                                        ),
                                      );
                                    }

                                    final mainCategories = snapshot.data!
                                        .where((cat) =>
                                            cat.isMainCategory &&
                                            cat.type == typeValue.value)
                                        .toList();

                                    if (mainCategories.isEmpty) {
                                      return Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: colorScheme.surfaceVariant
                                              .withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.info_outline_rounded,
                                              color: colorScheme.onSurfaceVariant,
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Text(
                                                translations.noMainCategoriesAvailable(
                                                  typeValue.value == 'E'
                                                      ? translations.expense.toLowerCase()
                                                      : translations.income.toLowerCase(),
                                                ),
                                                style: textTheme.bodyMedium?.copyWith(
                                                  color: colorScheme.onSurfaceVariant,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }

                                    return DropdownButtonFormField<CategoryEntity>(
                                      value: selectedParentCategory,
                                      decoration: InputDecoration(
                                        labelText: translations.parentCategory,
                                        filled: true,
                                        fillColor:
                                            colorScheme.surfaceVariant.withOpacity(0.3),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      items: mainCategories
                                          .map((cat) => DropdownMenuItem(
                                                value: cat,
                                                child: Text(cat.name),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedParentCategory = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (isSubcategory && value == null) {
                                          return translations.selectParentCategory;
                                        }
                                        return null;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Botón guardar
                FilledButton(
                  onPressed: _saveCategory,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    widget.category == null ? translations.create : translations.update,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveCategory() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final newCategory = CategoryModel(
        id: widget.category?.id ?? -1,
        parentId:
            isSubcategoryValue.value ? selectedParentCategory?.id : null,
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        type: typeValue.value,
        createdAt: widget.category?.createdAt ?? DateTime.now(),
      );

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
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Widget _buildTypeOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String value,
    required String groupValue,
    required IconData icon,
    required void Function(String?)? onChanged,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isSelected = value == groupValue;
    final isEnabled = onChanged != null;

    return Card(
      elevation: 0,
      color: isSelected ? colorScheme.primaryContainer : colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? Colors.transparent : colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: RadioListTile<String>(
        value: value,
        groupValue: groupValue,
        onChanged: isEnabled ? onChanged : null,
        title: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                color: isSelected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.bold : null,
              ),
            ),
          ],
        ),
        subtitle: Text(
          subtitle,
          style: textTheme.bodyMedium?.copyWith(
            color: isSelected
                ? colorScheme.onPrimaryContainer
                : colorScheme.onSurfaceVariant,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildHierarchyOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required bool value,
    required bool groupValue,
    required IconData icon,
    required void Function(bool?)? onChanged,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isSelected = value == groupValue;

    return Card(
      elevation: 0,
      color: isSelected ? colorScheme.primaryContainer : colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? Colors.transparent : colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: RadioListTile<bool>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        title: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                color: isSelected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.bold : null,
              ),
            ),
          ],
        ),
        subtitle: Text(
          subtitle,
          style: textTheme.bodyMedium?.copyWith(
            color: isSelected
                ? colorScheme.onPrimaryContainer
                : colorScheme.onSurfaceVariant,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}