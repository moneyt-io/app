import 'package:flutter/material.dart';
import '../design_system/tokens/app_dimensions.dart';

/// Tamaños estandarizados para iconos según Material Design 3
enum AppIconSize {
  small,      // 16px
  medium,     // 24px (default)
  large,      // 32px
  xLarge,     // 48px
}

/// Componente de icono unificado que sigue Material Design 3
/// 
/// Ejemplo de uso:
/// ```dart
/// AppIcon(
///   Icons.home,
///   size: AppIconSize.medium,
///   color: Colors.blue,
/// )
/// ```
class AppIcon extends StatelessWidget {
  const AppIcon(
    this.iconData, {
    Key? key,
    this.size = AppIconSize.medium,
    this.color,
    this.semanticLabel,
  }) : super(key: key);

  /// IconData del icono a mostrar
  final IconData iconData;
  
  /// Tamaño del icono
  final AppIconSize size;
  
  /// Color del icono (opcional, usa el color del theme si no se especifica)
  final Color? color;
  
  /// Etiqueta semántica para accesibilidad
  final String? semanticLabel;

  /// Obtiene el tamaño numérico según el enum
  double get _sizeValue {
    switch (size) {
      case AppIconSize.small:
        return AppDimensions.iconSizeSmall;
      case AppIconSize.medium:
        return AppDimensions.iconSizeMedium;
      case AppIconSize.large:
        return AppDimensions.iconSizeLarge;
      case AppIconSize.xLarge:
        return AppDimensions.iconSizeXLarge;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Icon(
      iconData,
      size: _sizeValue,
      color: color ?? colorScheme.onSurface,
      semanticLabel: semanticLabel,
    );
  }
}

/// Widget de icono con contenedor circular de fondo
/// Útil para avatares, botones de acción, etc.
class AppIconContainer extends StatelessWidget {
  const AppIconContainer({
    Key? key,
    required this.iconData,
    this.size = AppIconSize.large,
    this.backgroundColor,
    this.iconColor,
    this.onTap,
    this.semanticLabel,
  }) : super(key: key);

  /// IconData del icono a mostrar
  final IconData iconData;
  
  /// Tamaño del contenedor e icono
  final AppIconSize size;
  
  /// Color de fondo del contenedor
  final Color? backgroundColor;
  
  /// Color del icono
  final Color? iconColor;
  
  /// Callback cuando se toca el contenedor
  final VoidCallback? onTap;
  
  /// Etiqueta semántica para accesibilidad
  final String? semanticLabel;

  /// Tamaño del contenedor según el tamaño del icono
  double get _containerSize {
    switch (size) {
      case AppIconSize.small:
        return 32.0;
      case AppIconSize.medium:
        return 40.0;
      case AppIconSize.large:
        return 48.0;
      case AppIconSize.xLarge:
        return 64.0;
    }
  }

  /// Tamaño del icono (proporcionalmente menor al contenedor)
  AppIconSize get _iconSize {
    switch (size) {
      case AppIconSize.small:
        return AppIconSize.small;
      case AppIconSize.medium:
      case AppIconSize.large:
        return AppIconSize.medium;
      case AppIconSize.xLarge:
        return AppIconSize.large;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    Widget container = Container(
      width: _containerSize,
      height: _containerSize,
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: AppIcon(
          iconData,
          size: _iconSize,
          color: iconColor ?? colorScheme.onPrimaryContainer,
          semanticLabel: semanticLabel,
        ),
      ),
    );

    if (onTap != null) {
      container = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_containerSize / 2),
        child: container,
      );
    }

    return container;
  }
}
