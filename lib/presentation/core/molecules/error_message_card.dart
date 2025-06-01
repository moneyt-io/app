import 'package:flutter/material.dart';
import '../design_system/theme/app_dimensions.dart';

class ErrorMessageCard extends StatelessWidget {
  final String message;
  final VoidCallback? onClose;
  
  const ErrorMessageCard({
    Key? key,
    required this.message,
    this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Card(
      elevation: 0,
      color: colorScheme.errorContainer,
      margin: const EdgeInsets.only(bottom: AppDimensions.spacing16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: colorScheme.error,
              size: AppDimensions.iconSizeMedium,
            ),
            SizedBox(width: AppDimensions.spacing12),
            Expanded(
              child: Text(
                message,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onErrorContainer,
                ),
              ),
            ),
            if (onClose != null)
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: colorScheme.onErrorContainer,
                  size: AppDimensions.iconSizeMedium,
                ),
                onPressed: onClose,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: AppDimensions.iconSizeMedium,
                  minHeight: AppDimensions.iconSizeMedium,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
