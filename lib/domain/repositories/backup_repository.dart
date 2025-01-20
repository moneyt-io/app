import 'dart:io';
import 'package:flutter/material.dart';

abstract class BackupRepository {
  Future<File> createBackup();
  Future<void> shareBackup(File backupFile);
  Future<File?> importBackup();
  Future<List<File>> listBackups();
  Future<void> restoreBackup(File backupFile);
  Future<void> deleteBackup(File backupFile);
  
  /// Configures automatic backup settings
  Future<void> configureAutomaticBackup({
    required Duration frequency,
    required bool enabled,
    TimeOfDay? scheduledTime,    // Nuevo parámetro
    int? retentionDays,         // Nuevo parámetro
  });
  
  /// Gets the current backup settings
  Future<BackupSettings> getBackupSettings();
  
  /// Gets metadata for a specific backup file
  Future<BackupMetadata> getBackupMetadata(File backupFile);
}

class BackupSettings {
  final Duration frequency;
  final bool enabled;
  final String backupDirectory;
  final TimeOfDay? scheduledTime;  // Nuevo parámetro
  final int retentionDays;        // Nuevo parámetro
  
  BackupSettings({
    required this.frequency,
    required this.enabled,
    required this.backupDirectory,
    this.scheduledTime,
    this.retentionDays = 30,
  });
}

class BackupMetadata {
  final DateTime createdAt;
  final String appVersion;
  final int sizeInBytes;
  final Map<String, dynamic> additionalInfo;
  
  BackupMetadata({
    required this.createdAt,
    required this.appVersion,
    required this.sizeInBytes,
    this.additionalInfo = const {},
  });
}
