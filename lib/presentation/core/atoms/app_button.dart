import 'package:flutter/material.dart';
import '../design_system/tokens/app_dimensions.dart';

/// Tipos de botones disponibles según Material Design 3
enum AppButtonType {
  elevated,   // Botón principal con elevación
  filled,     // Botón sólido (más prominente)
  outlined,   // Botón con borde
  text,       // Botón de texto simple
}

/// Tamaños de botones disponibles
enum AppButtonSize {
  small,      // 32px height
  medium,     // 40px height  
  large,      // 48px height (default)
}

/// Componente de botón unificado que sigue Material Design 3
/// 
/// Ejemplo de uso:
/// ```dart
/// AppButton(
///   text: 'Guardar',
///   onPressed: () => _save(),
///   type: AppButtonType.filled,
///   size: AppButtonSize.large,
/// )
/// ```
class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.type = AppButtonType.filled,
    this.size = AppButtonSize.large,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.enabled = true,
  }) : super(key: key);

  /// Texto del botón
  final String text;
  
  /// Callback cuando se presiona el botón
  final VoidCallback? onPressed;
  
  /// Tipo de botón (visual style)
  final AppButtonType type;
  
  /// Tamaño del botón
  final AppButtonSize size;
  
  /// Icono opcional (se muestra a la izquierda del texto)
  final IconData? icon;
  
  /// Estado de carga (muestra CircularProgressIndicator)
  final bool isLoading;
  
  /// Si ocupa todo el ancho disponible
  final bool isFullWidth;
  
  /// Si el botón está habilitado
  final bool enabled;

  /// Altura según el tamaño
  double get _height {
    switch (size) {
      case AppButtonSize.small:
        return AppDimensions.buttonHeightSmall;
      case AppButtonSize.medium:
        return AppDimensions.buttonHeightMedium;
      case AppButtonSize.large:
        return AppDimensions.buttonHeightLarge;
    }
  }

  /// Ancho mínimo según el tamaño
  double get _minWidth {
    switch (size) {
      case AppButtonSize.small:
        return 64.0;
      case AppButtonSize.medium:
        return 72.0;
      case AppButtonSize.large:
        return 88.0;
    }
  }

  /// Padding horizontal según el tamaño
  double get _horizontalPadding {
    switch (size) {
      case AppButtonSize.small:
        return AppDimensions.spacing12;
      case AppButtonSize.medium:
        return AppDimensions.spacing16;
      case AppButtonSize.large:
        return AppDimensions.spacing24;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = !enabled || onPressed == null || isLoading;
    
    Widget button = _buildButtonByType(context, isDisabled);
    
    if (isFullWidth) {
      button = SizedBox(
        width: double.infinity,
        child: button,
      );
    }
    
    return button;
  }

  Widget _buildButtonByType(BuildContext context, bool isDisabled) {
    final buttonStyle = _getBaseButtonStyle(context);
    
    switch (type) {
      case AppButtonType.elevated:
        return ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: buttonStyle,
          child: _buildButtonChild(),
        );
      
      case AppButtonType.filled:
        return FilledButton(
          onPressed: isDisabled ? null : onPressed,
          style: buttonStyle,
          child: _buildButtonChild(),
        );
      
      case AppButtonType.outlined:
        return OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: buttonStyle,
          child: _buildButtonChild(),
        );
      
      case AppButtonType.text:
        return TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: buttonStyle,
          child: _buildButtonChild(),
        );
    }
  }

  ButtonStyle _getBaseButtonStyle(BuildContext context) {
    return ButtonStyle(
      minimumSize: MaterialStateProperty.all(
        Size(_minWidth, _height),
      ),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(horizontal: _horizontalPadding),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        ),
      ),
    );
  }

  Widget _buildButtonChild() {
    if (isLoading) {
      return SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            _getLoadingColor(),
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: _getIconSize()),
          SizedBox(width: AppDimensions.spacing8),
          Text(text),
        ],
      );
    }

    return Text(text);
  }

  Color _getLoadingColor() {
    // En un contexto real, usaríamos Theme.of(context)
    // pero como es un atom, mantenemos la lógica simple
    switch (type) {
      case AppButtonType.filled:
        return Colors.white;
      case AppButtonType.elevated:
      case AppButtonType.outlined:
      case AppButtonType.text:
        return Colors.blue; // Se usará el color del theme
    }
  }

  double _getIconSize() {
    switch (size) {
      case AppButtonSize.small:
        return AppDimensions.iconSizeSmall;
      case AppButtonSize.medium:
        return AppDimensions.iconSizeMedium;
      case AppButtonSize.large:
        return AppDimensions.iconSizeMedium;
    }
  }
}
