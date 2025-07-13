import 'package:flutter/material.dart';

class FormFieldWrapper extends StatelessWidget {
  final String label;
  final Widget child;

  const FormFieldWrapper({
    Key? key,
    required this.label,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // El campo de formulario (TextFormField, FormSelectorButton, etc.)
        // Se añade un Padding superior para dar espacio a la etiqueta
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: child,
        ),
        // La etiqueta posicionada encima
        Positioned(
          top: 0,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            color: const Color(0xFFF8FAFC), // bg-slate-50
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF64748B), // text-slate-500
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
