import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../design_system/tokens/app_dimensions.dart';

/// Tipos de campo de texto según Material Design 3
enum AppTextFieldType {
  outlined,   // Campo con borde (default)
  filled,     // Campo con fondo relleno
}

/// Componente de campo de texto unificado que sigue Material Design 3
/// 
/// Ejemplo de uso:
/// ```dart
/// AppTextField(
///   label: 'Email',
///   hint: 'Ingresa tu email',
///   controller: _emailController,
///   keyboardType: TextInputType.emailAddress,
///   validator: (value) => value?.isEmpty == true ? 'Campo requerido' : null,
/// )
/// ```
class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.type = AppTextFieldType.outlined,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  /// Controlador del campo de texto
  final TextEditingController? controller;
  
  /// Etiqueta del campo (label)
  final String? label;
  
  /// Texto de ayuda (hint)
  final String? hint;
  
  /// Texto de ayuda adicional debajo del campo
  final String? helperText;
  
  /// Texto de error
  final String? errorText;
  
  /// Icono al inicio del campo
  final IconData? prefixIcon;
  
  /// Icono al final del campo
  final Widget? suffixIcon;
  
  /// Si el texto debe estar oculto (passwords)
  final bool obscureText;
  
  /// Si el campo está habilitado
  final bool enabled;
  
  /// Si el campo es de solo lectura
  final bool readOnly;
  
  /// Número máximo de líneas
  final int? maxLines;
  
  /// Longitud máxima del texto
  final int? maxLength;
  
  /// Tipo de teclado
  final TextInputType? keyboardType;
  
  /// Acción del botón de envío del teclado
  final TextInputAction? textInputAction;
  
  /// Formateadores de entrada
  final List<TextInputFormatter>? inputFormatters;
  
  /// Función de validación
  final String? Function(String?)? validator;
  
  /// Callback cuando cambia el texto
  final ValueChanged<String>? onChanged;
  
  /// Callback cuando se envía el texto
  final ValueChanged<String>? onSubmitted;
  
  /// Callback cuando se toca el campo
  final VoidCallback? onTap;
  
  /// Tipo visual del campo
  final AppTextFieldType type;
  
  /// Si debe obtener el foco automáticamente
  final bool autofocus;
  
  /// Tipo de capitalización
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          onTap: onTap,
          obscureText: obscureText,
          enabled: enabled,
          readOnly: readOnly,
          maxLines: maxLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          autofocus: autofocus,
          textCapitalization: textCapitalization,
          style: textTheme.bodyLarge?.copyWith(
            color: enabled 
                ? colorScheme.onSurface 
                : colorScheme.onSurface.withOpacity(0.38),
          ),
          decoration: _buildInputDecoration(context),
        ),
        if (helperText != null && errorText == null)
          Padding(
            padding: EdgeInsets.only(
              left: AppDimensions.spacing16,
              top: AppDimensions.spacing4,
            ),
            child: Text(
              helperText!,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return InputDecoration(
      labelText: label,
      hintText: hint,
      errorText: errorText,
      prefixIcon: prefixIcon != null 
          ? Icon(
              prefixIcon,
              color: enabled 
                  ? colorScheme.onSurfaceVariant 
                  : colorScheme.onSurface.withOpacity(0.38),
              size: AppDimensions.iconSizeMedium,
            )
          : null,
      suffixIcon: suffixIcon,
      
      // Styling según el tipo
      filled: type == AppTextFieldType.filled,
      fillColor: type == AppTextFieldType.filled 
          ? colorScheme.surfaceVariant.withOpacity(0.12)
          : null,
      
      // Bordes
      border: _getBorder(colorScheme.outline),
      enabledBorder: _getBorder(colorScheme.outline),
      focusedBorder: _getBorder(colorScheme.primary, width: 2.0),
      errorBorder: _getBorder(colorScheme.error),
      focusedErrorBorder: _getBorder(colorScheme.error, width: 2.0),
      disabledBorder: _getBorder(colorScheme.onSurface.withOpacity(0.12)),
      
      // Colores de texto
      labelStyle: textTheme.bodyLarge?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      hintStyle: textTheme.bodyLarge?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      errorStyle: textTheme.bodySmall?.copyWith(
        color: colorScheme.error,
      ),
      
      // Padding
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing16,
        vertical: AppDimensions.spacing16,
      ),
    );
  }

  InputBorder _getBorder(Color color, {double width = 1.0}) {
    if (type == AppTextFieldType.filled) {
      return UnderlineInputBorder(
        borderSide: BorderSide(color: color, width: width),
      );
    }
    
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
