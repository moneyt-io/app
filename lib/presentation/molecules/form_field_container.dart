import 'package:flutter/material.dart';
import '../../core/presentation/app_dimensions.dart';

/// Un contenedor estilizado para campos de formulario siguiendo Material Design 3.
/// 
/// Este componente añade un estilo consistente para todos los campos
/// de formulario en la aplicación, usando bordes redondeados, colores dinámicos
/// y espaciado estándar.
class FormFieldContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool isOptional;
  final String? helperText;
  final VoidCallback? onTap;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingIconPressed;
  
  const FormFieldContainer({
    Key? key, 
    required this.child,
    this.padding,
    this.isOptional = false,
    this.helperText,
    this.onTap,
    this.trailingIcon,
    this.onTrailingIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    Widget fieldWidget = child;
    
    // Si tiene onTap, lo envolvemos en un InkWell
    if (onTap != null) {
      fieldWidget = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        child: AbsorbPointer(child: fieldWidget),
      );
    }
    
    // Añadimos un trailing icon si es necesario
    if (trailingIcon != null) {
      fieldWidget = Row(
        children: [
          Expanded(child: fieldWidget),
          IconButton(
            icon: Icon(
              trailingIcon,
              color: colorScheme.primary,
            ),
            onPressed: onTrailingIconPressed,
          ),
        ],
      );
    }
    
    // Añadimos el texto de ayuda si existe
    if (helperText != null) {
      fieldWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fieldWidget,
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 16),
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
    
    // Añadimos el indicador de campo opcional si corresponde
    if (isOptional) {
      fieldWidget = Stack(
        children: [
          fieldWidget,
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
              ),
              child: Text(
                'Opcional',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      );
    }
    
    // Ya no necesitamos un Container adicional para los bordes
    // pues los TextField usarán directamente OutlinedInputBorder
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: fieldWidget,
    );
  }
  
  /// Método estático para aplicar un estilo consistente de OutlinedInputBorder
  /// a todos los TextFormField de la aplicación.
  static InputDecoration getOutlinedDecoration(
    BuildContext context, {
    String? labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? errorText,
    bool? enabled,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      errorText: errorText,
      enabled: enabled ?? true,
      
      // Configuración para obtener un OutlinedTextField según Material Design 3
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        borderSide: BorderSide(
          color: colorScheme.outline,
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        borderSide: BorderSide(
          color: colorScheme.outline.withOpacity(0.5),
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        borderSide: BorderSide(
          color: colorScheme.error,
          width: 1.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        borderSide: BorderSide(
          color: colorScheme.error,
          width: 2.0,
        ),
      ),
      
      // Estilos adicionales para Material Design 3
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      alignLabelWithHint: true,
      isDense: false,  // Cambiado a false para dar más espacio
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,  // Aumentado a 20 para más altura
      ),
      
      // Colores para los diferentes estados
      fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
      filled: true,
    );
  }
}
