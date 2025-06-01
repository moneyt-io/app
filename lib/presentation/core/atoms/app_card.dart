import 'package:flutter/material.dart';
import '../design_system/tokens/app_dimensions.dart';

/// Tipos de elevación para las cards según Material Design 3
enum AppCardElevation {
  none,       // 0dp - Para cards en superficie
  low,        // 1dp - Elevación sutil
  medium,     // 3dp - Elevación estándar
  high,       // 6dp - Elevación prominente
}

/// Componente de Card unificado que sigue Material Design 3
/// 
/// Ejemplo de uso:
/// ```dart
/// AppCard(
///   elevation: AppCardElevation.medium,
///   padding: EdgeInsets.all(16),
///   onTap: () => _handleTap(),
///   child: Text('Contenido de la card'),
/// )
/// ```
class AppCard extends StatelessWidget {
  const AppCard({
    Key? key,
    required this.child,
    this.elevation = AppCardElevation.low,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.borderRadius,
    this.width,
    this.height,
  }) : super(key: key);

  /// Widget hijo que se muestra dentro de la card
  final Widget child;
  
  /// Nivel de elevación de la card
  final AppCardElevation elevation;
  
  /// Padding interno de la card
  final EdgeInsetsGeometry? padding;
  
  /// Margin externo de la card
  final EdgeInsetsGeometry? margin;
  
  /// Callback cuando se toca la card (hace que sea interactiva)
  final VoidCallback? onTap;
  
  /// Color de fondo personalizado (opcional)
  final Color? backgroundColor;
  
  /// Radio de esquinas personalizado (opcional)
  final BorderRadius? borderRadius;
  
  /// Ancho específico (opcional)
  final double? width;
  
  /// Alto específico (opcional)
  final double? height;

  /// Obtiene la elevación numérica según el tipo
  double get _elevationValue {
    switch (elevation) {
      case AppCardElevation.none:
        return 0.0;
      case AppCardElevation.low:
        return AppDimensions.elevation1;
      case AppCardElevation.medium:
        return AppDimensions.elevation3;
      case AppCardElevation.high:
        return AppDimensions.elevation6; // CORREGIDO: usar elevation6 del design system
    }
  }

  /// Border radius por defecto
  BorderRadius get _defaultBorderRadius {
    return BorderRadius.circular(AppDimensions.radiusMedium);
  }

  /// Padding por defecto
  EdgeInsetsGeometry get _defaultPadding {
    return EdgeInsets.all(AppDimensions.spacing16);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    Widget cardContent = Container(
      width: width,
      height: height,
      padding: padding ?? _defaultPadding,
      child: child,
    );

    Widget card = Card(
      elevation: _elevationValue,
      color: backgroundColor ?? colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? _defaultBorderRadius,
      ),
      margin: EdgeInsets.zero,
      child: cardContent,
    );

    if (onTap != null) {
      card = InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? _defaultBorderRadius,
        child: card,
      );
    }

    if (margin != null) {
      card = Container(
        margin: margin,
        child: card,
      );
    }

    return card;
  }
}
