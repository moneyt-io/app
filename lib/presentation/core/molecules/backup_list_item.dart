import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'backup_options_dialog.dart'; // ✅ Import de la molécula extraída
import '../l10n/generated/strings.g.dart';

/// Item de backup individual basado en backup_list.html
class BackupListItem extends StatelessWidget {
  const BackupListItem({
    Key? key,
    required this.backupFile,
    required this.onRestore,
    required this.onDelete,
    required this.onShare,
    required this.onGetMetadata,
    this.isLatest = false,
  }) : super(key: key);

  final File backupFile;
  final VoidCallback onRestore;
  final VoidCallback onDelete;
  final VoidCallback onShare;
  final VoidCallback onGetMetadata;
  final bool isLatest;

  @override
  Widget build(BuildContext context) {
    final fileName = backupFile.path.split(Platform.pathSeparator).last;
    final fileStats = _getFileStats();
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onGetMetadata,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 48,
                  height: 48,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: _getIconBackgroundColor(),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getBackupIcon(),
                    color: _getIconColor(),
                    size: 24,
                  ),
                ),
                
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        _getBackupTitle(fileName),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      
                      const SizedBox(height: 4),
                      
                      // Created date
                      Text(
                        '${t.backups.dialogs.info.created} ${_formatCreatedDate(fileStats['created'])}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      
                      const SizedBox(height: 2),
                      
                      // Size info
                      Text(
                         '${t.backups.dialogs.info.size} ${_formatFileSize(fileStats['size'])}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      
                      // Latest badge
                      if (isLatest) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.circle,
                                size: 6,
                                color: Color(0xFF4ADE80),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                t.backups.options.latestBadge,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF166534),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                
                // More button
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _showBackupOptions(context),
                      borderRadius: BorderRadius.circular(20),
                      child: const Center(
                        child: Icon(
                          Icons.more_vert,
                          color: Color(0xFF64748B),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ✅ MÉTODOS HELPER PARA LA PANTALLA PRINCIPAL (SIN DUPLICADOS)
  
  Map<String, dynamic> _getFileStats() {
    try {
      final stat = backupFile.statSync();
      return {
        'size': stat.size,
        'created': stat.modified,
      };
    } catch (e) {
      return {
        'size': 0,
        'created': DateTime.now(),
      };
    }
  }

  IconData _getBackupIcon() {
    final fileName = backupFile.path.toLowerCase();
    
    if (fileName.contains('auto')) {
      return Icons.backup;
    } else if (fileName.contains('manual')) {
      return Icons.folder_zip;
    } else if (fileName.contains('initial') || fileName.contains('first')) {
      return Icons.schedule;
    } else {
      return Icons.history;
    }
  }

  Color _getIconBackgroundColor() {
    final fileName = backupFile.path.toLowerCase();
    
    if (fileName.contains('auto') || isLatest) {
      return const Color(0xFFDCFCE7);
    } else if (fileName.contains('manual')) {
      return const Color(0xFFDBEAFE);
    } else {
      return const Color(0xFFF1F5F9);
    }
  }

  Color _getIconColor() {
    final fileName = backupFile.path.toLowerCase();
    
    if (fileName.contains('auto') || isLatest) {
      return const Color(0xFF16A34A);
    } else if (fileName.contains('manual')) {
      return const Color(0xFF2563EB);
    } else {
      return const Color(0xFF64748B);
    }
  }

  String _getBackupTitle(String fileName) {
    final now = DateTime.now();
    // Use proper date formatting
    final formattedDate = DateFormat('MMMM yyyy', t.$meta.locale.languageCode).format(now);
    
    if (fileName.toLowerCase().contains('auto')) {
      return t.backups.format.auto(date: formattedDate);
    } else if (fileName.toLowerCase().contains('manual')) {
      return t.backups.format.manual(date: formattedDate);
    } else if (fileName.toLowerCase().contains('initial')) {
      return t.backups.format.initial;
    } else {
      return t.backups.format.generic(date: formattedDate);
    }
  }

  String _formatCreatedDate(DateTime? date) {
    if (date == null) return 'Unknown';
    
    final formatter = DateFormat.yMMMMd(t.$meta.locale.languageCode).add_jm();
    return formatter.format(date);
  }

  String _formatFileSize(int bytes) {
    if (bytes >= 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else if (bytes >= 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else {
      return '$bytes B';
    }
  }

  // ✅ SIMPLIFICADO: Solo usar BackupOptionsDialog
  void _showBackupOptions(BuildContext context) {
    BackupOptionsDialog.show(
      context: context,
      backupFile: backupFile,
      isLatest: isLatest,
      onOptionSelected: (option) => _handleBackupOption(option),
    );
  }

  // ✅ SIMPLIFICADO: Manejar opciones del diálogo
  void _handleBackupOption(BackupOption option) {
    switch (option) {
      case BackupOption.restore:
        onRestore();
        break;
      case BackupOption.share:
        onShare();
        break;
      case BackupOption.delete:
        onDelete();
        break;
    }
  }
}

