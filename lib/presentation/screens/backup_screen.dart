import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import '../../domain/repositories/backup_repository.dart';
import '../../data/local/backup/backup_service.dart';
import '../../core/l10n/language_manager.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  late Future<String> _backupPathFuture;
  late BackupService _backupService;
  late Future<List<FileSystemEntity>> _backupsFuture;

  @override
  void initState() {
    super.initState();
    _backupService = GetIt.I<BackupService>();
    _backupPathFuture = _backupService.currentBackupPath;
    _refreshBackups();
  }

  void _refreshBackups() {
    setState(() {
      _backupsFuture = context.read<BackupRepository>().listBackups();
    });
  }

  Future<void> _selectBackupPath() async {
    final translations = context.read<LanguageManager>().translations;
    
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath(
      dialogTitle: translations.selectBackupDirectory,
    );

    if (selectedDirectory != null && context.mounted) {
      await _backupService.setBackupPath(selectedDirectory);
      setState(() {
        _backupPathFuture = _backupService.currentBackupPath;
      });
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(translations.backupDirectoryUpdated)),
        );
      }
    }
  }

  Future<void> _resetBackupPath() async {
    final translations = context.read<LanguageManager>().translations;
    
    await _backupService.resetBackupPath();
    setState(() {
      _backupPathFuture = _backupService.currentBackupPath;
    });
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(translations.backupDirectoryReset)),
      );
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

          return Scaffold(
            appBar: AppBar(
              title: Text(translations.backups),
              backgroundColor: colorScheme.surface,
              elevation: 0,
            ),
            body: Column(
              children: [
                // Sección de configuración de respaldos
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          translations.backupSettings,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              translations.backupDirectory,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 8),
                            FutureBuilder<String>(
                              future: _backupPathFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const LinearProgressIndicator();
                                }
                                return Text(
                                  snapshot.data ?? '',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: colorScheme.onSurface.withOpacity(0.8),
                                      ),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  onPressed: _resetBackupPath,
                                  icon: const Icon(Icons.restore),
                                  label: Text(translations.resetDirectory),
                                ),
                                const SizedBox(width: 8),
                                FilledButton.icon(
                                  onPressed: _selectBackupPath,
                                  icon: const Icon(Icons.folder),
                                  label: Text(translations.changeDirectory),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
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
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Lista de respaldos
                Expanded(
                  child: FutureBuilder<List<FileSystemEntity>>(
                    future: _backupsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.backup_outlined,
                                size: 64,
                                color: colorScheme.onSurface.withOpacity(0.5),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                translations.noBackups,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: colorScheme.onSurface.withOpacity(0.5),
                                    ),
                              ),
                            ],
                          ),
                        );
                      }

                      final backups = snapshot.data!;
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: backups.length,
                        itemBuilder: (context, index) {
                          final backup = backups[index];
                          final fileName = p.basename(backup.path);
                          return Card(
                            child: ListTile(
                              title: Text(
                                fileName,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.restore,
                                      color: colorScheme.primary,
                                    ),
                                    onPressed: () async {
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(translations.restoreBackup),
                                          content: Text(translations.restoreBackupConfirmation),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context, false),
                                              child: Text(translations.cancel),
                                            ),
                                            FilledButton(
                                              onPressed: () => Navigator.pop(context, true),
                                              child: Text(translations.restoreBackup),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirm == true && context.mounted) {
                                        try {
                                          await backupRepository.restoreBackup(backup.path);
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text(translations.backupRestored)),
                                            );
                                            Navigator.pop(context);
                                          }
                                        } catch (e) {
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text(translations.backupError)),
                                            );
                                          }
                                        }
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.share,
                                      color: colorScheme.primary,
                                    ),
                                    onPressed: () async {
                                      final destinationPath = await FilePicker.platform.getDirectoryPath(
                                        dialogTitle: translations.selectExportDirectory,
                                      );

                                      if (destinationPath != null && context.mounted) {
                                        try {
                                          final exportedPath = await _backupService.exportBackup(
                                            backup.path,
                                            destinationPath,
                                          );
                                          if (exportedPath != null && context.mounted) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text(translations.backupExported)),
                                            );
                                          }
                                        } catch (e) {
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text(translations.backupError)),
                                            );
                                          }
                                        }
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: colorScheme.error,
                                    ),
                                    onPressed: () async {
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(translations.deleteBackup),
                                          content: Text(translations.deleteBackupConfirmation),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context, false),
                                              child: Text(translations.cancel),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.pop(context, true),
                                              style: TextButton.styleFrom(
                                                foregroundColor: colorScheme.error,
                                              ),
                                              child: Text(translations.delete),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirm == true && context.mounted) {
                                        try {
                                          await backupRepository.deleteBackup(backup.path);
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text(translations.backupDeleted)),
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
                                      }
                                    },
                                  ),
                                ],
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
}
