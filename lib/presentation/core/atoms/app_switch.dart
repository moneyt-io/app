import 'package:flutter/material.dart';

/// Switch reutilizable basado en los diseños HTML
/// 
/// HTML Reference:
/// ```html
/// <button class="relative inline-flex h-6 w-11 items-center rounded-full bg-blue-600">
///   <span class="inline-block h-4 w-4 transform rounded-full bg-white transition translate-x-6">
/// ```
class AppSwitch extends StatelessWidget {
  const AppSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.label,
    this.activeColor = const Color(0xFF3B82F6),
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF374151), // HTML: text-gray-700
            ),
          ),
          const SizedBox(width: 12),
        ],
        GestureDetector(
          onTap: () => onChanged(!value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44, // HTML: w-11
            height: 24, // HTML: h-6
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), // HTML: rounded-full
              color: value 
                  ? activeColor // HTML: bg-blue-600
                  : const Color(0xFFD1D5DB), // HTML: bg-gray-300
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 16, // HTML: w-4
                height: 16, // HTML: h-4
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle, // HTML: rounded-full
                  color: Colors.white, // HTML: bg-white
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
