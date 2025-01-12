import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sync_provider.dart';

class SyncActionButton extends StatefulWidget {
  const SyncActionButton({Key? key}) : super(key: key);

  @override
  State<SyncActionButton> createState() => _SyncActionButtonState();
}

class _SyncActionButtonState extends State<SyncActionButton> {
  bool _isSyncing = false;

  Future<void> _handleSync() async {
    final syncProvider = context.read<SyncProvider>();
    
    if (!syncProvider.isSyncEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sync is disabled. Enable it in settings.')),
      );
      return;
    }

    if (_isSyncing) return;

    setState(() => _isSyncing = true);

    try {
      await syncProvider.forceSyncNow();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sync completed successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sync failed: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSyncing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isSyncing 
        ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
        : const Icon(Icons.sync),
      onPressed: _isSyncing ? null : _handleSync,
      tooltip: 'Sync now',
    );
  }
}