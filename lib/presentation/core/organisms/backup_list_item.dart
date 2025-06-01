import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:filesize/filesize.dart'; // Necesitarás añadir esta dependencia: flutter pub add filesize
import '../../../domain/repositories/backup_repository.dart'; // Para BackupMetadata

/// Widget para mostrar un elemento individual en la lista de copias de seguridad.
class BackupListItem extends StatelessWidget {
  final File backupFile;
  final VoidCallback onRestore;
  final VoidCallback onDelete;
  final VoidCallback onShare;
  final Future<BackupMetadata?> Function() onGetMetadata; // Función para obtener metadatos

  const BackupListItem({
    super.key,
    required this.backupFile,
    required this.onRestore,
    required this.onDelete,
    required this.onShare,
    required this.onGetMetadata,
  });

  @override
  Widget build(BuildContext context) {
    final fileName = backupFile.path.split(Platform.pathSeparator).last;
    final lastModified = backupFile.lastModifiedSync();

    return ListTile(
      leading: const Icon(Icons.archive_outlined),
      title: Text(
        fileName,
        style: const TextStyle(fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        'Fecha: ${DateFormat('dd/MM/yyyy HH:mm').format(lastModified)}',
      ),
      trailing: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert),
        onSelected: (String result) {
          switch (result) {
            case 'restore':
              onRestore();
              break;
            case 'share':
              onShare();
              break;
            case 'details':
              _showDetailsDialog(context);
              break;
            case 'delete':
              onDelete();
              break;
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'restore',
            child: ListTile(
              leading: Icon(Icons.restore),
              title: Text('Restaurar'),
            ),
          ),
          const PopupMenuItem<String>(
            value: 'share',
            child: ListTile(
              leading: Icon(Icons.share),
              title: Text('Compartir'),
            ),
          ),
          const PopupMenuItem<String>(
            value: 'details',
            child: ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Detalles'),
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'delete',
            child: ListTile(
              leading: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.error),
              title: Text('Eliminar', style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ),
          ),
        ],
      ),
      onTap: () => _showDetailsDialog(context), // Mostrar detalles al tocar el item
    );
  }

  /// Muestra un diálogo con los metadatos del archivo de backup.
  void _showDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return FutureBuilder<BackupMetadata?>(
          future: onGetMetadata(), // Llama a la función para obtener metadatos
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AlertDialog(
                title: Text('Detalles del Backup'),
                content: Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.hasError || snapshot.data == null) {
              return AlertDialog(
                title: const Text('Detalles del Backup'),
                content: Text('Error al obtener detalles: \${snapshot.error ?? "No se pudieron cargar los datos."}'),
                actions: [
                  TextButton(
                    child: const Text('Cerrar'),
                    onPressed: () => Navigator.of(dialogContext).pop(),
                  ),
                ],
              );
            }

            final metadata = snapshot.data!;
            final fileName = metadata.additionalInfo['fileName'] ?? 'N/A';
            final formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(metadata.createdAt);
            final formattedSize = filesize(metadata.sizeInBytes); // Formatea el tamaño

            return AlertDialog(
              title: const Text('Detalles del Backup'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    _buildDetailRow(context, 'Archivo:', fileName),
                    _buildDetailRow(context, 'Fecha Creación:', formattedDate),
                    _buildDetailRow(context, 'Tamaño:', formattedSize),
                    _buildDetailRow(context, 'Versión App:', metadata.appVersion),
                    // Puedes añadir más detalles de metadata.additionalInfo si lo deseas
                    // _buildDetailRow(context, 'Modo:', metadata.additionalInfo['mode'] ?? 'N/A'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cerrar'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Widget auxiliar para mostrar una fila de detalle en el diálogo.
  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style, // Usar estilo por defecto del contexto
          children: <TextSpan>[
            TextSpan(text: '$label ', style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
