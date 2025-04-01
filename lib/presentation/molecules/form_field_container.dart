import 'package:flutter/material.dart';

/// Un contenedor estilizado para campos de formulario.
/// 
/// Este componente añade un estilo consistente para todos los campos
/// de formulario en la aplicación.
class FormFieldContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  
  const FormFieldContainer({
    Key? key, 
    required this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.3),
        ),
      ),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: child,
    );
  }
}
