import 'package:flutter/material.dart';
import '../core/design/app_dimensions.dart';

/// Molécula para un campo de búsqueda estandarizado.
///
/// Este componente proporciona un campo de texto con estilo de búsqueda
/// que incluye un icono y funcionalidad para limpiar el texto.
class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;
  
  const SearchField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.3),
        ),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            Icons.search,
            color: colorScheme.onSurfaceVariant,
            size: AppDimensions.iconSizeMedium,
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: colorScheme.onSurfaceVariant,
                    size: AppDimensions.iconSizeMedium,
                  ),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                    if (onClear != null) onClear!();
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppDimensions.spacing12,
          ),
        ),
      ),
    );
  }
}
