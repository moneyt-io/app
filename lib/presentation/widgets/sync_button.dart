import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sync_provider.dart';

class SyncButton extends StatelessWidget {
  const SyncButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SyncProvider>(
      builder: (context, syncProvider, child) {
        return _buildSyncSwitch(context, syncProvider);
      },
    );
  }

  Widget _buildSyncSwitch(BuildContext context, SyncProvider syncProvider) {
    return SwitchListTile(
      title: Text('Synchronization'),
      value: syncProvider.isSyncEnabled,
      onChanged: (value) async {
        await syncProvider.setSyncEnabled(value);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(value ? 'Synchronization enabled' : 'Synchronization disabled'),
          ),
        );
      },
      secondary: Icon(Icons.sync),
    );
  }
}