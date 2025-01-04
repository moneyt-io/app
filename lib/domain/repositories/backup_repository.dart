import 'dart:io';

abstract class BackupRepository {
  Future<String> createBackup();
  Future<void> restoreBackup(String backupPath);
  Future<List<FileSystemEntity>> listBackups();
  Future<void> deleteBackup(String backupPath);
}
