import 'package:flutter/material.dart';

/// Botón individual para selección de tipo de categoría (Income/Expense)
/// 
/// Garantiza consistencia visual entre CategoryFormScreen y CategoriesScreen
class CategoryTypeButton extends StatelessWidget {
  const CategoryTypeButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.isSelected,
    required this.onPressed,
    this.selectedColor = const Color(0xFF22C55E),
    this.selectedBackgroundColor = const Color(0x1A22C55E),
    this.selectedBorderColor = const Color(0xFF86EFAC),
    this.unselectedColor = const Color(0xFF64748B),
    this.unselectedBackgroundColor = const Color(0xFFF1F5F9),
    this.unselectedBorderColor = const Color(0xFFE2E8F0),
  }) : super(key: key);

  final String text;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;
  final Color selectedColor;
  final Color selectedBackgroundColor;
  final Color selectedBorderColor;
  final Color unselectedColor;
  final Color unselectedBackgroundColor;
  final Color unselectedBorderColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 40, // HTML: h-10
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(20), // HTML: rounded-full
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? selectedBackgroundColor : unselectedBackgroundColor,
                borderRadius: BorderRadius.circular(20), // HTML: rounded-full
                border: Border.all(
                  color: isSelected ? selectedBorderColor : unselectedBorderColor,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 18, // HTML: text-lg
                    color: isSelected ? selectedColor : unselectedColor,
                  ),
                  const SizedBox(width: 8), // HTML: mr-2
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 14, // HTML: text-sm
                      fontWeight: FontWeight.w500, // HTML: font-medium
                      color: isSelected ? selectedColor : unselectedColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
