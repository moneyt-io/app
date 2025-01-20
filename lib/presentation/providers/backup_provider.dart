import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../domain/repositories/backup_repository.dart';

class BackupProvider extends ChangeNotifier {
  final BackupRepository _repository;
  BackupSettings? _settings;
  DateTime? _lastBackup;
  DateTime? _nextBackup;
  bool _isLoading = false;
  List<File>? _backupFiles;

  BackupProvider(this._repository) {
    _loadSettings();
    _loadBackups();
  }

  // Getters
  bool get isLoading => _isLoading;
  BackupSettings? get settings => _settings;
  DateTime? get lastBackup => _lastBackup;
  DateTime? get nextBackup => _nextBackup;
  List<File>? get backupFiles => _backupFiles;
  bool get isEnabled => _settings?.enabled ?? false;
  Duration get frequency => _settings?.frequency ?? const Duration(hours: 24);
  String? get backupDirectory => _settings?.backupDirectory;

  Future<void> _loadSettings() async {
    _isLoading = true;
    notifyListeners();

    try {
      _settings = await _repository.getBackupSettings();
      _updateNextBackup();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadBackups() async {
    _isLoading = true;
    notifyListeners();

    try {
      _backupFiles = await _repository.listBackups();
      if (_backupFiles?.isNotEmpty ?? false) {
        final latestBackup = _backupFiles!.reduce(
          (a, b) => a.lastModifiedSync().isAfter(b.lastModifiedSync()) ? a : b
        );
        _lastBackup = latestBackup.lastModifiedSync();
        _updateNextBackup();
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _updateNextBackup() {
    if (_lastBackup != null && _settings?.enabled == true) {
      _nextBackup = _lastBackup!.add(_settings!.frequency);
      notifyListeners();
    }
  }

  // Public methods
  Future<void> updateSettings({
    required bool enabled,
    required Duration frequency,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.configureAutomaticBackup(
        enabled: enabled,
        frequency: frequency,
      );
      await _loadSettings();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<File> createBackup() async {
    _isLoading = true;
    notifyListeners();

    try {
      final backup = await _repository.createBackup();
      _lastBackup = DateTime.now();
      _updateNextBackup();
      await _loadBackups();
      return backup;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> restoreBackup(File backupFile) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.restoreBackup(backupFile);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteBackup(File backupFile) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.deleteBackup(backupFile);
      await _loadBackups();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> shareBackup(File backupFile) async {
    await _repository.shareBackup(backupFile);
  }

  Future<BackupMetadata> getBackupMetadata(File backupFile) async {
    return _repository.getBackupMetadata(backupFile);
  }

  Future<File?> importBackup() async {
    _isLoading = true;
    notifyListeners();

    try {
      final importedFile = await _repository.importBackup();
      if (importedFile != null) {
        await _loadBackups();
      }
      return importedFile;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
