import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Campo de texto de múltiples líneas (TextArea)
/// 
/// Especializado para descripciones, notas y comentarios largos
/// 
/// Ejemplo de uso:
/// ```dart
/// AppTextArea(
///   controller: _notesController,
///   label: 'Notes',
///   placeholder: 'Enter additional notes...',
///   maxLines: 4,
/// )
/// ```
class AppTextArea extends StatefulWidget {
  const AppTextArea({
    Key? key,
    this.controller,
    required this.label,
    this.placeholder,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.maxLines = 4,
    this.maxLength,
    this.textCapitalization = TextCapitalization.sentences,
    this.inputFormatters,
  }) : super(key: key);

  final TextEditingController? controller;
  final String label;
  final String? placeholder;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final int maxLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<AppTextArea> createState() => _AppTextAreaState();
}

class _AppTextAreaState extends State<AppTextArea> {
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
    final double height = (widget.maxLines * 24.0) + 32.0 + 12.0; // 24px per line + padding + label space
    
    return Container(
      height: height,
      child: Stack(
        children: [
          // Text field
          Positioned(
            top: 12,
            left: 0,
            right: 0,
            bottom: 0,
            child: TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              validator: widget.validator,
              onChanged: widget.onChanged,
              enabled: widget.enabled,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              textCapitalization: widget.textCapitalization,
              inputFormatters: widget.inputFormatters,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0F172A),
                height: 1.5,
              ),
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF94A3B8),
                ),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFCBD5E1),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFCBD5E1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF3B82F6),
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFEF4444),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                counterText: '', // Hide character counter
              ),
            ),
          ),
          
          // Floating label
          Positioned(
            left: 12,
            top: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              color: const Color(0xFFF8FAFC),
              child: Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
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
