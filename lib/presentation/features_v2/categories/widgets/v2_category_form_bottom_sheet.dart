import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../../../../domain/entities/category.dart';
import '../../../../core/utils/icon_to_emoji_mapper.dart';
import '../../../../core/utils/financial_emoji_dictionary.dart';
import '../../../../core/services/ai_transaction_service.dart';
import '../../../core/l10n/generated/strings.g.dart';
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

class _V2CategoryFormBottomSheetState extends State<V2CategoryFormBottomSheet> with SingleTickerProviderStateMixin {
  late TextEditingController _nameController;
  String _selectedEmoji = "🏷️";
  List<String> _suggestedEmojis = ["🏷️", "💰", "✨"];
  bool _hasManuallySelectedEmoji = false;
  String _lastValidName = '';
  
  Timer? _debounceTimer;
  bool _isAnalyzingEmoji = false;
  final AITransactionService _aiService = AITransactionService();
  
  AnimationController? _aiAnimationController;

  @override
  void initState() {
    super.initState();
    _aiAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _nameController = TextEditingController(text: widget.categoryToEdit?.name ?? '');
    _lastValidName = _nameController.text;
    
    // Extraer emoji si existe
    if (widget.categoryToEdit != null) {
      _selectedEmoji = IconToEmojiMapper.getEmoji(widget.categoryToEdit!.icon);
      _suggestedEmojis = [_selectedEmoji];
      _hasManuallySelectedEmoji = true; // Previene que al editar el nombre se cambie el emoji automáticamente
    }
  }

  @override
  void dispose() {
    _aiAnimationController?.dispose();
    _debounceTimer?.cancel();
    _nameController.dispose();
    super.dispose();
  }

  void _onNameChanged(String val) {
    _debounceTimer?.cancel();
    
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
        _selectedEmoji = extractedEmoji;
        if (widget.categoryToEdit != null) {
          _suggestedEmojis = [extractedEmoji];
        } else if (!_suggestedEmojis.contains(extractedEmoji)) {
          _suggestedEmojis[0] = extractedEmoji;
        }
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
      _hasManuallySelectedEmoji = false;
      
      // Búsqueda instantánea en diccionario local
      _autoSelectEmojiLocal();
      
      // Configurar debounce para invocar IA
      if (!_hasManuallySelectedEmoji && val.trim().isNotEmpty) {
        _debounceTimer = Timer(const Duration(milliseconds: 1000), () {
          _analyzeEmojiWithAI(val.trim());
        });
      }
    }
  }

  void _autoSelectEmojiLocal() {
    if (_hasManuallySelectedEmoji) return;
    
    final name = _nameController.text;
    String? suggested = FinancialEmojiDictionary.getEmojiForKeyword(name);
    
    if (suggested != null && _selectedEmoji != suggested) {
      // Si está en el diccionario local, cancelar timer para no gastar IA
      _debounceTimer?.cancel();
      setState(() {
        _selectedEmoji = suggested;
        if (!_suggestedEmojis.contains(suggested)) {
          _suggestedEmojis = [suggested, '💰', '✨'];
        }
      });
    }
  }

  Future<void> _analyzeEmojiWithAI(String name) async {
    if (!mounted || _hasManuallySelectedEmoji) return;

    // Inicialización segura para Hot Reloads
    _aiAnimationController ??= AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    setState(() {
      _isAnalyzingEmoji = true;
      _aiAnimationController?.repeat();
    });

    try {
      final emojis = await _aiService.suggestEmojiForCategory(name);
      
      if (mounted && !_hasManuallySelectedEmoji) {
        setState(() {
          _suggestedEmojis = emojis;
          _selectedEmoji = emojis.isNotEmpty ? emojis.first : '🏷️';
        });
      }
    } catch (_) {
      // Silenciar error en UI, devolvemos fallback local
    } finally {
      if (mounted) {
        setState(() {
          _isAnalyzingEmoji = false;
          _aiAnimationController?.stop();
        });
      }
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
            widget.categoryToEdit == null ? t.v2.categories.newCategory : t.v2.categories.editCategory,
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
              // Name Input
              Expanded(
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: t.v2.categories.form.nameLabel,
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
              const SizedBox(width: 20),
              
              // Emoji Suggestions Pill
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: widget.selectedType == 'E' 
                      ? V2Colors.errorContainer.withValues(alpha: 0.1)
                      : V2Colors.secondaryContainer.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: widget.selectedType == 'E' 
                        ? V2Colors.errorContainer.withValues(alpha: 0.3)
                        : V2Colors.secondaryContainer.withValues(alpha: 0.3),
                  ),
                ),
                alignment: Alignment.center,
                child: _isAnalyzingEmoji && _aiAnimationController != null
                    ? AnimatedBuilder(
                        animation: _aiAnimationController!,
                        builder: (context, child) {
                          return Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: SweepGradient(
                                colors: [
                                  V2Colors.primary.withValues(alpha: 0.1),
                                  V2Colors.primary.withValues(alpha: 0.5),
                                  V2Colors.primary,
                                ],
                                transform: GradientRotation(_aiAnimationController!.value * 2 * 3.14159),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: V2Colors.surface, // Inner core para hacerlo ver como anillo
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: const Text('✨', style: TextStyle(fontSize: 10)),
                              ),
                            ),
                          );
                        },
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: _suggestedEmojis.map((emoji) {
                          final isSelected = emoji == _selectedEmoji;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedEmoji = emoji;
                                _hasManuallySelectedEmoji = true;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isSelected 
                                    ? (widget.selectedType == 'E' 
                                        ? V2Colors.errorContainer.withValues(alpha: 0.5)
                                        : V2Colors.secondaryContainer.withValues(alpha: 0.5))
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                emoji,
                                style: TextStyle(
                                  fontSize: isSelected ? 24 : 20,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
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
                  child: Text(
                    t.common.cancel,
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
                    
                    String finalEmoji = _selectedEmoji;
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
                  child: Text(
                    t.v2.categories.form.save,
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
