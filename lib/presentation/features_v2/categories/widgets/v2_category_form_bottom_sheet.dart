import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../domain/entities/category.dart';
import '../../../../core/utils/icon_to_emoji_mapper.dart';
import '../../../../core/utils/financial_emoji_dictionary.dart';
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
  String _lastValidName = '';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.categoryToEdit?.name ?? '');
    _lastValidName = _nameController.text;
    
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

  void _onNameChanged(String val) {
    final chars = val.characters;
    String extractedEmoji = '';
    String newText = '';

    for (var c in chars) {
      // Detección de rangos comunes de Emojis Unicode
      bool isEmoji = c.runes.any((r) => 
        (r >= 0x2600 && r <= 0x27BF) || // Dingbats & Misc Symbols
        (r >= 0x1F300 && r <= 0x1FAFF)  // Emoticons, Transport, Pictographs, etc.
      );
      
      if (isEmoji) {
        extractedEmoji = c;
      } else {
        newText += c;
      }
    }

    if (extractedEmoji.isNotEmpty) {
      _hasManuallySelectedEmoji = true;
      setState(() {
        _emojiController.text = extractedEmoji;
      });
      
      // Si el autocorrector del iPhone reemplazó toda la palabra por el emoji,
      // el newText estará vacío. Restauramos la última palabra que recordamos.
      if (newText.trim().isEmpty && _lastValidName.isNotEmpty) {
        newText = _lastValidName;
      }
      
      // Actualizamos el campo de nombre sin el emoji y restaurando el texto
      _nameController.value = TextEditingValue(
        text: newText,
        selection: TextSelection.fromPosition(TextPosition(offset: newText.length)),
      );
      _lastValidName = newText;
    } else {
      _lastValidName = val;
      _autoSelectEmoji();
    }
  }

  void _autoSelectEmoji() {
    if (_hasManuallySelectedEmoji) return;
    
    final name = _nameController.text;
    String suggested = FinancialEmojiDictionary.getEmojiForKeyword(name) ?? '🏷️';
    
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
                  onChanged: _onNameChanged,
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
