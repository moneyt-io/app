import 'package:flutter/material.dart';

enum AppButtonType {
  primary,
  secondary,
  text,
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool isFullWidth;
  final IconData? icon;
  final double? iconSize;
  
  const AppButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.isFullWidth = false,
    this.icon,
    this.iconSize,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    Widget buttonChild = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: iconSize,
          ),
          const SizedBox(width: 8),
        ],
        Text(text),
      ],
    );
    
    switch (type) {
      case AppButtonType.primary:
        return FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            minimumSize: isFullWidth ? const Size(double.infinity, 48) : null,
          ),
          child: buttonChild,
        );
      case AppButtonType.secondary:
        return FilledButton.tonal(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            minimumSize: isFullWidth ? const Size(double.infinity, 48) : null,
          ),
          child: buttonChild,
        );
      case AppButtonType.text:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            minimumSize: isFullWidth ? const Size(double.infinity, 48) : null,
          ),
          child: buttonChild,
        );
    }
  }
}
