import 'dart:io';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/backup_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class BackupService {
  final BackupRepository _repository;
  final SharedPreferences _prefs;
  static const String _backupPathKey = 'backup_path';
  static const int maxBackups = 5;

  BackupService(this._repository, this._prefs);

  Future<String> get currentBackupPath async {
    final appDir = await getApplicationDocumentsDirectory();
    return _prefs.getString(_backupPathKey) ?? '${appDir.path}/backups';
  }

  Future<void> setBackupPath(String path) async {
    await _prefs.setString(_backupPathKey, path);
  }

  Future<void> resetBackupPath() async {
    await _prefs.remove(_backupPathKey);
  }

  Future<void> createAndShareBackup() async {
    final backup = await _repository.createBackup();
    await _repository.shareBackup(backup);
    await _cleanOldBackups();
  }

  Future<void> _cleanOldBackups() async {
    final backups = await _repository.listBackups();
    if (backups.length > maxBackups) {
      final toDelete = backups.sublist(maxBackups);
      for (var file in toDelete) {
        await _repository.deleteBackup(file);
      }
    }
  }

  Future<bool> importBackup() async {
    final file = await _repository.importBackup();
    if (file != null) {
      await _repository.restoreBackup(file);
      return true;
    }
    return false;
  }

  Future<List<File>> listBackups() => _repository.listBackups();
  
  Future<void> restoreBackup(File backup) => _repository.restoreBackup(backup);
  
  Future<void> deleteBackup(File backup) => _repository.deleteBackup(backup);
  
  Future<void> shareBackup(File backupFile) => _repository.shareBackup(backupFile);
}
