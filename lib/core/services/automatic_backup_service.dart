import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/backup_repository.dart';
import 'notification_service.dart';

@lazySingleton
class AutomaticBackupService {
  final BackupRepository _backupRepository;
  final SharedPreferences _prefs;
  final NotificationService _notificationService;
  Timer? _backupTimer;

  AutomaticBackupService({
    required BackupRepository backupRepository,
    required SharedPreferences prefs,
    required NotificationService notificationService,
  })  : _backupRepository = backupRepository,
        _prefs = prefs,
        _notificationService = notificationService;

  Future<void> initialize() async {
    final settings = await _backupRepository.getBackupSettings();
    if (settings.enabled) {
      _scheduleBackup(settings);
    }
  }

  void _scheduleBackup(BackupSettings settings) {
    final now = DateTime.now();
    final nextBackupTime = DateTime(
      now.year,
      now.month,
      now.day,
      settings.scheduledTime?.hour ?? 12,
      settings.scheduledTime?.minute ?? 0,
    );

    if (nextBackupTime.isBefore(now)) {
      nextBackupTime.add(Duration(days: 1));
    }

    final initialDelay = nextBackupTime.difference(now);
    _backupTimer?.cancel();
    _backupTimer = Timer(initialDelay, () async {
      await _performBackup();
      _backupTimer = Timer.periodic(settings.frequency, (timer) async {
        await _performBackup();
      });
    });
  }

  Future<void> _performBackup() async {
    try {
      final backupFile = await _backupRepository.createBackup();
      await _notificationService.showNotification(
        title: 'Backup Successful',
        body: 'Backup created at ${backupFile.path}',
      );
      await _cleanOldBackups();
    } catch (e) {
      await _notificationService.showNotification(
        title: 'Backup Failed',
        body: 'Error: $e',
      );
    }
  }

  Future<void> _cleanOldBackups() async {
    final settings = await _backupRepository.getBackupSettings();
    final backups = await _backupRepository.listBackups();
    final retentionDate = DateTime.now().subtract(Duration(days: settings.retentionDays));
    for (final backup in backups) {
      if (backup.lastModifiedSync().isBefore(retentionDate)) {
        await _backupRepository.deleteBackup(backup);
      }
    }
  }

  // Método para obtener y usar una preferencia de ejemplo
  Future<void> _usePrefsExample() async {
    final examplePref = _prefs.getString('example_key') ?? 'default_value';
    print('Example preference value: $examplePref');
  }
}
