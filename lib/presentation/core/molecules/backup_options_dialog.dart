import 'dart:io';
import 'package:flutter/material.dart';

/// Opciones disponibles en el diálogo de backup
enum BackupOption {
  restore,
  share,
  delete,
}

/// Bottom sheet dialog que muestra opciones para un backup específico
/// Basado en backup_list.html
class BackupOptionsDialog extends StatelessWidget {
  const BackupOptionsDialog({
    Key? key,
    required this.backupFile,
    required this.onOptionSelected,
    this.isLatest = false,
  }) : super(key: key);

  final File backupFile;
  final Function(BackupOption) onOptionSelected;
  final bool isLatest;

  /// Método estático para mostrar el diálogo
  static Future<void> show({
    required BuildContext context,
    required File backupFile,
    required Function(BackupOption) onOptionSelected,
    bool isLatest = false,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.3),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      builder: (context) => BackupOptionsDialog(
        backupFile: backupFile,
        onOptionSelected: onOptionSelected,
        isLatest: isLatest,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fileName = backupFile.path.split(Platform.pathSeparator).last;
    
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: double.infinity,
            height: 24,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Container(
                width: 40,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),

          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFF1F5F9)),
              ),
            ),
            child: Row(
              children: [
                // Icon con fondo circular
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getIconBackgroundColor(fileName, isLatest),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getBackupIcon(fileName),
                    color: _getIconColor(fileName, isLatest),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      Text(
                        isLatest ? 'Latest backup' : 'Backup file',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Options
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOptionItem(
                  icon: Icons.restore,
                  title: 'Restore backup',
                  subtitle: 'Replace current data with this backup',
                  onTap: () => _handleOptionTap(context, BackupOption.restore),
                ),
                _buildOptionItem(
                  icon: Icons.share,
                  title: 'Share backup',
                  subtitle: 'Send this backup file to another device',
                  onTap: () => _handleOptionTap(context, BackupOption.share),
                ),
                
                // Divider
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(color: Color(0xFFE2E8F0), height: 1),
                ),
                
                _buildOptionItem(
                  icon: Icons.delete,
                  title: 'Delete backup',
                  subtitle: 'This action cannot be undone',
                  onTap: () => _handleOptionTap(context, BackupOption.delete),
                  isDestructive: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Construye item de opción en la lista
  Widget _buildOptionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final iconColor = isDestructive 
        ? const Color(0xFFDC2626)
        : const Color(0xFF334155);

    final titleColor = isDestructive 
        ? const Color(0xFFDC2626)
        : const Color(0xFF1E293B);

    final subtitleColor = isDestructive 
        ? const Color(0xFFEF4444)
        : const Color(0xFF64748B);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: iconColor,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: titleColor,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: subtitleColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Maneja el tap en una opción y cierra el diálogo
  void _handleOptionTap(BuildContext context, BackupOption option) {
    Navigator.of(context).pop();
    onOptionSelected(option);
  }

  /// Obtiene el ícono según el tipo de backup
  IconData _getBackupIcon(String fileName) {
    final fileNameLower = fileName.toLowerCase();
    
    if (fileNameLower.contains('auto') || isLatest) {
      return Icons.backup;
    } else if (fileNameLower.contains('manual')) {
      return Icons.folder_zip;
    } else if (fileNameLower.contains('initial') || fileNameLower.contains('first')) {
      return Icons.schedule;
    } else {
      return Icons.history;
    }
  }

  /// Obtiene el color del ícono
  Color _getIconColor(String fileName, bool isLatest) {
    final fileNameLower = fileName.toLowerCase();
    
    if (fileNameLower.contains('auto') || isLatest) {
      return const Color(0xFF16A34A);
    } else if (fileNameLower.contains('manual')) {
      return const Color(0xFF2563EB);
    } else {
      return const Color(0xFF64748B);
    }
  }

  /// Obtiene el color de fondo del ícono
  Color _getIconBackgroundColor(String fileName, bool isLatest) {
    final fileNameLower = fileName.toLowerCase();
    
    if (fileNameLower.contains('auto') || isLatest) {
      return const Color(0xFFDCFCE7);
    } else if (fileNameLower.contains('manual')) {
      return const Color(0xFFDBEAFE);
    } else {
      return const Color(0xFFF1F5F9);
    }
  }
}
