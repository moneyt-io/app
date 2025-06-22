import 'package:flutter/material.dart';
import '../atoms/category_type_button.dart';

/// Filtro de tipo de categoría que usa botones atomizados
/// 
/// Garantiza consistencia visual en todas las pantallas
class CategoryTypeFilter extends StatelessWidget {
  const CategoryTypeFilter({
    Key? key,
    required this.selectedType,
    required this.onTypeChanged,
  }) : super(key: key);

  final String selectedType;
  final Function(String) onTypeChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Income Button
        CategoryTypeButton(
          text: 'Income',
          icon: Icons.trending_up,
          isSelected: selectedType == 'I',
          onPressed: () => onTypeChanged('I'),
          selectedColor: const Color(0xFF22C55E), // green-600
          selectedBackgroundColor: const Color(0x1A22C55E), // green-500/10
          selectedBorderColor: const Color(0xFF86EFAC), // green-300
        ),
        
        const SizedBox(width: 8), // HTML: gap-2
        
        // Expense Button  
        CategoryTypeButton(
          text: 'Expense',
          icon: Icons.trending_down,
          isSelected: selectedType == 'E',
          onPressed: () => onTypeChanged('E'),
          selectedColor: const Color(0xFFEF4444), // red-500
          selectedBackgroundColor: const Color(0x1AEF4444), // red-500/10
          selectedBorderColor: const Color(0xFFFCA5A5), // red-300
        ),
      ],
    );
  }
}
    