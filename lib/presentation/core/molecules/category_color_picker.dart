import 'package:flutter/material.dart';
import '../l10n/generated/strings.g.dart';

/// Selector de colores para categorías basado en category_form.html
/// 
/// HTML Reference:
/// ```html
/// <div class="grid grid-cols-8 gap-2">
///   <button class="h-10 w-10 rounded-full bg-blue-500 border-2 border-white shadow-sm ring-2 ring-blue-300">
/// ```
class CategoryColorPicker extends StatelessWidget {
  const CategoryColorPicker({
    Key? key,
    required this.selectedColor,
    required this.onColorSelected,
  }) : super(key: key);

  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;

  static const List<Color> _categoryColors = [
    Color(0xFF3B82F6), // blue-500
    Color(0xFF10B981), // emerald-500
    Color(0xFFF59E0B), // amber-500
    Color(0xFFEF4444), // red-500
    Color(0xFF8B5CF6), // violet-500
    Color(0xFF06B6D4), // cyan-500
    Color(0xFFEC4899), // pink-500
    Color(0xFF84CC16), // lime-500
    Color(0xFF6366F1), // indigo-500
    Color(0xFF14B8A6), // teal-500
    Color(0xFFF97316), // orange-500
    Color(0xFF64748B), // slate-500
    Color(0xFF059669), // emerald-600
    Color(0xFFDC2626), // red-600
    Color(0xFF7C3AED), // violet-600
    Color(0xFF0891B2), // cyan-600
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.categories.form.selectColor,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151), // HTML: text-gray-700
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E7EB)), // HTML: border-gray-200
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8, // HTML: grid-cols-8
              mainAxisSpacing: 8, // HTML: gap-2
              crossAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: _categoryColors.length,
            itemBuilder: (context, index) {
              final color = _categoryColors[index];
              final isSelected = color == selectedColor;
              
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onColorSelected(color),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 40, // HTML: h-10
                    width: 40, // HTML: w-10
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // HTML: rounded-full
                      color: color,
                      border: Border.all(
                        width: isSelected ? 3 : 2,
                        color: isSelected 
                            ? Colors.white
                            : Colors.white,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isSelected 
                              ? color.withOpacity(0.5)
                              : const Color(0x1A000000),
                          blurRadius: isSelected ? 4 : 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
