import 'package:flutter/material.dart';
import '../core/design/app_dimensions.dart';

/// Molécula que muestra un estado vacío o mensajes de "no hay datos".
///
/// Este componente proporciona un mensaje visuales consistente para
/// las situaciones en las que no hay datos para mostrar.
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final Widget? action;
  
  const EmptyState({
    Key? key,
    required this.icon,
    required this.title,
    required this.message,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppDimensions.iconSizeXLarge,
              color: colorScheme.primary.withOpacity(0.6),
            ),
            SizedBox(height: AppDimensions.spacing16),
            Text(
              title,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.spacing8),
            Text(
              message,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              SizedBox(height: AppDimensions.spacing24),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
