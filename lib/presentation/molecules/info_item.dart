import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData? icon;
  
  const InfoItem({
    Key? key,
    required this.title,
    required this.value,
    this.icon,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Row(
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            color: colorScheme.primary,
            size: 20,
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                value,
                style: textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
