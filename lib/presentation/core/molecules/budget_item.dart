import 'package:flutter/material.dart';
import '../atoms/budget_progress_bar.dart';

class BudgetItem extends StatelessWidget {
  final String category;
  final double used;
  final double total;
  final Color progressColor;
  
  const BudgetItem({
    Key? key,
    required this.category,
    required this.used,
    required this.total,
    required this.progressColor,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final percentage = (used / total).clamp(0.0, 1.0);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category,
              style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              '\$${used.toStringAsFixed(0)}/\$${total.toStringAsFixed(0)}',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        BudgetProgressBar(
          value: percentage,
          backgroundColor: colorScheme.surfaceVariant,
          progressColor: progressColor,
        ),
      ],
    );
  }
}
