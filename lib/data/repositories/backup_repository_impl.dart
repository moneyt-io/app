import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../local/database.dart';
import '../../domain/repositories/backup_repository.dart';

class BackupRepositoryImpl implements BackupRepository {
  final AppDatabase _database;
  static const String _prefKeyBackupEnabled = 'backup_enabled';
  static const String _prefKeyBackupFrequency = 'backup_frequency_hours';
  static const String _prefKeyBackupScheduledTime = 'backup_scheduled_time';
  static const String _prefKeyBackupRetentionDays = 'backup_retention_days';

  BackupRepositoryImpl({required AppDatabase database}) : _database = database;

  Future<Directory> get _backupDirectory async {
    final appDir = await getApplicationDocumentsDirectory();
    final backupDir = Directory('${appDir.path}/backups');
    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }
    return backupDir;
  }

  @override
  Future<File> createBackup() async {
    final backupDir = await _backupDirectory;
    final now = DateTime.now();
    final fileName = 'moneyt_${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}.db';
    final backupFile = File('${backupDir.path}/$fileName');
    
    // Copiar la base de datos actual
    final dbPath = await _database.getDatabasePath();
    final currentDb = File(dbPath);
    await currentDb.copy(backupFile.path);
    
    return backupFile;
  }

  @override
  Future<void> shareBackup(File backupFile) async {
    await Share.shareXFiles([XFile(backupFile.path)]);
  }

  @override
  Future<File?> importBackup() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['db'],
      );

      if (result != null) {
        final backupDir = await _backupDirectory;
        final importFile = File(result.files.single.path!);
        final newPath = '${backupDir.path}/${result.files.single.name}';
        return await importFile.copy(newPath);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<File>> listBackups() async {
    final backupDir = await _backupDirectory;
    final files = await backupDir.list().where((entity) => 
      entity is File && 
      (entity.path.endsWith('.db') || 
       entity.path.endsWith('.sqlite') || 
       entity.path.endsWith('.backup'))
    ).toList();

    // Convertir a List<File> y ordenar por fecha de modificación (más reciente primero)
    final backupFiles = files.map((e) => e as File).toList()
      ..sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));

    return backupFiles;
  }

  @override
  Future<void> restoreBackup(File backupFile) async {
    final dbPath = await _database.getDatabasePath();
    final currentDb = File(dbPath);
    
    // Cerrar la conexión con la base de datos
    await _database.close();

    // Copiar el backup sobre la base de datos actual
    await backupFile.copy(currentDb.path);
  }

  @override
  Future<void> deleteBackup(File backupFile) async {
    if (!await backupFile.exists()) {
      print('File does not exist: ${backupFile.path}');
      return;
    }

    try {
      print('Deleting file: ${backupFile.path}');
      await backupFile.delete();
      print('File deleted successfully');
    } catch (e) {
      print('Error deleting file: $e');
      rethrow;
    }
  }

  @override
  Future<void> configureAutomaticBackup({
    required Duration frequency,
    required bool enabled,
    TimeOfDay? scheduledTime,    // Nuevo parámetro
    int? retentionDays,         // Nuevo parámetro
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKeyBackupEnabled, enabled);
    await prefs.setInt(_prefKeyBackupFrequency, frequency.inHours);
    if (scheduledTime != null) {
      await prefs.setString(_prefKeyBackupScheduledTime, '${scheduledTime.hour}:${scheduledTime.minute}');
    }
    if (retentionDays != null) {
      await prefs.setInt(_prefKeyBackupRetentionDays, retentionDays);
    }
  }

  @override
  Future<BackupSettings> getBackupSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final backupDir = await _backupDirectory;
    final scheduledTimeString = prefs.getString(_prefKeyBackupScheduledTime);
    TimeOfDay? scheduledTime;
    if (scheduledTimeString != null) {
      final parts = scheduledTimeString.split(':');
      scheduledTime = TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }
    
    return BackupSettings(
      frequency: Duration(hours: prefs.getInt(_prefKeyBackupFrequency) ?? 24),
      enabled: prefs.getBool(_prefKeyBackupEnabled) ?? false,
      backupDirectory: backupDir.path,
      scheduledTime: scheduledTime,
      retentionDays: prefs.getInt(_prefKeyBackupRetentionDays) ?? 30,
    );
  }

  @override
  Future<BackupMetadata> getBackupMetadata(File backupFile) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final fileStats = await backupFile.stat();
    
    return BackupMetadata(
      createdAt: fileStats.modified,
      appVersion: packageInfo.version,
      sizeInBytes: fileStats.size,
      additionalInfo: {
        'fileName': backupFile.path.split('/').last,
        'lastModified': fileStats.modified.toIso8601String(),
      },
    );
  }
}
