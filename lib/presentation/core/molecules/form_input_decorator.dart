import 'package:flutter/material.dart';

class FormInputDecorator extends StatelessWidget {
  final String label;
  final Widget child;
  final bool isFocused;

  const FormInputDecorator({
    Key? key,
    required this.label,
    required this.child,
    this.isFocused = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = isFocused ? theme.primaryColor : const Color(0xFFCBD5E1); // slate-300

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 56, // h-14
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1.5),
            borderRadius: BorderRadius.circular(8), // rounded-lg
            color: const Color(0xFFF8FAFC), // slate-50
          ),
          child: child,
        ),
        Positioned(
          top: -8,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            color: const Color(0xFFF8FAFC), // slate-50
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isFocused ? theme.primaryColor : const Color(0xFF64748B), // slate-500
              ),
            ),
          ),
        ),
      ],
    );
  }
}
