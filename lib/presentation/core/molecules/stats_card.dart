import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final double amount;
  final IconData iconData;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;

  const StatsCard({
    Key? key,
    required this.title,
    required this.amount,
    required this.iconData,
    required this.backgroundColor,
    required this.iconColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Card(
      elevation: 0,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  iconData,
                  size: 18,
                  color: iconColor,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    color: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              NumberFormat.currency(symbol: '\$').format(amount),
              style: textTheme.titleLarge?.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
