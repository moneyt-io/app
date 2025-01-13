import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/language_manager.dart';
import '../providers/sync_provider.dart';
import '../providers/auth_provider.dart';

class SyncButton extends StatelessWidget {
  const SyncButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;
    final authProvider = context.watch<AppAuthProvider>();
    final isLoggedWithGoogle = authProvider.isAuthenticated && authProvider.currentUser != null;

    return Consumer<SyncProvider>(
      builder: (context, syncProvider, child) {
        return ListTile(
          leading: Icon(
            Icons.sync_rounded,
            color: isLoggedWithGoogle ? colorScheme.primary : colorScheme.onSurfaceVariant,
          ),
          title: Text(translations.sync),
          subtitle: Text(
            !isLoggedWithGoogle 
                ? translations.syncError 
                : (syncProvider.isSyncEnabled ? translations.syncing : translations.syncNever),
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
          trailing: Switch(
            value: syncProvider.isSyncEnabled,
            onChanged: isLoggedWithGoogle 
                ? (value) async {
                    await syncProvider.setSyncEnabled(value);
                    if (!context.mounted) return;
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          value ? translations.syncSuccess : translations.syncError,
                        ),
                        backgroundColor: value ? colorScheme.primary : colorScheme.error,
                      ),
                    );
                  }
                : null,
          ),
        );
      },
    );
  }
}