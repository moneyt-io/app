import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
  late Future<String> _backupPathFuture;
  late Future<List<File>> _backupsFuture;

  @override
  void initState() {
    super.initState();
    _backupService = GetIt.I<BackupService>();
    _backupPathFuture = _backupService.currentBackupPath;
    _refreshBackups();
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

  Future<void> _deleteBackup(File backupFile) async {
    try {
      await _backupService.deleteBackup(backupFile);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.read<LanguageManager>().translations.backupDeleted)),
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
                                  onPressed: _handleResetDirectory,
                                  icon: const Icon(Icons.restore),
                                  label: Text(translations.resetDirectory),
                                ),
                                const SizedBox(width: 8),
                                FilledButton.icon(
                                  onPressed: _handleDirectoryChange,
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
                  child: FutureBuilder<List<File>>(
                    future: _backupsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      final backups = snapshot.data ?? [];
                      if (backups.isEmpty) {
                        return Center(child: Text(context.read<LanguageManager>().translations.noBackups));
                      }

                      return ListView.builder(
                        itemCount: backups.length,
                        itemBuilder: (context, index) {
                          final backup = backups[index];
                          final fileName = backup.path.split('/').last;
                          final fileStats = backup.statSync();
                          
                          return ListTile(
                            title: Text(fileName),
                            subtitle: Text(
                              DateFormat('yyyy-MM-dd HH:mm:ss').format(fileStats.modified),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.share),
                                  onPressed: () => _handleShareBackup(context, backup),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.restore),
                                  onPressed: () => _showRestoreDialog(context, backup),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _showDeleteDialog(context, backup),
                                ),
                              ],
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

  Future<void> _handleDeleteBackup(BuildContext context, File backup) async {
    try {
      await context.read<BackupService>().deleteBackup(backup);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.read<LanguageManager>().translations.backupDeleted)),
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
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.read<LanguageManager>().translations.deleteBackup),
        content: Text(context.read<LanguageManager>().translations.deleteBackupConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.read<LanguageManager>().translations.cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _handleDeleteBackup(context, backup);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(context.read<LanguageManager>().translations.delete),
          ),
        ],
      ),
    );
  }
}
