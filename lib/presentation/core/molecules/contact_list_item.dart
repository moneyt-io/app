import 'package:flutter/material.dart';
import '../../../domain/entities/contact.dart';
import '../design_system/theme/app_dimensions.dart';
import '../atoms/action_menu_button.dart';

class ContactListItem extends StatelessWidget {
  final Contact contact;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;
  // Añadir estos parámetros si son necesarios:
  final VoidCallback? onCall;
  final VoidCallback? onEmail;

  const ContactListItem({
    Key? key,
    required this.contact,
    required this.onTap,
    required this.onDelete,
    this.onEdit,
    this.onCall,
    this.onEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: AppDimensions.spacing8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        side: BorderSide(
          color: colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacing16),
          child: Row(
            children: [
              // Icono con fondo circular
              Container(
                width: AppDimensions.spacing40,
                height: AppDimensions.spacing40,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  color: colorScheme.onPrimaryContainer,
                  size: AppDimensions.iconSizeMedium,
                ),
              ),
              const SizedBox(width: AppDimensions.spacing16),
              
              // Información principal
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (contact.email != null && contact.email!.isNotEmpty) ...[
                      const SizedBox(height: AppDimensions.spacing4),
                      Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: AppDimensions.iconSizeSmall,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: AppDimensions.spacing4),
                          Text(
                            contact.email!,
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (contact.phone != null && contact.phone!.isNotEmpty) ...[
                      const SizedBox(height: AppDimensions.spacing4),
                      Row(
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            size: AppDimensions.iconSizeSmall,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: AppDimensions.spacing4),
                          Text(
                            contact.phone!,
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              
              // Menú de acciones usando el átomo
              ActionMenuButton(
                options: [
                  ActionMenuOption.edit,
                  ActionMenuOption.view,
                  ActionMenuOption.delete,
                ],
                onOptionSelected: (option) {
                  switch (option) {
                    case ActionMenuOption.edit:
                      onTap();
                      break;
                    case ActionMenuOption.delete:
                      onDelete();
                      break;
                    case ActionMenuOption.view:
                      // Implementar si es necesario
                      break;
                    case ActionMenuOption.pay:
                      // No aplica para contactos
                      break;
                    default:
                      break;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
