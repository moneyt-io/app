import 'dart:io';
import 'package:flutter/material.dart'; // Necesario para TimeOfDay
import 'package:injectable/injectable.dart'; // Asumiendo que usas injectable
import '../../domain/repositories/backup_repository.dart';

/// Servicio para orquestar las operaciones de copia de seguridad.
///
/// Actúa como una fachada sobre [BackupRepository], simplificando la
/// interacción desde la capa de presentación (Providers).
@lazySingleton // Registrar como Singleton si usas injectable
class BackupService {
  final BackupRepository _repository;

  BackupService(this._repository);

  /// Crea una nueva copia de seguridad.
  Future<File> createBackup() async {
    try {
      return await _repository.createBackup();
    } catch (e) {
      // Podrías añadir logging aquí
      rethrow; // Relanzar la excepción para que el Provider la maneje
    }
  }

  /// Restaura la base de datos desde un archivo de backup.
  /// **Importante:** La UI debe manejar la necesidad de reiniciar/recargar datos.
  Future<void> restoreBackup(File backupFile) async {
    try {
      await _repository.restoreBackup(backupFile);
      // Considerar añadir un evento/callback para indicar que la restauración terminó
      // y que la base de datos necesita ser reinicializada.
    } catch (e) {
      rethrow;
    }
  }

  /// Obtiene la lista de archivos de backup disponibles.
  Future<List<File>> listBackups() async {
    try {
      return await _repository.listBackups();
    } catch (e) {
      rethrow;
    }
  }

  /// Elimina un archivo de backup específico.
  Future<void> deleteBackup(File backupFile) async {
    try {
      await _repository.deleteBackup(backupFile);
    } catch (e) {
      rethrow;
    }
  }

  /// Comparte un archivo de backup.
  Future<void> shareBackup(File backupFile) async {
    try {
      await _repository.shareBackup(backupFile);
    } catch (e) {
      rethrow;
    }
  }

  /// Importa un archivo de backup seleccionado por el usuario.
  Future<File?> importBackupFromFile() async {
    try {
      return await _repository.importBackup();
    } catch (e) {
      rethrow;
    }
  }

  /// Configura los ajustes para las copias de seguridad automáticas.
  Future<void> configureAutomaticBackup({
    required bool enabled,
    required Duration frequency,
    TimeOfDay? scheduledTime,
    int? retentionDays,
  }) async {
    try {
      await _repository.configureAutomaticBackup(
        enabled: enabled,
        frequency: frequency,
        scheduledTime: scheduledTime,
        retentionDays: retentionDays,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Obtiene la configuración actual de las copias de seguridad.
  Future<BackupSettings> getBackupSettings() async {
    try {
      return await _repository.getBackupSettings();
    } catch (e) {
      rethrow;
    }
  }

  /// Obtiene los metadatos de un archivo de backup específico.
  Future<BackupMetadata> getBackupMetadata(File backupFile) async {
    try {
      return await _repository.getBackupMetadata(backupFile);
    } catch (e) {
      rethrow;
    }
  }
}
