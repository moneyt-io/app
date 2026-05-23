import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../domain/entities/category.dart';
import '../../../../core/utils/icon_to_emoji_mapper.dart';
import '../../theme/v2_colors.dart';

class V2CategoryFormBottomSheet extends StatefulWidget {
  final Category? categoryToEdit;
  final String selectedType;
  final Function(String name, String emoji) onSave;

  const V2CategoryFormBottomSheet({
    super.key,
    this.categoryToEdit,
    required this.selectedType,
    required this.onSave,
  });

  @override
  State<V2CategoryFormBottomSheet> createState() => _V2CategoryFormBottomSheetState();
}

class _V2CategoryFormBottomSheetState extends State<V2CategoryFormBottomSheet> {
  late TextEditingController _nameController;
  late TextEditingController _emojiController;
  bool _hasManuallySelectedEmoji = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.categoryToEdit?.name ?? '');
    
    // Extraer emoji si existe
    String initialEmoji = '🏷️';
    if (widget.categoryToEdit != null) {
      initialEmoji = IconToEmojiMapper.getEmoji(widget.categoryToEdit!.icon);
    }
    _emojiController = TextEditingController(text: initialEmoji);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emojiController.dispose();
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

    if (_emojiController.text != suggested) {
      setState(() {
        _emojiController.text = suggested;
      });
    }
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
              // Emoji Input (Native Keyboard)
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: widget.selectedType == 'E' 
                      ? V2Colors.errorContainer.withValues(alpha: 0.2)
                      : V2Colors.secondaryContainer.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: TextField(
                  controller: _emojiController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 36),
                  showCursor: false,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'[a-zA-Z0-9\s]')),
                  ],
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (val) {
                    _hasManuallySelectedEmoji = true;
                    if (val.isEmpty) {
                      _emojiController.text = '🏷️';
                      return;
                    }
                    // Si hay más de un caracter (un emoji previo + el nuevo),
                    // nos quedamos solo con el último (el nuevo).
                    final chars = val.characters;
                    if (chars.length > 1) {
                      _emojiController.text = chars.last;
                      _emojiController.selection = TextSelection.fromPosition(
                        TextPosition(offset: _emojiController.text.length)
                      );
                    }
                  },
                ),
              ),
              const SizedBox(width: 20),
              
              // Name Input
              Expanded(
                child: TextField(
                  controller: _nameController,
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
                    
                    // Solo enviamos el primer carácter compuesto (el emoji)
                    String finalEmoji = _emojiController.text;
                    if (finalEmoji.isEmpty) finalEmoji = '🏷️';
                    
                    widget.onSave(name, finalEmoji);
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
