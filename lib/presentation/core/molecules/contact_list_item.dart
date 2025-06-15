import 'package:flutter/material.dart';
import '../../../domain/entities/contact.dart';
import '../atoms/app_avatar.dart';
import '../atoms/app_icon_button.dart';
import '../design_system/tokens/app_dimensions.dart';
import '../design_system/tokens/app_colors.dart';

/// Contact list item que match el diseño HTML exactamente
/// 
/// Ejemplo de uso:
/// ```dart
/// ContactListItem(
///   contact: contact,
///   onTap: () => _navigateToDetail(contact),
///   onEdit: () => _editContact(contact),
///   onDelete: () => _deleteContact(contact),
/// )
/// ```
class ContactListItem extends StatelessWidget {
  const ContactListItem({
    Key? key,
    required this.contact,
    this.onTap,
    this.onMorePressed,
  }) : super(key: key);

  final Contact contact;
  final VoidCallback? onTap;
  final VoidCallback? onMorePressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing16,
          vertical: AppDimensions.spacing12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: AppColors.slate100,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // Avatar
            AppAvatar(
              name: contact.name,
              size: AppAvatarSize.medium,
            ),
            
            SizedBox(width: AppDimensions.spacing16),
            
            // Información del contacto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre
                  Text(
                    contact.name,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.slate800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  SizedBox(height: AppDimensions.spacing2),
                  
                  // Información de contacto
                  Text(
                    _getContactInfo(),
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.slate500,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // Botón de más opciones
            AppIconButton(
              icon: Icons.more_vert,
              type: AppIconButtonType.header,
              onPressed: onMorePressed,
            ),
          ],
        ),
      ),
    );
  }

  String _getContactInfo() {
    if (contact.phone?.isNotEmpty == true) {
      return 'Mobile · ${contact.phone}';
    } else if (contact.email?.isNotEmpty == true) {
      return contact.email!;
    } else {
      return 'Sin información de contacto';
    }
  }
}
