import 'package:flutter/material.dart';

/// Tipos de colores de tarjetas disponibles
enum CardColorType {
  blue,
  purple,
  green,
  red,
  orange,
  pink,
  slate,
  yellow,
}

/// Botón de selección de color para tarjetas de crédito
/// 
/// HTML Reference:
/// ```html
/// <button class="flex items-center justify-center h-16 w-full rounded-lg border-2 border-blue-500 bg-gradient-to-br from-blue-500 to-blue-600 text-white shadow-md">
///   <span class="material-symbols-outlined">credit_card</span>
/// </button>
/// ```
class CardColorButton extends StatelessWidget {
  const CardColorButton({
    Key? key,
    required this.colorType,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  final CardColorType colorType;
  final bool isSelected;
  final VoidCallback onPressed;

  /// Obtiene los colores del gradiente según el tipo
  List<Color> get _gradientColors {
    switch (colorType) {
      case CardColorType.blue:
        return [const Color(0xFF3B82F6), const Color(0xFF2563EB)]; // from-blue-500 to-blue-600
      case CardColorType.purple:
        return [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)]; // from-purple-500 to-purple-600
      case CardColorType.green:
        return [const Color(0xFF10B981), const Color(0xFF059669)]; // from-green-500 to-green-600
      case CardColorType.red:
        return [const Color(0xFFEF4444), const Color(0xFFDC2626)]; // from-red-500 to-red-600
      case CardColorType.orange:
        return [const Color(0xFFF97316), const Color(0xFFEA580C)]; // from-orange-500 to-orange-600
      case CardColorType.pink:
        return [const Color(0xFFEC4899), const Color(0xFFDB2777)]; // from-pink-500 to-pink-600
      case CardColorType.slate:
        return [const Color(0xFF64748B), const Color(0xFF475569)]; // from-slate-600 to-slate-700
      case CardColorType.yellow:
        return [const Color(0xFFEAB308), const Color(0xFFCA8A04)]; // from-yellow-500 to-yellow-600
    }
  }

  /// Obtiene el color del borde cuando está seleccionado
  Color get _selectedBorderColor {
    switch (colorType) {
      case CardColorType.blue:
        return const Color(0xFF2563EB); // HTML: border-blue-500
      case CardColorType.purple:
        return const Color(0xFF7C3AED); // border-purple-500
      case CardColorType.green:
        return const Color(0xFF059669); // border-green-500
      case CardColorType.red:
        return const Color(0xFFDC2626); // border-red-500
      case CardColorType.orange:
        return const Color(0xFFEA580C); // border-orange-500
      case CardColorType.pink:
        return const Color(0xFFDB2777); // border-pink-500
      case CardColorType.slate:
        return const Color(0xFF475569); // border-slate-500
      case CardColorType.yellow:
        return const Color(0xFFCA8A04); // border-yellow-500
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
        child: Container(
          height: 64, // HTML: h-16
          width: double.infinity, // HTML: w-full
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft, // HTML: bg-gradient-to-br
              end: Alignment.bottomRight,
              colors: _gradientColors,
            ),
            borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
            border: Border.all(
              width: isSelected ? 2 : 1, // HTML: border-2 when selected
              color: isSelected 
                  ? _selectedBorderColor
                  : const Color(0xFFCBD5E1), // HTML: border-slate-300
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000), // HTML: shadow-md
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.credit_card, // HTML: material-symbols-outlined credit_card
              color: Colors.white, // HTML: text-white
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
