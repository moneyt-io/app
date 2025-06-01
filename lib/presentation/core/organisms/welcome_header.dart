import 'package:flutter/material.dart';

class WelcomeHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double iconSize;
  final IconData icon;

  const WelcomeHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.iconSize = 72,
    this.icon = Icons.account_balance_wallet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: iconSize,
          color: colorScheme.primary,
        ),
        const SizedBox(height: 24),
        Text(
          title,
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
