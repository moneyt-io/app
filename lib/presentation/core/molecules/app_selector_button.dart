import 'package:flutter/material.dart';
import '../design_system/theme/app_dimensions.dart';

class AppSelectorButton extends StatelessWidget {
  final String labelText;
  final String? valueText;
  final IconData? icon;
  final VoidCallback onTap;

  const AppSelectorButton({
    Key? key,
    required this.labelText,
    this.valueText,
    this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasValue = valueText != null && valueText!.isNotEmpty;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          prefixIcon: icon != null ? Icon(icon) : null,
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppDimensions.spacing16,
            horizontal: AppDimensions.spacing12,
          ),
        ),
        child: Text(
          hasValue ? valueText! : '',
          style: theme.textTheme.bodyLarge,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
