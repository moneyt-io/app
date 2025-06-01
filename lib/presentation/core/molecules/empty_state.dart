import 'package:flutter/material.dart';
import '../atoms/app_icon.dart';
import '../design_system/tokens/app_dimensions.dart';

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
        padding: EdgeInsets.all(AppDimensions.spacing24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIconContainer(
              iconData: icon,
              size: AppIconSize.xLarge,
              backgroundColor: colorScheme.surfaceVariant,
              iconColor: colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: AppDimensions.spacing24),
            Text(
              title,
              style: textTheme.headlineSmall?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.spacing12),
            Text(
              message,
              style: textTheme.bodyLarge?.copyWith(
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
