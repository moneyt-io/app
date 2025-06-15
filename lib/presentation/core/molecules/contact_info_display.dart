import 'package:flutter/material.dart';
import '../atoms/app_icon.dart';
import '../design_system/tokens/app_dimensions.dart';
import '../design_system/tokens/app_colors.dart';
import '../l10n/l10n_helper.dart';

/// Estados simples que puede mostrar un contacto (solo campos reales)
enum ContactInfoType {
  mobile,     // Mobile · number
  email,      // Email · address  
  none,       // Sin información
}

/// Component para mostrar información real del contacto
/// Solo usa campos que existen en la entidad Contact
/// 
/// Ejemplo de uso:
/// ```dart
/// ContactInfoDisplay(
///   type: ContactInfoType.mobile,
///   value: '+57 300 123 4567',
/// )
/// ```
class ContactInfoDisplay extends StatelessWidget {
  const ContactInfoDisplay({
    Key? key,
    required this.type,
    this.value,
  }) : super(key: key);

  final ContactInfoType type;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Row(
      children: [
        // Ícono según el tipo
        if (_getIcon() != null) ...[
          AppIcon(
            _getIcon()!,
            size: AppIconSize.small,
            color: AppColors.textSecondary,
          ),
          SizedBox(width: AppDimensions.spacing4),
        ],
        
        // Texto de la información
        Expanded(
          child: Text(
            _getDisplayText(),
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  IconData? _getIcon() {
    switch (type) {
      case ContactInfoType.mobile:
        return Icons.phone;
      case ContactInfoType.email:
        return Icons.email;
      case ContactInfoType.none:
        return null;
    }
  }

  String _getDisplayText() {
    switch (type) {
      case ContactInfoType.mobile:
        return 'Mobile · ${value ?? ''}';
      case ContactInfoType.email:
        return 'Email · ${value ?? ''}';
      case ContactInfoType.none:
        return t.contacts.noContactInfo ?? 'Sin información de contacto';
    }
  }
}
