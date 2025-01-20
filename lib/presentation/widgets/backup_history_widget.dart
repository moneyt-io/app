import 'package:flutter/material.dart';
import '../../domain/repositories/backup_repository.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class BackupHistoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final backupRepo = context.read<BackupRepository>();

    return FutureBuilder<List<File>>(
      future: backupRepo.listBackups(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No backups found'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final backup = snapshot.data![index];
            return FutureBuilder<BackupMetadata>(
              future: backupRepo.getBackupMetadata(backup),
              builder: (context, metadataSnapshot) {
                if (!metadataSnapshot.hasData) {
                  return ListTile(
                    title: Text(backup.path.split('/').last),
                    leading: Icon(Icons.backup),
                  );
                }

                final metadata = metadataSnapshot.data!;
                return ListTile(
                  title: Text(backup.path.split('/').last),
                  subtitle: Text(
                    'Created: ${metadata.createdAt.toString()}\n'
                    'Size: ${(metadata.sizeInBytes / 1024).toStringAsFixed(2)} KB',
                  ),
                  leading: Icon(Icons.backup),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.restore),
                          title: Text('Restore'),
                          onTap: () async {
                            await backupRepo.restoreBackup(backup);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.share),
                          title: Text('Share'),
                          onTap: () async {
                            await backupRepo.shareBackup(backup);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.delete),
                          title: Text('Delete'),
                          onTap: () async {
                            await backupRepo.deleteBackup(backup);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
