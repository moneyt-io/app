import 'package:flutter/material.dart';
import '../theme/app_dimensions.dart';

/// Componente para seleccionar un icono de una lista predefinida.
///
/// Este componente muestra una cuadrícula de iconos seleccionables con
/// una distribución uniforme y padding consistente para mantener la armonía visual.
class IconSelector extends StatefulWidget {
  /// Código hex del icono actualmente seleccionado
  final String selectedIconCode;

  /// Tipo de categoría (I: Ingreso, E: Gasto)
  final String categoryType;

  /// Función llamada cuando se selecciona un nuevo icono
  final Function(String iconCode) onIconSelected;

  const IconSelector({
    Key? key,
    required this.selectedIconCode,
    required this.categoryType,
    required this.onIconSelected,
  }) : super(key: key);

  @override
  State<IconSelector> createState() => _IconSelectorState();
}

class _IconSelectorState extends State<IconSelector> {
  // Lista de iconos disponibles
  final List<Map<String, dynamic>> _availableIcons = const [
    {'code': 'e56c', 'icon': Icons.restaurant},
    {'code': 'e531', 'icon': Icons.directions_car},
    {'code': 'e02c', 'icon': Icons.movie},
    {'code': 'e3f3', 'icon': Icons.medical_services},
    {'code': 'e8a1', 'icon': Icons.payments},
    {'code': 'e8e5', 'icon': Icons.trending_up},
    {'code': 'f37f', 'icon': Icons.shopping_bag},
    {'code': 'e88a', 'icon': Icons.home},
    {'code': 'e0f0', 'icon': Icons.lightbulb},
    {'code': 'e80c', 'icon': Icons.school},
    {'code': 'e8f6', 'icon': Icons.card_giftcard},
    {'code': 'e539', 'icon': Icons.flight},
  ];

  @override
  Widget build(BuildContext context) {
    // Centrar todo el contenedor de iconos
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center, // Centrar los iconos
        spacing: 12, // Espacio entre iconos
        runSpacing: 12, // Espacio entre filas
        children: _availableIcons.map((iconData) {
          return _buildIconOption(
            iconData['code'],
            iconData['icon'],
          );
        }).toList(),
      ),
    );
  }
  
  Widget _buildIconOption(String iconCode, IconData iconData) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = widget.selectedIconCode == iconCode;
    final isExpense = widget.categoryType == 'E';
    
    // Determinar colores basados en selección y tipo de categoría
    final bgColor = isSelected
        ? (isExpense ? colorScheme.errorContainer : colorScheme.primaryContainer)
        : colorScheme.surfaceVariant.withOpacity(0.3);
        
    final iconColor = isSelected
        ? (isExpense ? colorScheme.onErrorContainer : colorScheme.onPrimaryContainer)
        : colorScheme.onSurfaceVariant;

    // Usar un tamaño fijo para los iconos
    return SizedBox(
      width: 48, // Tamaño consistente
      height: 48,
      child: Material(
        color: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          side: isSelected
              ? BorderSide(
                  color: isExpense ? colorScheme.error : colorScheme.primary,
                  width: 2,
                )
              : BorderSide.none,
        ),
        child: InkWell(
          onTap: () => widget.onIconSelected(iconCode),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          child: Center(
            child: Icon(
              iconData,
              color: iconColor,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
