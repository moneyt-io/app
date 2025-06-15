import 'package:flutter/material.dart';
import '../design_system/tokens/app_dimensions.dart';
import '../design_system/tokens/app_colors.dart';
import '../l10n/l10n_helper.dart'; // AGREGADO: helper de traducciones

/// Tipos de icon button según el diseño
enum AppIconButtonType {
  standard,   // Botón estándar
  header,     // Botones del header (back, menu)
  favorite,   // Botón de favorito
}

/// Icon button component que match el diseño HTML
/// 
/// Ejemplo de uso:
/// ```dart
/// AppIconButton(
///   icon: Icons.arrow_back,
///   type: AppIconButtonType.header,
///   onPressed: () => Navigator.pop(context),
/// )
/// ```
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.type = AppIconButtonType.standard,
    this.tooltip,
    this.color,
    this.isActive = false,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onPressed;
  final AppIconButtonType type;
  final String? tooltip;
  final Color? color;
  final bool isActive;

  /// Obtiene el tamaño según el tipo
  double get _buttonSize {
    switch (type) {
      case AppIconButtonType.header:
        return 40.0; // Match del diseño HTML
      case AppIconButtonType.favorite:
        return 40.0;
      case AppIconButtonType.standard:
        return 48.0;
    }
  }

  /// Obtiene el tamaño del ícono según el tipo
  double get _iconSize {
    switch (type) {
      case AppIconButtonType.header:
        return 24.0;
      case AppIconButtonType.favorite:
        return 24.0;
      case AppIconButtonType.standard:
        return AppDimensions.iconSizeMedium;
    }
  }

  /// Obtiene el color según el tipo y estado
  Color _getIconColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    if (color != null) return color!;
    
    switch (type) {
      case AppIconButtonType.header:
        return AppColors.slate600;
      case AppIconButtonType.favorite:
        return isActive ? AppColors.primaryBlue : AppColors.slate500;
      case AppIconButtonType.standard:
        return colorScheme.onSurfaceVariant;
    }
  }

  /// Obtiene el tooltip por defecto según el tipo
  String _getDefaultTooltip() {
    switch (type) {
      case AppIconButtonType.header:
        if (icon == Icons.arrow_back) return t.common.cancel; // Volver
        if (icon == Icons.more_vert) return 'Más opciones'; // Por ahora hardcoded
        return '';
      case AppIconButtonType.favorite:
        return isActive ? 'Quitar de favoritos' : 'Agregar a favoritos'; // Por ahora hardcoded
      case AppIconButtonType.standard:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _buttonSize,
      height: _buttonSize,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(_buttonSize / 2),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_buttonSize / 2),
            ),
            child: Center(
              child: Icon(
                icon,
                size: _iconSize,
                color: _getIconColor(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
