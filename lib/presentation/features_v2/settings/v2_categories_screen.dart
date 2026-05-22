import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/usecases/category_usecases.dart';
import '../../../core/utils/icon_to_emoji_mapper.dart';
import '../theme/v2_colors.dart';

class V2CategoriesScreen extends StatefulWidget {
  const V2CategoriesScreen({super.key});

  @override
  State<V2CategoriesScreen> createState() => _V2CategoriesScreenState();
}

class _V2CategoriesScreenState extends State<V2CategoriesScreen> {
  late final CategoryUseCases _categoryUseCases;
  
  List<Category> _categories = [];
  bool _isLoading = true;
  String _selectedType = 'E'; // 'E' para Gastos, 'I' para Ingresos

  @override
  void initState() {
    super.initState();
    _categoryUseCases = GetIt.instance<CategoryUseCases>();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoading = true);
    try {
      final allCategories = await _categoryUseCases.getAllCategories();
      
      // Aseguramos de tener las categorías root (padres) por defecto
      final rootCategories = allCategories.where((c) => c.parentId == null && c.name == 'V2 Root').toList();
      Category? rootIncome;
      Category? rootExpense;
      
      for (var c in rootCategories) {
        if (c.documentTypeId == 'I') rootIncome = c;
        if (c.documentTypeId == 'E') rootExpense = c;
      }
      
      if (rootIncome == null) {
        final newRoot = Category(
          id: 0,
          name: 'V2 Root',
          documentTypeId: 'I',
          chartAccountId: 0,
          icon: Icons.folder.codePoint.toString(),
          active: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        rootIncome = await _categoryUseCases.createCategory(newRoot);
        allCategories.add(rootIncome);
      }
      
      if (rootExpense == null) {
        final newRoot = Category(
          id: 0,
          name: 'V2 Root',
          documentTypeId: 'E',
          chartAccountId: 0,
          icon: Icons.folder.codePoint.toString(),
          active: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        rootExpense = await _categoryUseCases.createCategory(newRoot);
        allCategories.add(rootExpense);
      }

      // Filtrar "solo los hijos" agrupados bajo nuestra categoria principal
      final parentIdToMatch = _selectedType == 'E' ? rootExpense.id : rootIncome.id;
      
      if (mounted) {
        setState(() {
          _categories = allCategories.where((c) => 
            c.documentTypeId == _selectedType && 
            c.parentId == parentIdToMatch
          ).toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading V2 categories: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _deleteCategory(Category category) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('¿Eliminar categoría?', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
        content: Text('Esta acción no se puede deshacer.', style: const TextStyle(fontFamily: 'Manrope', color: V2Colors.onSurfaceVariant)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar', style: TextStyle(color: V2Colors.onSurfaceVariant, fontFamily: 'Manrope', fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar', style: TextStyle(color: V2Colors.error, fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _categoryUseCases.deleteCategory(category.id);
        _loadCategories();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al eliminar: $e')),
          );
        }
      }
    }
  }

  void _showAddOrEditCategoryDialog({Category? categoryToEdit}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _CategoryFormBottomSheet(
        categoryToEdit: categoryToEdit,
        selectedType: _selectedType,
        onSave: (name, emoji) async {
          if (categoryToEdit != null) {
            final updatedCat = categoryToEdit.copyWith(
              name: name,
              icon: emoji,
              updatedAt: DateTime.now(),
            );
            await _categoryUseCases.updateCategory(updatedCat);
          } else {
            final allCats = await _categoryUseCases.getAllCategories();
            Category? root = allCats.where((c) => c.parentId == null && c.name == 'V2 Root' && c.documentTypeId == _selectedType).firstOrNull;
            
            if (root != null) {
              final newCat = Category(
                id: 0,
                name: name,
                documentTypeId: _selectedType,
                parentId: root.id,
                chartAccountId: 0,
                icon: emoji,
                active: true,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              );
              await _categoryUseCases.createCategory(newCat);
            }
          }
          _loadCategories();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: V2Colors.background,
        appBar: AppBar(
          backgroundColor: V2Colors.background,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: V2Colors.onSurface),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Categorías',
            style: TextStyle(
              color: V2Colors.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'Manrope',
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(height: 16),
            _buildTypeToggle(),
            const SizedBox(height: 24),
            Expanded(
              child: _isLoading 
                ? const Center(child: CircularProgressIndicator())
                : _categories.isEmpty
                  ? const Center(
                      child: Text('No hay categorías.\nCrea una nueva.', 
                        textAlign: TextAlign.center,
                        style: TextStyle(color: V2Colors.outlineVariant, fontFamily: 'Manrope')
                      )
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final cat = _categories[index];
                        
                        // Determinar emoji visual
                        final isCodePoint = int.tryParse(cat.icon) != null;
                        String emoji;
                        if (!isCodePoint && cat.icon.isNotEmpty) {
                          emoji = cat.icon; // Ya es un emoji de iOS guardado en string
                        } else {
                          emoji = IconToEmojiMapper.getEmoji(cat.icon); // Fallback legacy
                        }
                        
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: V2Colors.surfaceContainerLowest,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ListTile(
                            onTap: () => _showAddOrEditCategoryDialog(categoryToEdit: cat),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            leading: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: _selectedType == 'E' 
                                  ? V2Colors.errorContainer.withValues(alpha: 0.3)
                                  : V2Colors.secondaryContainer.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(emoji, style: const TextStyle(fontSize: 24)),
                            ),
                            title: Text(
                              cat.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: V2Colors.onSurface,
                                fontFamily: 'Manrope',
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline, color: V2Colors.error),
                              onPressed: () => _deleteCategory(cat),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: V2Colors.primary,
          onPressed: () => _showAddOrEditCategoryDialog(),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTypeToggle() {
    final isExpense = _selectedType == 'E';
    
    return Container(
      width: 200,
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: V2Colors.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: isExpense ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: 96,
              decoration: BoxDecoration(
                color: V2Colors.surface,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (!isExpense) {
                      setState(() => _selectedType = 'E');
                      _loadCategories();
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        color: isExpense ? V2Colors.error : V2Colors.outline,
                        fontWeight: isExpense ? FontWeight.w700 : FontWeight.w500,
                        fontSize: 14,
                        fontFamily: 'Manrope',
                      ),
                      child: const Text("Gastos"),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (isExpense) {
                      setState(() => _selectedType = 'I');
                      _loadCategories();
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        color: !isExpense ? const Color(0xFF00714D) : V2Colors.outline,
                        fontWeight: !isExpense ? FontWeight.w700 : FontWeight.w500,
                        fontSize: 14,
                        fontFamily: 'Manrope',
                      ),
                      child: const Text("Ingresos"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryFormBottomSheet extends StatefulWidget {
  final Category? categoryToEdit;
  final String selectedType;
  final Function(String name, String emoji) onSave;

  const _CategoryFormBottomSheet({
    this.categoryToEdit,
    required this.selectedType,
    required this.onSave,
  });

  @override
  State<_CategoryFormBottomSheet> createState() => _CategoryFormBottomSheetState();
}

class _CategoryFormBottomSheetState extends State<_CategoryFormBottomSheet> {
  late TextEditingController _nameController;
  late String _selectedEmoji;
  bool _isGridVisible = false;
  bool _hasManuallySelectedEmoji = false;

  final List<String> _popularEmojis = [
    '🍔', '🍽️', '🛒', '🚗', '🚌', '✈️', '🏠', '🎬', '🎮', '💊', '🩺', '👕', '🐾', '👶', '📚', '💼', '💳', '💸', '🏦', '⚡', '💧', '📶', '📱', '🎉', '🎁', '🍷', '🍺', '☕', '🍵', '🌳', '🏊‍♂️', '🏖️'
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.categoryToEdit?.name ?? '');
    
    // Extraer emoji si existe
    _selectedEmoji = '🏷️';
    if (widget.categoryToEdit != null) {
      final isCodePoint = int.tryParse(widget.categoryToEdit!.icon) != null;
      if (!isCodePoint && widget.categoryToEdit!.icon.isNotEmpty) {
        _selectedEmoji = widget.categoryToEdit!.icon;
      } else {
        _selectedEmoji = IconToEmojiMapper.getEmoji(widget.categoryToEdit!.icon);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _autoSelectEmoji() {
    if (_hasManuallySelectedEmoji) return;
    
    final name = _nameController.text.toLowerCase();
    String suggested = '🏷️';
    
    if (name.contains('comida') || name.contains('food') || name.contains('restaurante') || name.contains('cena') || name.contains('almuerzo')) suggested = '🍽️';
    else if (name.contains('hamburguesa') || name.contains('fast food') || name.contains('chatarra')) suggested = '🍔';
    else if (name.contains('supermercado') || name.contains('despensa') || name.contains('mercado') || name.contains('compra') || name.contains('grocery')) suggested = '🛒';
    else if (name.contains('auto') || name.contains('carro') || name.contains('coche') || name.contains('gasolina') || name.contains('combustible') || name.contains('vehiculo')) suggested = '🚗';
    else if (name.contains('transporte') || name.contains('bus') || name.contains('colectivo') || name.contains('pasaje')) suggested = '🚌';
    else if (name.contains('viaje') || name.contains('vuelo') || name.contains('avion') || name.contains('turismo')) suggested = '✈️';
    else if (name.contains('casa') || name.contains('hogar') || name.contains('alquiler') || name.contains('renta') || name.contains('vivienda')) suggested = '🏠';
    else if (name.contains('cine') || name.contains('pelicula') || name.contains('entretenimiento') || name.contains('movie')) suggested = '🎬';
    else if (name.contains('juego') || name.contains('videojuego') || name.contains('gaming')) suggested = '🎮';
    else if (name.contains('salud') || name.contains('medico') || name.contains('farmacia') || name.contains('pastilla') || name.contains('medicina')) suggested = '💊';
    else if (name.contains('ropa') || name.contains('vestimenta') || name.contains('zapatos')) suggested = '👕';
    else if (name.contains('mascota') || name.contains('perro') || name.contains('gato') || name.contains('veterinario')) suggested = '🐾';
    else if (name.contains('hijo') || name.contains('bebe') || name.contains('nino') || name.contains('niño') || name.contains('escuela') || name.contains('colegio')) suggested = '👶';
    else if (name.contains('educacion') || name.contains('estudio') || name.contains('libro') || name.contains('curso') || name.contains('universidad')) suggested = '📚';
    else if (name.contains('trabajo') || name.contains('empleo') || name.contains('oficina') || name.contains('sueldo') || name.contains('salario') || name.contains('honorarios')) suggested = '💼';
    else if (name.contains('pago') || name.contains('tarjeta') || name.contains('credito') || name.contains('suscripcion')) suggested = '💳';
    else if (name.contains('dinero') || name.contains('efectivo') || name.contains('prestamo')) suggested = '💸';
    else if (name.contains('banco') || name.contains('ahorro') || name.contains('inversion')) suggested = '🏦';
    else if (name.contains('luz') || name.contains('electricidad') || name.contains('energia')) suggested = '⚡';
    else if (name.contains('agua')) suggested = '💧';
    else if (name.contains('internet') || name.contains('wifi') || name.contains('cable')) suggested = '📶';
    else if (name.contains('telefono') || name.contains('celular') || name.contains('movil')) suggested = '📱';
    else if (name.contains('fiesta') || name.contains('celebracion') || name.contains('evento')) suggested = '🎉';
    else if (name.contains('regalo') || name.contains('obsequio')) suggested = '🎁';
    else if (name.contains('vino') || name.contains('licor') || name.contains('alcohol')) suggested = '🍷';
    else if (name.contains('cerveza') || name.contains('bar') || name.contains('pub')) suggested = '🍺';
    else if (name.contains('cafe') || name.contains('cafeteria')) suggested = '☕';

    setState(() {
      _selectedEmoji = suggested;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: bottomInset > 0 ? bottomInset + 24 : 48,
      ),
      decoration: const BoxDecoration(
        color: V2Colors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          Center(
            child: Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: V2Colors.outlineVariant.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          Text(
            widget.categoryToEdit == null ? 'Nueva Categoría' : 'Editar Categoría',
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: V2Colors.onSurface,
            ),
          ),
          const SizedBox(height: 32),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Visual Emoji Picker Button
              GestureDetector(
                onTap: () {
                  // Ocultar teclado si está abierto
                  FocusScope.of(context).unfocus();
                  setState(() {
                    _isGridVisible = !_isGridVisible;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: widget.selectedType == 'E' 
                        ? V2Colors.errorContainer.withValues(alpha: 0.2)
                        : V2Colors.secondaryContainer.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _isGridVisible ? V2Colors.primary : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _selectedEmoji,
                    style: const TextStyle(fontSize: 36),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              
              // Name Input
              Expanded(
                child: TextField(
                  controller: _nameController,
                  onTap: () {
                    if (_isGridVisible) setState(() => _isGridVisible = false);
                  },
                  decoration: InputDecoration(
                    labelText: 'Nombre de la categoría',
                    labelStyle: const TextStyle(
                      fontFamily: 'Manrope',
                      color: V2Colors.outline,
                    ),
                    floatingLabelStyle: const TextStyle(
                      fontFamily: 'Manrope',
                      color: V2Colors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                    filled: true,
                    fillColor: V2Colors.surfaceContainerLowest,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: V2Colors.primary, width: 2),
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: V2Colors.onSurface,
                  ),
                  autofocus: widget.categoryToEdit == null,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (val) {
                    _autoSelectEmoji(); 
                  },
                ),
              ),
            ],
          ),
          
          // Emoji Grid Expandable Area
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _isGridVisible ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Selecciona un emoji',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: V2Colors.outline,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: V2Colors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: V2Colors.outlineVariant.withValues(alpha: 0.3)),
                  ),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: _popularEmojis.length,
                    itemBuilder: (context, index) {
                      final emoji = _popularEmojis[index];
                      final isSelected = emoji == _selectedEmoji;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedEmoji = emoji;
                            _isGridVisible = false;
                            _hasManuallySelectedEmoji = true;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          decoration: BoxDecoration(
                            color: isSelected ? V2Colors.primary.withValues(alpha: 0.1) : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? V2Colors.primary : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(emoji, style: const TextStyle(fontSize: 24)),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: V2Colors.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    final name = _nameController.text.trim();
                    if (name.isEmpty) return;
                    Navigator.pop(context); // Close bottom sheet
                    widget.onSave(name, _selectedEmoji);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: V2Colors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Guardar Categoría',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

