import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import '../local/database.dart';
import '../../domain/repositories/backup_repository.dart';

class BackupRepositoryImpl implements BackupRepository {
  final AppDatabase database;

  BackupRepositoryImpl({required this.database});

  Future<Directory> get _backupDirectory async {
    final appDir = await getApplicationDocumentsDirectory();
    final backupDir = Directory('${appDir.path}/backups');
    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }
    return backupDir;
  }

  @override
  Future<File> createBackup() async {
    final backupDir = await _backupDirectory;
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final backupFile = File('${backupDir.path}/backup_$timestamp.db');
    
    // Copiar la base de datos actual
    final dbPath = await database.getDatabasePath();
    final currentDb = File(dbPath);
    await currentDb.copy(backupFile.path);
    
    return backupFile;
  }

  @override
  Future<void> shareBackup(File backupFile) async {
    await Share.shareXFiles([XFile(backupFile.path)]);
  }

  @override
  Future<File?> importBackup() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['db'],
      );

      if (result != null) {
        final backupDir = await _backupDirectory;
        final importFile = File(result.files.single.path!);
        final newPath = '${backupDir.path}/${result.files.single.name}';
        return await importFile.copy(newPath);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<File>> listBackups() async {
    final backupDir = await _backupDirectory;
    return backupDir
        .listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith('.db'))
        .toList();
  }

  @override
  Future<void> restoreBackup(File backupFile) async {
    final dbPath = await database.getDatabasePath();
    final currentDb = File(dbPath);
    
    // Cerrar la conexión con la base de datos
    await database.close();

    // Copiar el backup sobre la base de datos actual
    await backupFile.copy(currentDb.path);
  }

  @override
  Future<void> deleteBackup(File backupFile) async {
    if (await backupFile.exists()) {
      await backupFile.delete();
    }
  }
}
