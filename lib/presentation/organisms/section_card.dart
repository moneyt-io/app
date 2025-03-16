import 'package:flutter/material.dart';
import '../atoms/app_card.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final IconData? icon;
  final VoidCallback? onAction;
  final String? actionLabel;

  const SectionCard({
    Key? key,
    required this.title,
    required this.children,
    this.icon,
    this.onAction,
    this.actionLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              if (onAction != null && actionLabel != null)
                TextButton(
                  onPressed: onAction,
                  child: Text(actionLabel!),
                ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}
