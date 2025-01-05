import 'dart:io';
import '../services/backup_service.dart';
import '../../domain/repositories/backup_repository.dart';

class BackupRepositoryImpl implements BackupRepository {
  final BackupService _backupService;

  BackupRepositoryImpl(this._backupService);

  @override
  Future<String> createBackup() async {
    return await _backupService.createBackup();
  }

  @override
  Future<void> restoreBackup(String backupPath) async {
    await _backupService.restoreBackup(backupPath);
  }

  @override
  Future<List<FileSystemEntity>> listBackups() async {
    return await _backupService.listBackups();
  }

  @override
  Future<void> deleteBackup(String backupPath) async {
    await _backupService.deleteBackup(backupPath);
  }
}
