import 'package:flutter/material.dart';

/// Drag handle component que replica el diseño HTML
/// 
/// HTML Reference:
/// ```html
/// <button class="drag-handle flex items-center justify-center h-8 w-8 rounded-lg bg-slate-100 text-slate-500 hover:bg-slate-200 cursor-grab active:cursor-grabbing">
///   <span class="material-symbols-outlined text-lg">drag_indicator</span>
/// </button>
/// ```
class DragHandle extends StatefulWidget {
  const DragHandle({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;

  @override
  State<DragHandle> createState() => _DragHandleState();
}

class _DragHandleState extends State<DragHandle> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: Container(
        width: 32, // HTML: h-8 w-8
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), // HTML: rounded-lg
          color: _isPressed 
              ? const Color(0xFFE2E8F0) // HTML: active:bg-slate-200
              : const Color(0xFFF1F5F9), // HTML: bg-slate-100
        ),
        child: const Icon(
          Icons.drag_indicator,
          size: 20, // HTML: text-lg
          color: Color(0xFF64748B), // HTML: text-slate-500
        ),
      ),
    );
  }
}
