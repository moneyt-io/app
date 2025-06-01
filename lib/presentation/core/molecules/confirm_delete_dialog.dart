import 'package:flutter/material.dart';
import '../design_system/theme/app_dimensions.dart';

/// Molécula que muestra un diálogo de confirmación para eliminar elementos.
/// 
/// Este componente sigue las métricas de Material Design 3 y proporciona
/// una interfaz consistente para confirmar acciones de eliminación en toda la aplicación.
class ConfirmDeleteDialog extends StatelessWidget {
  /// El título principal del diálogo
  final String title;
  
  /// Mensaje descriptivo que explica las consecuencias
  final String message;
  
  /// Texto opcional para el botón de cancelar (por defecto "Cancelar")
  final String cancelText;
  
  /// Texto opcional para el botón de confirmar (por defecto "Eliminar")
  final String confirmText;
  
  /// Icono opcional (por defecto es un icono de advertencia)
  final IconData icon;
  
  /// Color del icono (por defecto el color de error del tema)
  final Color? iconColor;
  
  /// Si es verdadero, el diálogo usará un estilo "destructivo" más prominente
  final bool isDestructive;
  
  /// Constructor
  const ConfirmDeleteDialog({
    Key? key,
    required this.title,
    required this.message,
    this.cancelText = 'Cancelar',
    this.confirmText = 'Eliminar',
    this.icon = Icons.delete_forever,
    this.iconColor,
    this.isDestructive = true,
  }) : super(key: key);

  /// Método estático para mostrar el diálogo y obtener el resultado
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String? itemName,
    String cancelText = 'Cancelar',
    String confirmText = 'Eliminar',
    IconData icon = Icons.delete_forever,
    Color? iconColor,
    bool isDestructive = true,
  }) {
    // Si hay un nombre de elemento, lo incluimos en el mensaje
    final displayMessage = itemName != null 
        ? '$message "$itemName"?' 
        : '$message?';
        
    return showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDeleteDialog(
        title: title,
        message: displayMessage,
        cancelText: cancelText,
        confirmText: confirmText,
        icon: icon,
        iconColor: iconColor,
        isDestructive: isDestructive,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    // Determinar colores basados en isDestructive
    final effectiveIconColor = iconColor ?? 
        (isDestructive ? colorScheme.error : colorScheme.primary);
    
    final effectiveActionColor = isDestructive 
        ? colorScheme.error 
        : colorScheme.primary;
    
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      elevation: AppDimensions.elevationMedium, // CORREGIDO
      icon: Icon(
        icon,
        color: effectiveIconColor,
        size: AppDimensions.iconSizeLarge,
      ),
      title: Padding(
        padding: EdgeInsets.fromLTRB(
          AppDimensions.spacing24,
          0, // El icono ya proporciona espacio superior
          AppDimensions.spacing24,
          0, // Sin padding inferior ya que usamos un divider
        ),
        child: Column(
          children: [
            Text(
              title,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.spacing16),
            Divider(
              height: 1,
              thickness: 1,
              color: colorScheme.outlineVariant.withOpacity(0.5),
            ),
          ],
        ),
      ),
      content: Padding(
        padding: EdgeInsets.all(AppDimensions.spacing24),
        child: Text(
          message,
          style: textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actionsPadding: EdgeInsets.fromLTRB(
        AppDimensions.spacing16, 
        0, // Sin padding superior ya que el content ya tiene padding
        AppDimensions.spacing16,
        AppDimensions.spacing16,
      ),
      actions: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.spacing16,
              vertical: AppDimensions.spacing12,
            ),
            side: BorderSide(
              color: colorScheme.outline,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelText),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.spacing16,
              vertical: AppDimensions.spacing12,
            ),
            backgroundColor: effectiveActionColor,
            foregroundColor: colorScheme.onPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(confirmText),
        ),
      ],
    );
  }
}
