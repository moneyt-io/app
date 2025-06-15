import 'package:flutter/material.dart';
import '../design_system/tokens/app_dimensions.dart';
import '../design_system/tokens/app_colors.dart';
import '../l10n/l10n_helper.dart'; // AGREGADO: helper de traducciones

/// FAB personalizado que match el diseño HTML exactamente con soporte i18n
/// 
/// Ejemplo de uso:
/// ```dart
/// AppFloatingActionButton(
///   onPressed: () => _navigateToForm(),
///   icon: Icons.add,
///   tooltip: t.contacts.addContact,
/// )
/// ```
class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton({
    Key? key,
    required this.onPressed,
    this.icon = Icons.add,
    this.tooltip,
    this.backgroundColor,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;
  final String? tooltip;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? t.common.save, // CORREGIDO: tooltip por defecto traducido
      child: Container(
        width: AppDimensions.fabSize,
        height: AppDimensions.fabSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.fabBorderRadius),
          color: backgroundColor ?? AppColors.primaryBlue,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(AppDimensions.fabBorderRadius),
            child: Center(
              child: Icon(
                icon,
                size: AppDimensions.fabIconSize,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
