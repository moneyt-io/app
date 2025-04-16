import 'package:flutter/material.dart';
import '../../core/presentation/app_dimensions.dart';

/// Molécula que representa un chip para filtrar categorías.
///
/// Este componente se usa para mostrar opciones de filtrado en forma de chips
/// seleccionables.
class CategoryFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;
  final IconData? icon;
  final Color? selectedColor;

  const CategoryFilterChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
    this.icon,
    this.selectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    // Color personalizado o colores por defecto de Material 3
    final chipColor = selectedColor ?? colorScheme.primaryContainer;
    final textColor = isSelected ? (selectedColor != null 
        ? Theme.of(context).colorScheme.onPrimaryContainer 
        : chipColor.computeLuminance() > 0.5 
          ? Colors.black 
          : Colors.white)
        : colorScheme.onSurface;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      showCheckmark: false,
      avatar: icon != null ? Icon(
        icon, 
        size: AppDimensions.iconSizeSmall,
        color: isSelected ? textColor : colorScheme.onSurfaceVariant,
      ) : null,
      selectedColor: chipColor,
      onSelected: (_) => onSelected(),
      labelStyle: TextStyle(
        color: textColor,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing8,
        vertical: AppDimensions.spacing4,
      ),
    );
  }
}
