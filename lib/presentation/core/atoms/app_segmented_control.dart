import 'package:flutter/material.dart';
import '../design_system/theme/app_dimensions.dart';

class AppSegmentedControl<T> extends StatelessWidget {
  final T selectedValue;
  final Map<T, String> segments;
  final ValueChanged<T> onValueChanged;

  const AppSegmentedControl({
    Key? key,
    required this.selectedValue,
    required this.segments,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.spacing4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Row(
        children: segments.entries.map((entry) {
          final value = entry.key;
          final text = entry.value;
          final isSelected = value == selectedValue;

          return Expanded(
            child: GestureDetector(
              onTap: () => onValueChanged(value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacing8),
                decoration: BoxDecoration(
                  color: isSelected ? theme.colorScheme.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: theme.colorScheme.shadow.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    text,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
