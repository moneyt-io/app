import 'package:flutter/material.dart';
import '../../core/presentation/app_dimensions.dart';

/// Opciones predefinidas para el menú de acciones.
enum ActionMenuOption {
  edit(Icons.edit_outlined, 'Editar'),
  view(Icons.visibility_outlined, 'Ver detalle'),
  delete(Icons.delete_outline, 'Eliminar');

  final IconData icon;
  final String label;

  const ActionMenuOption(this.icon, this.label);
}

/// Botón de menú de acciones que sigue el patrón de diseño de la aplicación.
/// 
/// Muestra un menú con opciones configurables al pulsar.
class ActionMenuButton extends StatelessWidget {
  final List<ActionMenuOption> options;
  final Function(ActionMenuOption) onOptionSelected;
  final Color? iconColor;
  
  const ActionMenuButton({
    Key? key,
    required this.options,
    required this.onOptionSelected,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return PopupMenuButton<ActionMenuOption>(
      icon: Icon(
        Icons.more_vert,
        size: AppDimensions.iconSizeMedium,
        color: iconColor ?? colorScheme.onSurfaceVariant,
      ),
      padding: EdgeInsets.zero,
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      itemBuilder: (context) => options.map((option) {
        final isDelete = option == ActionMenuOption.delete;
        final itemColor = isDelete ? colorScheme.error : colorScheme.primary;
        
        return PopupMenuItem(
          value: option,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                option.icon, 
                color: itemColor, 
                size: AppDimensions.iconSizeMedium
              ),
              const SizedBox(width: AppDimensions.spacing8),
              Text(
                option.label,
                style: TextStyle(
                  color: isDelete ? colorScheme.error : null,
                  fontWeight: isDelete ? FontWeight.w500 : null,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      onSelected: onOptionSelected,
    );
  }
}
