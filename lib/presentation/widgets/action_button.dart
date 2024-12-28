import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.onPressed,
    required this.icon,
    this.backgroundColor,
    required this.label,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget icon;
  final Color? backgroundColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: backgroundColor ?? theme.colorScheme.secondary,
      elevation: 4.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onPressed,
            icon: icon,
            color: Colors.white,
          ),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: backgroundColor ?? theme.colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
