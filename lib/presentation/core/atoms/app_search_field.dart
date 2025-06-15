import 'package:flutter/material.dart';
import '../design_system/tokens/app_dimensions.dart';
import '../design_system/tokens/app_colors.dart';
import '../l10n/l10n_helper.dart'; // AGREGADO: helper de traducciones

/// Search field específico que match el diseño HTML con soporte i18n
/// 
/// Ejemplo de uso:
/// ```dart
/// AppSearchField(
///   controller: _searchController,
///   hintText: t.contacts.searchContacts,
///   onChanged: (value) => _handleSearch(value),
/// )
/// ```
class AppSearchField extends StatefulWidget {
  const AppSearchField({
    Key? key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onClear,
    this.autofocus = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final bool autofocus;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _clearText() {
    widget.controller?.clear();
    widget.onClear?.call();
    widget.onChanged?.call('');
  }

  bool get _hasText => widget.controller?.text.isNotEmpty == true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Container(
      height: AppDimensions.searchFieldHeight,
      decoration: BoxDecoration(
        color: AppColors.slate100.withOpacity(0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _isFocused 
            ? AppColors.primaryBlue 
            : AppColors.slate200,
          width: _isFocused ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Ícono de búsqueda
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Icon(
              Icons.search,
              size: AppDimensions.searchIconSize,
              color: AppColors.slate500,
            ),
          ),
          
          // Campo de texto
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              autofocus: widget.autofocus,
              onChanged: widget.onChanged,
              style: textTheme.bodyLarge?.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText ?? t.common.search, // CORREGIDO: usar traducciones
                hintStyle: textTheme.bodyLarge?.copyWith(
                  color: AppColors.slate500,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
              ),
            ),
          ),
          
          // Botón de limpiar (si hay texto)
          if (_hasText)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                onPressed: _clearText,
                icon: Icon(
                  Icons.clear,
                  size: 20,
                  color: AppColors.slate500,
                ),
                tooltip: t.common.clearSearch, // CORREGIDO: usar traducciones
              ),
            ),
        ],
      ),
    );
  }
}
