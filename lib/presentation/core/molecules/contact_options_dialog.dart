import 'package:flutter/material.dart';
import '../../../domain/entities/contact.dart';
import '../atoms/app_avatar.dart';
import '../design_system/tokens/app_dimensions.dart';
import '../design_system/tokens/app_colors.dart';
import '../l10n/l10n_helper.dart';

/// Opciones disponibles en el diálogo de contacto
enum ContactOption {
  call,
  message,
  share,
  edit,
  delete,
}

/// Bottom sheet dialog que muestra opciones para un contacto específico
/// Basado en contact_dialog_options.html
class ContactOptionsDialog extends StatelessWidget {
  const ContactOptionsDialog({
    Key? key,
    required this.contact,
    required this.onOptionSelected,
  }) : super(key: key);

  final Contact contact;
  final Function(ContactOption) onOptionSelected;

  /// Método estático para mostrar el diálogo
  static Future<void> show({
    required BuildContext context,
    required Contact contact,
    required Function(ContactOption) onOptionSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Fondo transparente para control manual
      barrierColor: Colors.black.withOpacity(0.3), // ✅ CORREGIDO: bg-black/30 del HTML
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => ContactOptionsDialog(
        contact: contact,
        onOptionSelected: onOptionSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ SIMPLIFICADO: Sin overlay manual, showModalBottomSheet maneja el fondo
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16), // HTML: rounded-t-2xl
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000), // HTML: shadow-lg
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // ✅ CLAVE: Solo el tamaño necesario
        children: [
          // Drag handle
          Container(
            width: double.infinity,
            height: 24,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Container(
                width: 40,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1), // HTML: bg-slate-300
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),

          // Contact header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFF1F5F9),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                AppAvatar(
                  name: contact.name,
                  size: AppAvatarSize.medium,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _getContactInfo(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (contact.phone?.isNotEmpty == true)
                      _buildQuickActionButton(
                        icon: Icons.call,
                        backgroundColor: const Color(0xFFDCFCE7),
                        iconColor: const Color(0xFF16A34A),
                        onPressed: () => onOptionSelected(ContactOption.call),
                      ),
                    const SizedBox(width: 4),
                    _buildQuickActionButton(
                      icon: Icons.message,
                      backgroundColor: const Color(0xFFDBEAFE),
                      iconColor: const Color(0xFF2563EB),
                      onPressed: () => onOptionSelected(ContactOption.message),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Options list
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8), // HTML: px-2 pb-2
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOptionItem(
                  icon: Icons.share,
                  label: 'Share contact',
                  onTap: () => _handleOptionTap(context, ContactOption.share),
                ),
                _buildOptionItem(
                  icon: Icons.edit,
                  label: 'Edit contact',
                  onTap: () => _handleOptionTap(context, ContactOption.edit),
                ),
                _buildOptionItem(
                  icon: Icons.delete,
                  label: 'Delete contact',
                  onTap: () => _handleOptionTap(context, ContactOption.delete),
                  isDestructive: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Construye botón de acción rápida (call/message)
  Widget _buildQuickActionButton({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            size: 18,
            color: iconColor,
          ),
        ),
      ),
    );
  }

  /// Construye item de opción en la lista
  Widget _buildOptionItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final iconColor = isDestructive 
        ? const Color(0xFFDC2626) // HTML: text-red-600
        : const Color(0xFF374151); // HTML: text-slate-700

    final textColor = isDestructive 
        ? const Color(0xFFDC2626) // HTML: text-red-600
        : const Color(0xFF1E293B); // HTML: text-slate-800

    final hoverColor = isDestructive
        ? const Color(0xFFFEF2F2) // HTML: hover:bg-red-50
        : const Color(0xFFF8FAFC); // HTML: hover:bg-slate-100

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        splashColor: hoverColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // HTML: px-4 py-3
          child: Row(
            children: [
              Icon(
                icon,
                size: 24, // Material icons outlined
                color: iconColor,
              ),
              const SizedBox(width: 16), // HTML: gap-4
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16, // HTML: text-base
                    fontWeight: FontWeight.w500, // HTML: font-medium
                    color: textColor,
                    height: 1.25, // HTML: leading-normal
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Maneja el tap en una opción y cierra el diálogo
  void _handleOptionTap(BuildContext context, ContactOption option) {
    Navigator.of(context).pop();
    onOptionSelected(option);
  }

  /// Obtiene la información de contacto para mostrar
  String _getContactInfo() {
    if (contact.phone?.isNotEmpty == true) {
      return 'Mobile · ${contact.phone}';
    } else if (contact.email?.isNotEmpty == true) {
      return 'Email · ${contact.email}';
    }
    return 'No contact info';
  }
}