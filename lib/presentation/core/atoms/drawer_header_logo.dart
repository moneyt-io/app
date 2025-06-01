import 'package:flutter/material.dart';

class DrawerHeaderLogo extends StatelessWidget {
  final String title;
  final IconData icon;
  final double iconSize;
  
  const DrawerHeaderLogo({
    Key? key,
    required this.title,
    this.icon = Icons.account_balance_wallet,
    this.iconSize = 48,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          icon,
          size: iconSize,
          color: colorScheme.onPrimaryContainer,
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: textTheme.headlineSmall?.copyWith(
            color: colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
