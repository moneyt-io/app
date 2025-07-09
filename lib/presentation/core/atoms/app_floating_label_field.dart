import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Campo de texto con label flotante que replica exactamente el diseño HTML
/// 
/// HTML Reference:
/// ```html
/// <input class="form-input w-full rounded-lg border-slate-300 bg-slate-50 text-slate-900 placeholder-slate-400 focus:border-blue-500 focus:ring-blue-500 h-14 px-4 text-base font-normal leading-normal" />
/// ```
/// 
/// Altura exacta: h-14 = 56px (exacto como en HTML)
/// 
/// Ejemplo de uso:
/// ```dart
/// AppFloatingLabelField(
///   controller: _nameController,
///   label: 'Full name',
///   placeholder: 'Enter full name',
///   validator: _validateName,
/// )
/// ```
class AppFloatingLabelField extends StatefulWidget {
  const AppFloatingLabelField({
    Key? key,
    this.controller,
    required this.label,
    this.placeholder,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.autofocus = false,
    this.maxLines = 1,
  }) : super(key: key);

  final TextEditingController? controller;
  final String label;
  final String? placeholder;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final int maxLines;

  @override
  State<AppFloatingLabelField> createState() => _AppFloatingLabelFieldState();
}

class _AppFloatingLabelFieldState extends State<AppFloatingLabelField> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      // ✅ CORREGIDO: Altura total ajustada para campo h-14 + label flotante
      height: 68, // 56px (h-14) + 12px para label flotante = 68px total
      child: Stack(
        children: [
          // Text field - altura exacta h-14 como en HTML
          Positioned(
            top: 12, // ✅ AJUSTADO: Espacio suficiente para label flotante
            left: 0,
            right: 0,
            bottom: 0, // ✅ ESTO DA 56px de altura (68-12=56px)
            child: TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              validator: widget.validator,
              onChanged: widget.onChanged,
              onFieldSubmitted: widget.onSubmitted,
              enabled: widget.enabled,
              obscureText: widget.obscureText,
              textCapitalization: widget.textCapitalization,
              inputFormatters: widget.inputFormatters,
              autofocus: widget.autofocus,
              maxLines: widget.maxLines,
              style: const TextStyle(
                fontSize: 16, // HTML: text-base
                fontWeight: FontWeight.w400, // HTML: font-normal
                color: Color(0xFF0F172A), // HTML: text-slate-900
                height: 1.25, // HTML: leading-normal
              ),
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: const TextStyle(
                  fontSize: 16, // HTML: text-base
                  color: Color(0xFF94A3B8), // HTML: placeholder-slate-400
                ),
                filled: true,
                fillColor: const Color(0xFFF8FAFC), // HTML: bg-slate-50
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
                  borderSide: const BorderSide(
                    color: Color(0xFFCBD5E1), // HTML: border-slate-300
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFCBD5E1), // HTML: border-slate-300
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF3B82F6), // HTML: focus:border-blue-500
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFEF4444), // HTML: border-red-500
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFEF4444),
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16, // HTML: px-4
                  vertical: 18, // ✅ AUMENTADO: Más padding vertical para h-14
                ),
              ),
            ),
          ),
          
          // Floating label - posicionado exactamente como HTML -top-2
          Positioned(
            left: 12, // HTML: left-3 (12px)
            top: 4, // ✅ AJUSTADO: HTML usa -top-2, posicionado correctamente
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4), // HTML: px-1
              color: const Color(0xFFF8FAFC), // HTML: bg-slate-50
              child: Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 12, // HTML: text-xs
                  color: Color(0xFF64748B), // HTML: text-slate-500
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
