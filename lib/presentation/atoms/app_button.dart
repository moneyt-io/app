import 'package:flutter/material.dart';

enum AppButtonType {
  primary,
  secondary,
  outlined,
  text,
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool isFullWidth;
  final IconData? icon;
  final double? iconSize;
  final bool isLoading; // Nuevo parámetro

  const AppButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.isFullWidth = false,
    this.icon,
    this.iconSize,
    this.isLoading = false, // Valor por defecto
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Si está cargando, mostrar indicador de progreso
    if (isLoading) {
      return _buildLoadingButton(context);
    }

    Widget buttonChild = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: iconSize,
          ),
          const SizedBox(width: 8),
        ],
        Text(text),
      ],
    );

    switch (type) {
      case AppButtonType.primary:
        return FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            minimumSize: isFullWidth ? const Size(double.infinity, 48) : null,
          ),
          child: buttonChild,
        );
      case AppButtonType.secondary:
        return FilledButton.tonal(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            minimumSize: isFullWidth ? const Size(double.infinity, 48) : null,
          ),
          child: buttonChild,
        );
      case AppButtonType.text:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            minimumSize: isFullWidth ? const Size(double.infinity, 48) : null,
          ),
          child: buttonChild,
        );
      case AppButtonType.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: isFullWidth ? const Size(double.infinity, 48) : null,
          ),
          child: buttonChild,
        );
    }
  }

  // Método para construir el botón en estado de carga
  Widget _buildLoadingButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    // Crear un botón deshabilitado con indicador de carga
    Widget button;
    switch (type) {
      case AppButtonType.primary:
        button = ElevatedButton(
          onPressed: null, // Deshabilitado mientras carga
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary.withOpacity(0.7),
            foregroundColor: colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20, 
                height: 20, 
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(colorScheme.onPrimary),
                ),
              ),
              const SizedBox(width: 12),
              Text(text),
            ],
          ),
        );
        break;
      // Implementar casos similares para los otros tipos de botón
      default:
        button = ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary.withOpacity(0.7),
            foregroundColor: colorScheme.onPrimary,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20, 
                height: 20, 
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(colorScheme.onPrimary),
                ),
              ),
              const SizedBox(width: 12),
              Text(text),
            ],
          ),
        );
    }
    
    // Aplicar ancho completo si es necesario
    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }
    
    return button;
  }
}
