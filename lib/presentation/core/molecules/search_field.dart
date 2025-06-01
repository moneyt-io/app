import 'package:flutter/material.dart';
import '../atoms/app_text_field.dart';

/// Molécula para un campo de búsqueda estandarizado.
///
/// Este componente proporciona un campo de texto con estilo de búsqueda
/// que incluye un icono y funcionalidad para limpiar el texto.
class SearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final bool autofocus;

  const SearchField({
    Key? key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onClear,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      hint: hintText ?? 'Buscar...',
      prefixIcon: Icons.search,
      suffixIcon: controller?.text.isNotEmpty == true
          ? IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                controller?.clear();
                onClear?.call();
                onChanged?.call('');
              },
            )
          : null,
      onChanged: onChanged,
      autofocus: autofocus,
      type: AppTextFieldType.outlined,
    );
  }
}
