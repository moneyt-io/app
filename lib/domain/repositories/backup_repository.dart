import 'dart:io';

abstract class BackupRepository {
  Future<File> createBackup();
  Future<void> shareBackup(File backupFile);
  Future<File?> importBackup();
  Future<List<File>> listBackups();
  Future<void> restoreBackup(File backupFile);
  Future<void> deleteBackup(File backupFile);
}
