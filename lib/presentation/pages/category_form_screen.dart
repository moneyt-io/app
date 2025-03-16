import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import '../atoms/app_button.dart';
import '../molecules/form_field_container.dart';
import '../routes/navigation_service.dart';

class CategoryFormScreen extends StatefulWidget {
  final Category? category;

  const CategoryFormScreen({
    Key? key,
    this.category,
  }) : super(key: key);

  @override
  State<CategoryFormScreen> createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  
  String _selectedIcon = 'category';
  String _selectedType = 'E'; // E = Gastos (por defecto), I = Ingresos
  
  bool get isEditing => widget.category != null;

  @override
  void initState() {
    super.initState();
    
    if (isEditing) {
      _nameController.text = widget.category!.name;
      _selectedIcon = widget.category!.icon;
      _selectedType = widget.category!.documentTypeId;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveCategory() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final category = Category(
      id: isEditing ? widget.category!.id : DateTime.now().millisecondsSinceEpoch,
      name: _nameController.text.trim(),
      icon: _selectedIcon,
      documentTypeId: _selectedType,
      active: true,
      createdAt: isEditing ? widget.category!.createdAt : DateTime.now(),
      updatedAt: DateTime.now(), 
      chartAccountId: 1,
    );

    // En una implementación real, aquí iría la llamada al usecase correspondiente
    //NavigationService.goBack(result: category);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isEditing ? 'Categoría actualizada' : 'Categoría creada'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar categoría' : 'Nueva categoría'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Tarjeta principal
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: colorScheme.outline.withOpacity(0.2),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Información de la categoría',
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Nombre de categoría
                    FormFieldContainer(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre de categoría',
                          prefixIcon: Icon(Icons.label_outline),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Ingrese un nombre para la categoría';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Selector de tipo (gasto/ingreso)
                    FormFieldContainer(
                      child: DropdownButtonFormField<String>(
                        value: _selectedType,
                        decoration: const InputDecoration(
                          labelText: 'Tipo',
                          prefixIcon: Icon(Icons.category_outlined),
                          border: InputBorder.none,
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'E',
                            child: Text('Gasto'),
                          ),
                          DropdownMenuItem(
                            value: 'I',
                            child: Text('Ingreso'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedType = value;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Selector de icono
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selecciona un icono:',
                          style: textTheme.titleSmall?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _buildIconOption('food', Icons.restaurant, colorScheme),
                            _buildIconOption('transport', Icons.directions_car, colorScheme),
                            _buildIconOption('entertainment', Icons.movie, colorScheme),
                            _buildIconOption('health', Icons.medical_services, colorScheme),
                            _buildIconOption('salary', Icons.payments, colorScheme),
                            _buildIconOption('investment', Icons.trending_up, colorScheme),
                            _buildIconOption('shopping', Icons.shopping_bag, colorScheme),
                            _buildIconOption('home', Icons.home, colorScheme),
                            _buildIconOption('utilities', Icons.lightbulb, colorScheme),
                            _buildIconOption('education', Icons.school, colorScheme),
                            _buildIconOption('gift', Icons.card_giftcard, colorScheme),
                            _buildIconOption('travel', Icons.flight, colorScheme),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).padding.bottom + 16,
        ),
        child: AppButton(
          text: 'Guardar',
          onPressed: _saveCategory,
          type: AppButtonType.primary,
          isFullWidth: true,
        ),
      ),
    );
  }

  Widget _buildIconOption(String iconName, IconData iconData, ColorScheme colorScheme) {
    final isSelected = _selectedIcon == iconName;
    final bgColor = isSelected
        ? (_selectedType == 'E' ? colorScheme.errorContainer : colorScheme.primaryContainer)
        : colorScheme.surfaceVariant;
    final iconColor = isSelected
        ? (_selectedType == 'E' ? colorScheme.onErrorContainer : colorScheme.onPrimaryContainer)
        : colorScheme.onSurfaceVariant;
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIcon = iconName;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(
                  color: _selectedType == 'E'
                      ? colorScheme.error
                      : colorScheme.primary,
                  width: 2,
                )
              : null,
        ),
        child: Icon(
          iconData,
          color: iconColor,
          size: 28,
        ),
      ),
    );
  }
}
