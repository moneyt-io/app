import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../../domain/entities/user_entity.dart';
import '../../core/l10n/language_manager.dart';
import '../routes/app_routes.dart';
import '../../presentation/providers/auth_provider.dart';
import '../widgets/social_links.dart';
import '../widgets/sync_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _getInitial(UserEntity? user) {
    if (user == null) return 'U';
    
    final displayName = user.displayName?.trim();
    if (displayName != null && displayName.isNotEmpty) {
      return displayName[0].toUpperCase();
    }
    
    final email = user.email.trim();
    if (email.isNotEmpty) {
      return email[0].toUpperCase();
    }
    
    return 'U';
  }

  Widget _buildAccountSection(BuildContext context, AppAuthProvider authProvider) {
    final translations = context.read<LanguageManager>().translations;
    final user = authProvider.currentUser;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              translations.account,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          if (user != null) ...[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  _getInitial(user),
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ),
              title: Text(
                user.displayName ?? user.email,
              ),
              subtitle: user.displayName != null ? Text(user.email) : null,
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.error,
              ),
              title: Text(
                translations.signOut,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              onTap: () async {
                // Mostrar diálogo de confirmación
                final shouldLogout = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Cerrar Sesión'),
                    content: const Text('¿Estás seguro que deseas cerrar sesión?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.error,
                        ),
                        child: const Text('Cerrar Sesión'),
                      ),
                    ],
                  ),
                );

                if (shouldLogout == true) {
                  await authProvider.signOut();
                }
              },
            ),
          ] else ...[
            ListTile(
              leading: Icon(
                Icons.g_mobiledata,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(translations.signInWithGoogle),
              onTap: () async {
                try {
                  await authProvider.signInWithGoogle();
                  // Forzar la reconstrucción del widget después del login
                  if (mounted) {
                    setState(() {});
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: $e'),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                    );
                  }
                }
              },
            ),
            ListTile(
              leading: Icon(
                Icons.login,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(translations.signInWithEmail),
              onTap: () async {
                await Navigator.pushNamed(context, AppRoutes.login);
                // Forzar la reconstrucción del widget después del login
                if (mounted) {
                  setState(() {});
                }
              },
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;
    final themeProvider = context.watch<ThemeProvider>();
    final authProvider = context.watch<AppAuthProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(translations.settings),
      ),
      body: ListView(
        children: [
          _buildAccountSection(context, authProvider),

          // Sección de Apariencia
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    translations.appearance,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                // Tema oscuro
                ListTile(
                  leading: Icon(
                    themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: colorScheme.primary,
                  ),
                  title: Text(translations.darkMode),
                  trailing: Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: (value) => themeProvider.toggleTheme(),
                  ),
                ),
                // Idioma
                ListTile(
                  leading: Icon(
                    Icons.language,
                    color: colorScheme.primary,
                  ),
                  title: Text(translations.language),
                  trailing: Consumer<LanguageManager>(
                    builder: (context, languageManager, child) {
                      return DropdownButton<String>(
                        value: languageManager.currentLanguage.code,
                        items: languageManager.supportedLanguages.map((lang) {
                          return DropdownMenuItem(
                            value: lang.code,
                            child: Text('${lang.flag} ${lang.nativeName}'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            languageManager.changeLanguage(value);
                          }
                        },
                        underline: const SizedBox(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Opción de Sincronización
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    translations.data,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SyncButton(),
                // Respaldos
                ListTile(
                  leading: Icon(
                    Icons.backup,
                    color: colorScheme.primary,
                  ),
                  title: Text(translations.manageBackups),
                  subtitle: Text(translations.backup),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: colorScheme.onSurface.withOpacity(0.5),
                  ),
                  onTap: () => Navigator.pushNamed(context, AppRoutes.backup),
                ),
              ],
            ),
          ),

          // Sección de Enlaces
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SocialLinks(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}