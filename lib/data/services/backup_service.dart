import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import '../local/database.dart';

class BackupService {
  final AppDatabase database;
  final SharedPreferences prefs;
  static const String backupDirKey = 'backup_directory';
  static const int maxAutoBackups = 5;

  BackupService({
    required this.database,
    required this.prefs,
  });

  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      if (await Permission.manageExternalStorage.isGranted) {
        return true;
      }
      final status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        return true;
      }
      // Si el permiso anterior falla, intentar con el permiso de almacenamiento normal
      final storageStatus = await Permission.storage.request();
      return storageStatus.isGranted;
    }
    return true;
  }

  Future<String> get defaultBackupPath async {
    try {
      if (Platform.isAndroid) {
        // En Android 10 y superior, usar getExternalStorageDirectory()
        final externalDir = await getExternalStorageDirectory();
        if (externalDir != null) {
          // Navegar hacia arriba hasta llegar a la raíz del almacenamiento
          String path = externalDir.path;
          final List<String> folders = path.split("/");
          String newPath = "";
          for (int i = 1; i < folders.length; i++) {
            String folder = folders[i];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "/$newPath/MoneyT/Backups";
          debugPrint('Default backup path: $newPath');
          return newPath;
        }
      }
      
      // Fallback a la ruta de documentos de la aplicación
      final directory = await getApplicationDocumentsDirectory();
      final backupPath = path.join(directory.path, 'MoneyT', 'Backups');
      debugPrint('Default backup path (fallback): $backupPath');
      return backupPath;
    } catch (e) {
      debugPrint('Error getting default backup path: $e');
      rethrow;
    }
  }

  Future<String> get currentBackupPath async {
    try {
      final path = prefs.getString(backupDirKey) ?? await defaultBackupPath;
      debugPrint('Current backup path: $path');
      return path;
    } catch (e) {
      debugPrint('Error getting current backup path: $e');
      rethrow;
    }
  }

  Future<String> get _databasePath async {
    try {
      final dbFolder = await getApplicationDocumentsDirectory();
      final dbPath = path.join(dbFolder.path, 'app_database.sqlite');
      debugPrint('Database path: $dbPath');
      return dbPath;
    } catch (e) {
      debugPrint('Error getting database path: $e');
      rethrow;
    }
  }

  Future<String> createBackup() async {
    try {
      debugPrint('Starting backup process...');
      
      // Verificar permisos
      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        throw Exception('Storage permission denied');
      }

      // Crear directorio de respaldo
      final backupDir = Directory(await currentBackupPath);
      if (!backupDir.existsSync()) {
        debugPrint('Creating backup directory: ${backupDir.path}');
        await backupDir.create(recursive: true);
      }

      // Obtener la ruta actual de la base de datos
      final dbPath = await _databasePath;
      final dbFile = File(dbPath);

      // Verificar que la base de datos existe
      if (!dbFile.existsSync()) {
        debugPrint('Database file not found at: $dbPath');
        throw Exception('Database file not found');
      }

      // Generar nombre del archivo con timestamp
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final backupFile = File(path.join(backupDir.path, 'backup_$timestamp.db'));
      debugPrint('Creating backup at: ${backupFile.path}');

      // Asegurarse de que el directorio padre existe
      final parentDir = backupFile.parent;
      if (!parentDir.existsSync()) {
        await parentDir.create(recursive: true);
      }

      // Leer el archivo de la base de datos
      final bytes = await dbFile.readAsBytes();
      
      // Escribir el nuevo archivo de respaldo
      await backupFile.writeAsBytes(bytes, flush: true);
      debugPrint('Database copied successfully');

      // Mantener solo los últimos maxAutoBackups respaldos
      final backups = await listBackups();
      if (backups.length > maxAutoBackups) {
        debugPrint('Removing old backups...');
        final oldBackups = backups.sublist(maxAutoBackups);
        for (var backup in oldBackups) {
          await backup.delete();
          debugPrint('Deleted old backup: ${backup.path}');
        }
      }

      debugPrint('Backup completed successfully');
      return backupFile.path;
    } catch (e) {
      debugPrint('Error during backup process: $e');
      rethrow;
    }
  }

  Future<void> setBackupPath(String path) async {
    try {
      await prefs.setString(backupDirKey, path);
      debugPrint('Backup path updated to: $path');
    } catch (e) {
      debugPrint('Error setting backup path: $e');
      rethrow;
    }
  }

  Future<void> resetBackupPath() async {
    try {
      await prefs.remove(backupDirKey);
      debugPrint('Backup path reset to default');
    } catch (e) {
      debugPrint('Error resetting backup path: $e');
      rethrow;
    }
  }

  Future<List<File>> listBackups() async {
    try {
      final backupDir = Directory(await currentBackupPath);
      if (!backupDir.existsSync()) {
        debugPrint('Backup directory does not exist: ${backupDir.path}');
        return [];
      }

      final files = backupDir
          .listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('.db'))
          .toList();

      // Ordenar por fecha de modificación, más reciente primero
      files.sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
      debugPrint('Found ${files.length} backup files');
      return files;
    } catch (e) {
      debugPrint('Error listing backups: $e');
      rethrow;
    }
  }

  Future<void> restoreBackup(String backupPath) async {
    try {
      debugPrint('Starting restore process from: $backupPath');
      final backupFile = File(backupPath);
      if (!backupFile.existsSync()) {
        debugPrint('Backup file not found: $backupPath');
        throw Exception('Backup file not found');
      }

      // Obtener la ruta actual de la base de datos
      final dbPath = await _databasePath;
      final dbFile = File(dbPath);

      // Cerrar la conexión con la base de datos
      debugPrint('Closing database connection');
      await database.close();

      try {
        // Si existe la base de datos actual, eliminarla
        if (dbFile.existsSync()) {
          debugPrint('Deleting current database file');
          await dbFile.delete();
        }

        // Leer el archivo de respaldo
        final bytes = await backupFile.readAsBytes();
        
        // Escribir el archivo restaurado
        await dbFile.writeAsBytes(bytes, flush: true);
        debugPrint('Restore completed successfully');
      } catch (e) {
        debugPrint('Error during restore operation: $e');
        rethrow;
      }
    } catch (e) {
      debugPrint('Error in restore process: $e');
      rethrow;
    }
  }

  Future<void> deleteBackup(String backupPath) async {
    try {
      debugPrint('Deleting backup: $backupPath');
      final backupFile = File(backupPath);
      if (backupFile.existsSync()) {
        await backupFile.delete();
        debugPrint('Backup deleted successfully');
      } else {
        debugPrint('Backup file not found');
      }
    } catch (e) {
      debugPrint('Error deleting backup: $e');
      rethrow;
    }
  }

  Future<String?> exportBackup(String backupPath, String destinationPath) async {
    try {
      debugPrint('Exporting backup from: $backupPath to: $destinationPath');
      final backupFile = File(backupPath);
      if (!backupFile.existsSync()) {
        debugPrint('Source backup file not found');
        return null;
      }

      final destDir = Directory(destinationPath);
      if (!destDir.existsSync()) {
        debugPrint('Creating destination directory');
        destDir.createSync(recursive: true);
      }

      final fileName = path.basename(backupPath);
      final destFile = File(path.join(destinationPath, fileName));
      
      // Leer el archivo de respaldo
      final bytes = await backupFile.readAsBytes();
      
      // Escribir el archivo exportado
      await destFile.writeAsBytes(bytes, flush: true);
      debugPrint('Backup exported successfully to: ${destFile.path}');

      return destFile.path;
    } catch (e) {
      debugPrint('Error exporting backup: $e');
      return null;
    }
  }
}
