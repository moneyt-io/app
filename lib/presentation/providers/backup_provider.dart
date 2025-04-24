import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; // Necesario para TimeOfDay
import '../../core/services/backup_service.dart';
import '../../domain/repositories/backup_repository.dart'; // Para BackupMetadata y BackupSettings

/// Provider para gestionar el estado relacionado con las copias de seguridad.
///
/// Interactúa con [BackupService] para realizar operaciones y notifica
/// a los listeners (UI) sobre los cambios de estado.
class BackupProvider extends ChangeNotifier {
  final BackupService _backupService;

  // --- Estado Interno ---
  bool _isLoading = false;
  String? _errorMessage;
  List<File>? _backupFiles;
  BackupSettings? _settings;
  DateTime? _lastBackupDate;

  // --- Getters Públicos ---
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<File>? get backupFiles => _backupFiles;
  BackupSettings? get settings => _settings;
  DateTime? get lastBackupDate => _lastBackupDate;

  /// Constructor: Inicializa el provider.
  BackupProvider(this._backupService);

  /// Carga la lista de backups y la configuración inicial.
  /// ESTE MÉTODO AHORA DEBE SER LLAMADO EXPLÍCITAMENTE DESDE LA UI SI ES NECESARIO
  /// CARGAR AMBAS COSAS JUNTAS. Para la lista de backups, loadBackups() es suficiente.
  Future<void> loadInitialData() async {
    if (_isLoading) return;
    _setLoading(true);
    try {
      await Future.wait([
        _loadBackupsInternal(),
        _loadSettingsInternal(),
      ]);
    } finally {
      _setLoading(false);
    }
  }

  /// Carga (o recarga) la lista de archivos de backup disponibles.
  Future<void> loadBackups() async {
    if (_isLoading) return;

    _setLoading(true);
    try {
      await _loadBackupsInternal();
    } finally {
      _setLoading(false);
    }
  }

  // Método interno para cargar backups sin manejar isLoading globalmente aquí
  Future<void> _loadBackupsInternal() async {
    try {
      _backupFiles = await _backupService.listBackups();
      _updateLastBackupDate();
      _clearError();
    } catch (e) {
      _setError('Error al cargar las copias de seguridad: ${e.toString()}');
      _backupFiles = [];
    }
  }

  /// Carga (o recarga) la configuración de backups.
  Future<void> loadSettings() async {
    if (_isLoading) return;
    _setLoading(true);
    try {
      await _loadSettingsInternal();
    } finally {
      _setLoading(false);
    }
  }

  // Método interno para cargar settings sin manejar isLoading globalmente aquí
  Future<void> _loadSettingsInternal() async {
    try {
      _settings = await _backupService.getBackupSettings();
      _clearError();
    } catch (e) {
      _setError('Error al cargar la configuración: ${e.toString()}');
    }
  }

  /// Crea una nueva copia de seguridad.
  Future<File?> createBackup() async {
    if (_isLoading) return null;
    _setLoading(true);
    File? createdFile;
    try {
      createdFile = await _backupService.createBackup();
      await _loadBackupsInternal();
      _clearError();
    } catch (e) {
      _setError('Error al crear la copia de seguridad: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
    return createdFile;
  }

  /// Restaura la base de datos desde un archivo de backup.
  /// Devuelve `true` si la operación fue exitosa (pero no implica que la BD esté lista),
  /// `false` si hubo un error.
  Future<bool> restoreBackup(File backupFile) async {
    if (_isLoading) return false;
    _setLoading(true);
    bool success = false;
    try {
      await _backupService.restoreBackup(backupFile);
      _clearError();
      success = true;
    } catch (e) {
      _setError('Error durante la restauración: ${e.toString()}');
      success = false;
    } finally {
      _setLoading(false);
    }
    return success;
  }

  /// Elimina un archivo de backup específico.
  Future<void> deleteBackup(File backupFile) async {
    if (_isLoading) return;
    _setLoading(true);
    try {
      await _backupService.deleteBackup(backupFile);
      await _loadBackupsInternal();
      _clearError();
    } catch (e) {
      _setError('Error al eliminar la copia de seguridad: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Comparte un archivo de backup.
  Future<void> shareBackup(File backupFile) async {
    try {
      await _backupService.shareBackup(backupFile);
      _clearError();
    } catch (e) {
      _setError('Error al compartir la copia de seguridad: ${e.toString()}');
    }
  }

  /// Importa un archivo de backup seleccionado por el usuario.
  Future<File?> importBackupFromFile() async {
    if (_isLoading) return null;
    _setLoading(true);
    File? importedFile;
    try {
      importedFile = await _backupService.importBackupFromFile();
      if (importedFile != null) {
        await _loadBackupsInternal();
      }
      _clearError();
    } catch (e) {
      _setError('Error al importar la copia de seguridad: ${e.toString()}');
      if (e.toString().contains('File selection cancelled')) {
        _clearError();
        return null;
      }
    } finally {
      _setLoading(false);
    }
    return importedFile;
  }

  /// Obtiene los metadatos de un archivo de backup específico.
  Future<BackupMetadata?> getBackupMetadata(File backupFile) async {
    try {
      final metadata = await _backupService.getBackupMetadata(backupFile);
      _clearError();
      return metadata;
    } catch (e) {
      _setError('Error al obtener metadatos: ${e.toString()}');
      return null;
    }
  }

  /// Configura los ajustes para las copias de seguridad automáticas.
  Future<void> configureAutomaticBackup({
    required bool enabled,
    required Duration frequency,
    TimeOfDay? scheduledTime,
    int? retentionDays,
  }) async {
    if (_isLoading) return;
    _setLoading(true);
    try {
      await _backupService.configureAutomaticBackup(
        enabled: enabled,
        frequency: frequency,
        scheduledTime: scheduledTime,
        retentionDays: retentionDays,
      );
      await _loadSettingsInternal();
      _clearError();
    } catch (e) {
      _setError('Error al guardar la configuración: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // --- Métodos Auxiliares ---

  /// Actualiza el estado de carga y notifica a los listeners.
  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  /// Establece un mensaje de error y notifica a los listeners.
  void _setError(String message) {
    if (_errorMessage != message) {
      _errorMessage = message;
      if (kDebugMode) {
        print("BackupProvider Error: $message");
      }
      notifyListeners();
    }
  }

  /// Limpia el mensaje de error y notifica si es necesario.
  void _clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }

  /// Actualiza la fecha del último backup basado en la lista de archivos.
  void _updateLastBackupDate() {
    DateTime? newDate;
    if (_backupFiles != null && _backupFiles!.isNotEmpty) {
      final sortedFiles = List<File>.from(_backupFiles!)..sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
      newDate = sortedFiles.first.lastModifiedSync();
    }
    if (_lastBackupDate != newDate) {
      _lastBackupDate = newDate;
    }
  }
}
