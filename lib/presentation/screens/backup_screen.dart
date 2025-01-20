import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moneyt_pfm/core/l10n/translations/base_translations.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart'; // Agregar este import
import '../../domain/repositories/backup_repository.dart';
import '../../data/services/backup_service.dart';
import '../../core/l10n/language_manager.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  late final BackupService _backupService;
  late Future<List<File>> _backupsFuture;
  bool _isEnabled = false;
  int _frequency = 24;
  TimeOfDay? _scheduledTime = const TimeOfDay(hour: 12, minute: 0);  // Hora predeterminada 12:00
  int _retentionDays = 30;

  @override
  void initState() {
    super.initState();
    _backupService = GetIt.I<BackupService>();
    _refreshBackups();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final backupRepo = context.read<BackupRepository>();
    final settings = await backupRepo.getBackupSettings();
    setState(() {
      _isEnabled = settings.enabled;
      _frequency = settings.frequency.inHours;
      _scheduledTime = settings.scheduledTime;
      _retentionDays = settings.retentionDays;
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _scheduledTime ?? TimeOfDay.now(),
    );
    if (picked != null && mounted) {
      setState(() => _scheduledTime = picked);
      await _saveSettings();
    }
  }

  void _refreshBackups() {
    setState(() {
      _backupsFuture = _backupService.listBackups();
    });
  }

  Future<void> _handleDirectoryChange() async {
    try {
      final String? selectedPath = await FilePicker.platform.getDirectoryPath();
      if (selectedPath != null) {
        await _backupService.setBackupPath(selectedPath);
        if (mounted) {
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.read<LanguageManager>().translations.backupDirectoryUpdated)),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> _handleResetDirectory() async {
    try {
      await _backupService.resetBackupPath();
      if (mounted) {
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.read<LanguageManager>().translations.backupDirectoryReset)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> _restoreBackup(File backupFile) async {
    try {
      await _backupService.restoreBackup(backupFile);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.read<LanguageManager>().translations.backupRestored)),
        );
        _refreshBackups();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> _importBackup() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
        withData: true,
      );

      if (result != null) {
        final file = result.files.single;
        if (file.bytes == null) {
          throw Exception(context.read<LanguageManager>().translations.fileReadError);
        }

        // Validar la extensión del archivo
        final fileName = file.name.toLowerCase();
        if (!fileName.endsWith('.db') && 
            !fileName.endsWith('.sqlite') && 
            !fileName.endsWith('.backup')) {
          throw Exception(context.read<LanguageManager>().translations.invalidFileFormat);
        }
        
        // Usar los bytes del archivo directamente
        await _backupService.importBackup(
          bytes: file.bytes!,
          fileName: file.name,
        );
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.read<LanguageManager>().translations.backupRestored),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
          _refreshBackups();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${context.read<LanguageManager>().translations.backupError}: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider<BackupRepository>(
      create: (_) => GetIt.I<BackupRepository>(),
      child: Builder(
        builder: (context) {
          final backupRepository = context.watch<BackupRepository>();
          final translations = context.watch<LanguageManager>().translations;
          final colorScheme = Theme.of(context).colorScheme;
          final textTheme = Theme.of(context).textTheme; // Añadir esta línea
          
          return Scaffold(
            appBar: AppBar(
              title: Text(translations.backups),
              backgroundColor: colorScheme.surface,
              elevation: 0,
            ),
            body: Column(
              children: [
                // Automatic Backup Settings Section
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          translations.automaticBackups,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SwitchListTile(
                        title: Text(translations.enableAutomaticBackups),
                        value: _isEnabled,
                        onChanged: (value) async {
                          setState(() => _isEnabled = value);
                          await _saveSettings();
                        },
                      ),
                      if (_isEnabled) ...[
                        ListTile(
                          title: Text(translations.backupFrequency),
                          subtitle: Text('${translations.every} $_frequency ${translations.hours}'),
                          trailing: DropdownButton<int>(
                            value: _frequency,
                            items: [12, 24, 48, 72].map((hours) {
                              return DropdownMenuItem(
                                value: hours,
                                child: Text('$hours ${translations.hours}'),
                              );
                            }).toList(),
                            onChanged: (value) async {
                              setState(() => _frequency = value!);
                              await _saveSettings();
                            },
                          ),
                        ),
                        _buildTimeSettings(),
                        ListTile(
                          title: Text(translations.retentionDays),
                          subtitle: Text('$_retentionDays ${translations.days}'),
                          trailing: DropdownButton<int>(
                            value: _retentionDays,
                            items: [7, 14, 30, 60, 90].map((days) {
                              return DropdownMenuItem(
                                value: days,
                                child: Text('$days ${translations.days}'),
                              );
                            }).toList(),
                            onChanged: (value) async {
                              setState(() => _retentionDays = value!);
                              await _saveSettings();
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Sección de crear respaldo
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          translations.backup,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: () async {
                            try {
                              await backupRepository.createBackup();
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(translations.backupCreated)),
                                );
                                _refreshBackups();
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(translations.backupError)),
                                );
                              }
                            }
                          },
                          icon: const Icon(Icons.backup),
                          label: Text(translations.createBackup),
                        ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: _importBackup,
                          icon: const Icon(Icons.file_download),
                          label: Text(translations.importBackup),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Lista de respaldos
                Expanded(
                  child: FutureBuilder<List<File>>(
                    future: _backupsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 48,
                                color: colorScheme.error,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Error: ${snapshot.error}',
                                style: TextStyle(color: colorScheme.error),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      final backups = snapshot.data ?? [];
                      if (backups.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.backup_outlined,
                                size: 64,
                                color: colorScheme.primary.withOpacity(0.5),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                translations.noBackups,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: backups.length,
                        itemBuilder: (context, index) {
                          final backup = backups[index];  // Ya están ordenados por fecha gracias al repository
                          final fileName = backup.path.split('/').last;
                          final fileStats = backup.statSync();
                          final fileSize = (backup.lengthSync() / 1024).toStringAsFixed(2);
                          
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: colorScheme.outlineVariant,
                                width: 1,
                              ),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => _showBackupOptions(context, backup),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.backup_rounded,
                                          color: colorScheme.primary,
                                          size: 24,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            fileName,
                                            style: textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.more_vert),
                                          onPressed: () => _showBackupOptions(context, backup),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    DefaultTextStyle(
                                      style: textTheme.bodyMedium!.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.access_time_rounded,
                                            size: 16,
                                            color: colorScheme.onSurfaceVariant,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            DateFormat('dd/MM/yyyy HH:mm').format(fileStats.modified),
                                          ),
                                          const SizedBox(width: 16),
                                          Icon(
                                            Icons.storage_rounded,
                                            size: 16,
                                            color: colorScheme.onSurfaceVariant,
                                          ),
                                          const SizedBox(width: 4),
                                          Text('$fileSize KB'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleShareBackup(BuildContext context, File backup) async {
    try {
      await context.read<BackupService>().shareBackup(backup);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> _handleRestoreBackup(BuildContext context, File backup) async {
    try {
      await context.read<BackupService>().restoreBackup(backup);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.read<LanguageManager>().translations.backupRestored)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> _handleDeleteBackup(
    File backup,
    BaseTranslations translations,
    ColorScheme colorScheme,
  ) async {
    try {
      await _backupService.deleteBackup(backup);
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(translations.backupDeleted)),
      );
      
      _refreshBackups();
      
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${translations.backupError}: $e'),
          backgroundColor: colorScheme.error,
        ),
      );
    }
  }

  Future<void> _showRestoreDialog(BuildContext context, File backup) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.read<LanguageManager>().translations.restoreBackup),
        content: Text(context.read<LanguageManager>().translations.restoreBackupConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.read<LanguageManager>().translations.cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _handleRestoreBackup(context, backup);
            },
            child: Text(context.read<LanguageManager>().translations.restore),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteDialog(BuildContext context, File backup) async {
    final translations = context.read<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;
    
    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(translations.deleteBackup),
        content: Text(translations.deleteBackupConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(translations.cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              if (mounted) {
                _handleDeleteBackup(backup, translations, colorScheme);
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.error,
            ),
            child: Text(translations.delete),
          ),
        ],
      ),
    );
  }

  Future<void> _saveSettings() async {
    final backupRepo = context.read<BackupRepository>();
    await backupRepo.configureAutomaticBackup(
      frequency: Duration(hours: _frequency),
      enabled: _isEnabled,
      scheduledTime: _scheduledTime,  // Asegúrate de pasar este parámetro
      retentionDays: _retentionDays,  // Asegúrate de pasar este parámetro
    );
  }

  void _showBackupOptions(BuildContext context, File backup) {
    final translations = context.read<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;
    
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.restore),
              title: Text(translations.restore),
              onTap: () {
                Navigator.pop(context);
                _showRestoreDialog(context, backup);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: Text(translations.share),
              onTap: () {
                Navigator.pop(context);
                _handleShareBackup(context, backup);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: colorScheme.error),
              title: Text(
                translations.delete,
                style: TextStyle(color: colorScheme.error),
              ),
              onTap: () {
                Navigator.pop(context);
                _showDeleteDialog(context, backup);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSettings() {
    final translations = context.read<LanguageManager>().translations;  // Asegúrate de definir translations aquí
    return ListTile(
      title: Text(translations.backupTime),
      subtitle: Text(_scheduledTime?.format(context) ?? translations.notSet),
      trailing: IconButton(
        icon: const Icon(Icons.access_time),
        onPressed: () => _selectTime(context),
      ),
    );
  }
}
