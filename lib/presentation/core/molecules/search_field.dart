import 'package:flutter/material.dart';
import '../atoms/app_text_field.dart';
import '../design_system/theme/app_dimensions.dart';

/// Molécula para un campo de búsqueda estandarizado.
///
/// Este componente proporciona un campo de texto con estilo de búsqueda
/// que incluye un icono y funcionalidad para limpiar el texto.
class SearchField extends StatefulWidget {
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
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      height: 48, // Altura específica del diseño
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24), // Rounded-full
        border: Border.all(
          color: _focusNode.hasFocus 
            ? const Color(0xFF0c7ff2) 
            : colorScheme.outline.withOpacity(0.2),
          width: _focusNode.hasFocus ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Ícono de búsqueda
          Padding(
            padding: EdgeInsets.only(left: AppDimensions.spacing16),
            child: Icon(
              Icons.search,
              color: colorScheme.onSurfaceVariant,
              size: 24,
            ),
          ),
          
          // Campo de texto
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacing12,
                  vertical: AppDimensions.spacing12,
                ),
              ),
            ),
          ),
          
          // Botón de limpiar (si hay texto)
          if (widget.controller?.text.isNotEmpty == true)
            IconButton(
              onPressed: widget.onClear,
              icon: Icon(
                Icons.clear,
                color: colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}
