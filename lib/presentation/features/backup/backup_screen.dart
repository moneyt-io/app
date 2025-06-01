import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'backup_provider.dart';
import '../../core/organisms/backup_list_item.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar los backups cuando la pantalla se inicia
    // Usamos addPostFrameCallback para asegurarnos que el context está disponible
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Check if provider is already registered before accessing it
      try {
        Provider.of<BackupProvider>(context, listen: false).loadBackups();
      } catch (e) {
        // Handle case where provider might not be ready or registered yet
        // This might happen if the screen is built before the provider setup is complete
        print("Error accessing BackupProvider on init: $e");
        // Optionally, schedule a retry or show an error message
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Asegúrate de que BackupProvider esté disponible a través de Provider
    // Esto generalmente se hace en un ancestro, como en main.dart o en un MultiProvider
    // Si no está, necesitas agregarlo:
    // ChangeNotifierProvider(create: (_) => sl<BackupProvider>(), child: ...)

    return Scaffold(
      appBar: AppBar(
        title: const Text('Respaldos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Crear nuevo respaldo',
            onPressed: () => _createNewBackup(context),
          ),
          IconButton(
            icon: const Icon(Icons.file_upload_outlined),
            tooltip: 'Importar respaldo',
            onPressed: () => _importBackup(context),
          ),
        ],
      ),
      body: Consumer<BackupProvider>(
        builder: (context, backupProvider, child) {
          if (backupProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (backupProvider.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error: ${backupProvider.errorMessage}',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final backups = backupProvider.backupFiles ?? [];

          if (backups.isEmpty) {
            return const Center(
              child: Text('No se encontraron copias de seguridad.'),
            );
          }

          return RefreshIndicator(
            onRefresh: () => backupProvider.loadBackups(),
            child: ListView.builder(
              itemCount: backups.length,
              itemBuilder: (context, index) {
                final backupFile = backups[index];
                return BackupListItem(
                  backupFile: backupFile,
                  onRestore: () => _restoreBackup(context, backupProvider, backupFile),
                  onDelete: () => _deleteBackup(context, backupProvider, backupFile),
                  onShare: () => backupProvider.shareBackup(backupFile),
                  onGetMetadata: () => backupProvider.getBackupMetadata(backupFile),
                );
              },
            ),
          );
        },
      ),
    );
  }

  // --- Métodos de Acción ---

  Future<void> _createNewBackup(BuildContext context) async {
    final backupProvider = Provider.of<BackupProvider>(context, listen: false);
    final scaffoldMessenger = ScaffoldMessenger.of(context); // Guardar referencia

    final createdFile = await backupProvider.createBackup();

    if (mounted) { // Verificar si el widget sigue montado
       if (createdFile != null) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Copia de seguridad creada con éxito.')),
        );
      } else if (backupProvider.errorMessage != null) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('Error al crear: ${backupProvider.errorMessage}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  Future<void> _importBackup(BuildContext context) async {
    final backupProvider = Provider.of<BackupProvider>(context, listen: false);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final importedFile = await backupProvider.importBackupFromFile();

     if (mounted) {
        if (importedFile != null) {
          scaffoldMessenger.showSnackBar(
            const SnackBar(content: Text('Archivo importado. Ahora puedes restaurarlo.')),
          );
        } else if (backupProvider.errorMessage != null && backupProvider.errorMessage != 'Error al importar la copia de seguridad: File selection cancelled') {
          // No mostrar error si el usuario canceló la selección
           scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text('Error al importar: ${backupProvider.errorMessage}'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
     }
  }

  Future<void> _restoreBackup(BuildContext context, BackupProvider backupProvider, File backupFile) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context); // Guardar referencia

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Restaurar Copia de Seguridad'),
          content: Text('¿Estás seguro de que deseas restaurar desde "${backupFile.path.split(Platform.pathSeparator).last}"? La base de datos actual será reemplazada.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(dialogContext).pop(false),
            ),
            TextButton(
              child: Text('Restaurar', style: TextStyle(color: Theme.of(context).colorScheme.error)),
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      final success = await backupProvider.restoreBackup(backupFile);
       if (mounted) { // Verificar si el widget sigue montado
          if (success) {
            // Mostrar mensaje y potencialmente reiniciar la app o navegar a una pantalla de carga
            scaffoldMessenger.showSnackBar(
              const SnackBar(content: Text('Restauración iniciada. La aplicación podría necesitar reiniciarse.')),
            );
            // Considera forzar un reinicio o navegar a una pantalla que maneje la recarga de datos.
            // Por ejemplo, podrías navegar a la pantalla de inicio:
            // navigator.pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
          } else if (backupProvider.errorMessage != null) {
            scaffoldMessenger.showSnackBar(
              SnackBar(
                content: Text('Error al restaurar: ${backupProvider.errorMessage}'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
       }
    }
  }

  Future<void> _deleteBackup(BuildContext context, BackupProvider backupProvider, File backupFile) async {
     final scaffoldMessenger = ScaffoldMessenger.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Eliminar Copia de Seguridad'),
          content: Text('¿Estás seguro de que deseas eliminar el archivo "${backupFile.path.split(Platform.pathSeparator).last}"? Esta acción no se puede deshacer.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(dialogContext).pop(false),
            ),
            TextButton(
              child: Text('Eliminar', style: TextStyle(color: Theme.of(context).colorScheme.error)),
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await backupProvider.deleteBackup(backupFile);
       if (mounted) { // Verificar si el widget sigue montado
          if (backupProvider.errorMessage == null) {
            scaffoldMessenger.showSnackBar(
              const SnackBar(content: Text('Copia de seguridad eliminada.')),
            );
          } else {
            scaffoldMessenger.showSnackBar(
              SnackBar(
                content: Text('Error al eliminar: ${backupProvider.errorMessage}'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
       }
    }
  }
}
