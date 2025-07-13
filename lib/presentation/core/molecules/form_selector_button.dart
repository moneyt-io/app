import 'package:flutter/material.dart';
import '../design_system/theme/app_dimensions.dart';

/// Un botón estilizado y genérico para campos de formulario que requieren
/// abrir un selector o diálogo (ej. selector de fecha, cuenta, categoría).
///
/// Proporciona una apariencia consistente con un ícono, un texto principal
/// y un ícono de chevron a la derecha, alineado con el diseño HTML.
class FormSelectorButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconBackgroundColor;
  final Color? iconColor;
  final bool hasValue;
  final Widget? secondaryInfo;

  const FormSelectorButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.iconBackgroundColor,
    this.iconColor,
    this.hasValue = true,
    this.secondaryInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      child: Container(
        height: 64, // Altura consistente para todos los campos (h-14 + padding)
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing12),
        decoration: BoxDecoration(
          border: Border.all(color: colorScheme.outline.withOpacity(0.7)),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          color: theme.scaffoldBackgroundColor,
        ),
        child: Row(
          children: [
            // Ícono
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: iconBackgroundColor ?? colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 16,
                color: iconColor ?? colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: AppDimensions.spacing12),
            // Texto principal y secundario
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: hasValue ? colorScheme.onSurface : colorScheme.onSurfaceVariant,
                      fontWeight: hasValue ? FontWeight.w500 : FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (secondaryInfo != null) ...[
                    const SizedBox(height: 2),
                    secondaryInfo!,
                  ]
                ],
              ),
            ),
            // Chevron
            Icon(
              Icons.expand_more,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
