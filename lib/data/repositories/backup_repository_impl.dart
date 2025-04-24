import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:intl/intl.dart'; // Importar para DateFormat
import '../datasources/local/database.dart';
import '../../domain/repositories/backup_repository.dart';

/// Implementación concreta de [BackupRepository].
///
/// Gestiona las operaciones de copia de seguridad interactuando con el sistema
/// de archivos y las preferencias compartidas.
class BackupRepositoryImpl implements BackupRepository {
  final AppDatabase _database;
  final SharedPreferences _prefs;

  // Claves para SharedPreferences
  static const String _prefKeyBackupEnabled = 'backup_enabled';
  static const String _prefKeyBackupFrequencyHours = 'backup_frequency_hours';
  static const String _prefKeyBackupScheduledTime = 'backup_scheduled_time';
  static const String _prefKeyBackupRetentionDays = 'backup_retention_days';
  static const String _prefKeyBackupDirectory = 'backup_directory_path';

  BackupRepositoryImpl({
    required AppDatabase database,
    required SharedPreferences prefs,
  })  : _database = database,
        _prefs = prefs;

  /// Obtiene el directorio donde se almacenan las copias de seguridad.
  /// Crea el directorio si no existe.
  Future<Directory> get _backupDirectory async {
    // Intenta obtener la ruta guardada, si no, usa la predeterminada.
    String? savedPath = _prefs.getString(_prefKeyBackupDirectory);
    Directory backupDir;

    if (savedPath != null && savedPath.isNotEmpty) {
      backupDir = Directory(savedPath);
    } else {
      // Ruta predeterminada si no hay nada guardado
      final appDir = await getApplicationDocumentsDirectory();
      backupDir = Directory('${appDir.path}/backups');
      // Guarda la ruta predeterminada para futuras referencias
      await _prefs.setString(_prefKeyBackupDirectory, backupDir.path);
    }

    // Asegurarse de que el directorio exista
    if (!await backupDir.exists()) {
      try {
        await backupDir.create(recursive: true);
      } catch (e) {
        // Si falla la creación (ej. permisos), intenta usar un directorio alternativo seguro
        final appDir = await getApplicationDocumentsDirectory();
        backupDir = Directory('${appDir.path}/backups');
        if (!await backupDir.exists()) {
          await backupDir.create(recursive: true);
        }
        // Guarda la ruta alternativa
        await _prefs.setString(_prefKeyBackupDirectory, backupDir.path);
      }
    }
    return backupDir;
  }

  @override
  Future<File> createBackup() async {
    final backupDir = await _backupDirectory;
    final now = DateTime.now();
    // Formato de nombre de archivo consistente
    final timestamp =
        '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
    final fileName = 'moneyt_backup_$timestamp.db';
    final backupFile = File('${backupDir.path}/$fileName');

    try {
      // Obtener la ruta de la base de datos activa
      final dbPath = await _database.getDatabasePath();
      final currentDb = File(dbPath);

      // Copiar el archivo de la base de datos al destino del backup
      if (await currentDb.exists()) {
        await currentDb.copy(backupFile.path);
        return backupFile;
      } else {
        throw Exception('El archivo de la base de datos no existe en $dbPath');
      }
    } catch (e) {
      // Considerar logging del error
      throw Exception('Error al crear la copia de seguridad: $e');
    }
  }

  @override
  Future<void> restoreBackup(File backupFile) async {
    if (!await backupFile.exists()) {
      throw Exception('El archivo de backup seleccionado no existe.');
    }

    final dbPath = await _database.getDatabasePath();
    final currentDb = File(dbPath);
    File? tempBackup;

    try {
      // 1. (Opcional) Crear una copia de seguridad temporal de la BD actual
      if (await currentDb.exists()) {
        final tempDir = await getTemporaryDirectory();
        tempBackup = await currentDb.copy('${tempDir.path}/db_before_restore_${DateTime.now().millisecondsSinceEpoch}.db');
      }

      // 2. Cerrar la conexión a la base de datos
      await _database.close();

      // 3. Copiar el archivo de backup sobre la base de datos actual
      await backupFile.copy(dbPath);

      // 4. La reapertura de la base de datos se manejará externamente
      // (ej. reiniciando la app o reinicializando el servicio de BD)

    } catch (e) {
      // Si falla la restauración, intentar restaurar desde la copia temporal
      if (tempBackup != null && await tempBackup.exists()) {
        try {
          await tempBackup.copy(dbPath);
        } catch (restoreError) {
          // Error crítico: no se pudo restaurar ni el backup ni la copia temporal
          throw Exception('Error crítico al restaurar. Error original: $e. Error al restaurar copia temporal: $restoreError');
        }
      }
      throw Exception('Error durante la restauración: $e');
    } finally {
      // 5. Limpiar la copia temporal si existe
      if (tempBackup != null && await tempBackup.exists()) {
        await tempBackup.delete();
      }
    }
  }

