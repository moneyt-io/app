import 'dart:io';
import 'package:flutter/material.dart'; // Necesario para TimeOfDay

/// Define las operaciones abstractas para la gestión de copias de seguridad.
abstract class BackupRepository {
  /// Crea una copia de seguridad de la base de datos actual.
  /// Devuelve el archivo de la copia de seguridad creada.
  Future<File> createBackup();

  /// Restaura la base de datos desde el archivo de copia de seguridad proporcionado.
  Future<void> restoreBackup(File backupFile);

  /// Lista todos los archivos de copia de seguridad disponibles.
  /// Devuelve una lista de archivos ordenada por fecha de modificación (más recientes primero).
  Future<List<File>> listBackups();

  /// Elimina el archivo de copia de seguridad especificado.
  Future<void> deleteBackup(File backupFile);

  /// Comparte el archivo de copia de seguridad utilizando los mecanismos del sistema.
  Future<void> shareBackup(File backupFile);

  /// Permite al usuario seleccionar un archivo de copia de seguridad (.db)
  /// y lo copia al directorio de backups de la aplicación.
  /// Devuelve el archivo importado o null si se cancela.
  Future<File?> importBackup();

  /// Guarda la configuración para las copias de seguridad automáticas.
  Future<void> configureAutomaticBackup({
    required bool enabled,
    required Duration frequency,
    TimeOfDay? scheduledTime,
    int? retentionDays,
  });

  /// Obtiene la configuración actual de las copias de seguridad.
  Future<BackupSettings> getBackupSettings();

  /// Obtiene los metadatos asociados a un archivo de copia de seguridad específico.
  Future<BackupMetadata> getBackupMetadata(File backupFile);
}

/// Modelo que representa la configuración de las copias de seguridad.
class BackupSettings {
  /// Indica si las copias de seguridad automáticas están habilitadas.
  final bool enabled;

  /// Frecuencia con la que se deben realizar las copias automáticas (ej: cada 24 horas).
  final Duration frequency;

  /// Hora específica del día para realizar la copia automática (opcional).
  final TimeOfDay? scheduledTime;

  /// Número de días que se deben conservar las copias de seguridad automáticas.
  /// Las copias más antiguas que este límite se eliminarán. Por defecto 30 días.
  final int retentionDays;

  /// Directorio donde se almacenan las copias de seguridad.
  final String backupDirectoryPath;

  BackupSettings({
    required this.enabled,
    required this.frequency,
    required this.backupDirectoryPath,
    this.scheduledTime,
    this.retentionDays = 30, // Valor por defecto
  });

  // Puedes añadir métodos `copyWith`, `toJson`, `fromJson` si son necesarios más adelante.
}

/// Modelo para los metadatos de un archivo de copia de seguridad.
class BackupMetadata {
  /// Fecha y hora en que se creó la copia de seguridad.
  final DateTime createdAt;

  /// Versión de la aplicación MoneyT cuando se creó la copia.
  final String appVersion;

  /// Tamaño del archivo de copia de seguridad en bytes.
  final int sizeInBytes;

  /// Información adicional que pueda ser útil (ej: nombre del archivo).
  final Map<String, dynamic> additionalInfo;

  BackupMetadata({
    required this.createdAt,
    required this.appVersion,
    required this.sizeInBytes,
    this.additionalInfo = const {},
  });

  // Puedes añadir métodos `copyWith`, `toJson`, `fromJson` si son necesarios más adelante.
}
