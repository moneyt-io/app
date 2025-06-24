import 'package:flutter/material.dart';
import '../atoms/card_color_button.dart';

/// Paleta de colores para selección de tarjetas de crédito
/// 
/// HTML Reference:
/// ```html
/// <div class="space-y-3">
///   <label class="text-sm font-medium text-slate-700">Card color</label>
///   <div class="grid grid-cols-4 gap-3">
///     <!-- 8 botones de colores -->
///   </div>
///   <p class="text-xs text-slate-500">Choose the color theme for your credit card</p>
/// </div>
/// ```
class CardColorPalette extends StatelessWidget {
  const CardColorPalette({
    Key? key,
    required this.selectedColor,
    required this.onColorChanged,
  }) : super(key: key);

  final CardColorType selectedColor;
  final Function(CardColorType) onColorChanged;

  /// Lista de todos los colores disponibles
  static const List<CardColorType> _availableColors = [
    CardColorType.blue,
    CardColorType.purple,
    CardColorType.green,
    CardColorType.red,
    CardColorType.orange,
    CardColorType.pink,
    CardColorType.slate,
    CardColorType.yellow,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          'Card color',
          style: const TextStyle(
            fontSize: 14, // HTML: text-sm
            fontWeight: FontWeight.w500, // HTML: font-medium
            color: Color(0xFF374151), // HTML: text-slate-700
          ),
        ),
        
        const SizedBox(height: 12), // HTML: space-y-3
        
        // Grid de colores
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // HTML: grid-cols-4
            crossAxisSpacing: 12, // HTML: gap-3
            mainAxisSpacing: 12,
            childAspectRatio: 1.0, // Botones cuadrados
          ),
          itemCount: _availableColors.length,
          itemBuilder: (context, index) {
            final colorType = _availableColors[index];
            return CardColorButton(
              colorType: colorType,
              isSelected: selectedColor == colorType,
              onPressed: () => onColorChanged(colorType),
            );
          },
        ),
        
        const SizedBox(height: 8), // HTML: space-y-3
        
        // Descripción
        Text(
          'Choose the color theme for your credit card',
          style: const TextStyle(
            fontSize: 12, // HTML: text-xs
            color: Color(0xFF64748B), // HTML: text-slate-500
          ),
        ),
      ],
    );
  }
}