  @override
  Future<List<File>> listBackups() async {
    try {
      final backupDir = await _backupDirectory;
      if (!await backupDir.exists()) {
        return []; // Si el directorio no existe, no hay backups
      }

      final entities = await backupDir.list().toList();
      final files = entities.whereType<File>().where((file) {
        // Filtrar solo por extensión .db
        final name = file.path.split(Platform.pathSeparator).last;
        return name.toLowerCase().endsWith('.db');
      }).toList();

      // Ordenar por fecha de modificación (más reciente primero)
      files.sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));

      return files;
    } catch (e) {
      throw Exception('Error al listar las copias de seguridad: $e');
    }
  }

  @override
  Future<void> deleteBackup(File backupFile) async {
    try {
      if (await backupFile.exists()) {
        await backupFile.delete();
      }
    } catch (e) {
      throw Exception('Error al eliminar la copia de seguridad: $e');
    }
  }

  @override
  Future<void> shareBackup(File backupFile) async {
    if (!await backupFile.exists()) {
      throw Exception('El archivo de backup a compartir no existe.');
    }
    try {
      await Share.shareXFiles(
        [XFile(backupFile.path)],
        subject: 'Copia de seguridad MoneyT',
        text: 'Adjunto mi copia de seguridad de MoneyT del ${DateFormat('dd/MM/yyyy HH:mm').format(backupFile.lastModifiedSync())}.',
      );
    } catch (e) {
      throw Exception('Error al compartir la copia de seguridad: $e');
    }
  }

  @override
  Future<File?> importBackup() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any, // Cambiado de FileType.custom
        // allowedExtensions: ['db'], // Eliminado allowedExtensions
      );

      if (result != null && result.files.single.path != null) {
        final importFile = File(result.files.single.path!);
        // Añadir validación de extensión manualmente si se desea
        if (!importFile.path.toLowerCase().endsWith('.db')) {
           throw Exception('El archivo seleccionado no es un archivo .db válido.');
        }
        final backupDir = await _backupDirectory;
        final fileName = result.files.single.name;
        final newPath = '${backupDir.path}/$fileName';

        // Copiar el archivo seleccionado al directorio de backups
        return await importFile.copy(newPath);
      }
      return null; // El usuario canceló la selección
    } catch (e) {
      // Evitar envolver la excepción si ya es una excepción específica
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Error al importar la copia de seguridad: $e');
    }
  }

  @override
  Future<void> configureAutomaticBackup({
    required bool enabled,
    required Duration frequency,
    TimeOfDay? scheduledTime,
    int? retentionDays,
  }) async {
    await _prefs.setBool(_prefKeyBackupEnabled, enabled);
    await _prefs.setInt(_prefKeyBackupFrequencyHours, frequency.inHours);
    if (scheduledTime != null) {
      await _prefs.setString(_prefKeyBackupScheduledTime, '${scheduledTime.hour}:${scheduledTime.minute}');
    } else {
      await _prefs.remove(_prefKeyBackupScheduledTime);
    }
    if (retentionDays != null) {
      await _prefs.setInt(_prefKeyBackupRetentionDays, retentionDays);
    } else {
      // Si es null, usa el valor por defecto (o elimina la clave si prefieres)
      await _prefs.setInt(_prefKeyBackupRetentionDays, 30);
    }
  }

  @override
  Future<BackupSettings> getBackupSettings() async {
    final backupDir = await _backupDirectory;
    final scheduledTimeString = _prefs.getString(_prefKeyBackupScheduledTime);
    TimeOfDay? scheduledTime;

    if (scheduledTimeString != null) {
      final parts = scheduledTimeString.split(':');
      if (parts.length == 2) {
        scheduledTime = TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
      }
    }

    return BackupSettings(
      enabled: _prefs.getBool(_prefKeyBackupEnabled) ?? false, // Default a false
      frequency: Duration(hours: _prefs.getInt(_prefKeyBackupFrequencyHours) ?? 24), // Default a 24h
      scheduledTime: scheduledTime,
      retentionDays: _prefs.getInt(_prefKeyBackupRetentionDays) ?? 30, // Default a 30 días
      backupDirectoryPath: backupDir.path,
    );
  }

  @override
  Future<BackupMetadata> getBackupMetadata(File backupFile) async {
    if (!await backupFile.exists()) {
      throw Exception('El archivo de backup no existe para obtener metadatos.');
    }
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final fileStats = await backupFile.stat();

      return BackupMetadata(
        createdAt: fileStats.modified, // Usar fecha de modificación como referencia
        appVersion: packageInfo.version,
        sizeInBytes: fileStats.size,
        additionalInfo: {
          'fileName': backupFile.path.split(Platform.pathSeparator).last,
          'lastModified': fileStats.modified.toIso8601String(),
          'accessed': fileStats.accessed.toIso8601String(),
          'changed': fileStats.changed.toIso8601String(),
          'mode': fileStats.modeString(), // Permisos en formato string
        },
      );
    } catch (e) {
      throw Exception('Error al obtener metadatos del backup: $e');
    }
  }
}
