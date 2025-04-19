import 'package:flutter/material.dart';
import '../../core/presentation/app_dimensions.dart';

/// Diálogo de confirmación reutilizable que sigue el patrón de diseño de la aplicación.
/// 
/// Se utiliza para confirmar acciones potencialmente destructivas o importantes.
class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String cancelText;
  final String confirmText;
  final IconData icon;
  final bool isDanger;
  final Color? confirmColor;

  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.message,
    this.cancelText = 'Cancelar',
    this.confirmText = 'Confirmar',
    required this.icon,
    this.isDanger = false,
    this.confirmColor,
  }) : super(key: key);

  /// Método estático para mostrar el diálogo fácilmente.
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    required IconData icon,
    String cancelText = 'Cancelar',
    String confirmText = 'Confirmar',
    bool isDanger = false,
    Color? confirmColor,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: title,
        message: message,
        cancelText: cancelText,
        confirmText: confirmText,
        icon: icon,
        isDanger: isDanger,
        confirmColor: confirmColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    final Color actionColor = isDanger 
        ? colorScheme.error 
        : (confirmColor ?? colorScheme.primary);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 0.0),
      titlePadding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 8.0),
      title: Row(
        children: [
          Icon(
            icon,
            color: actionColor,
            size: AppDimensions.iconSizeMedium,
          ),
          const SizedBox(width: AppDimensions.spacing8),
          Expanded(
            child: Text(
              title,
              style: textTheme.titleLarge?.copyWith(
                color: isDanger ? colorScheme.error : null,
              ),
            ),
          ),
        ],
      ),
      content: Text(
        message,
        style: textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            cancelText,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            confirmText,
            style: TextStyle(
              color: actionColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
