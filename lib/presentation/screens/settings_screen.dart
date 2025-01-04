// lib/presentation/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/social_links.dart';
import '../../core/l10n/language_manager.dart';
import '../../routes/app_routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = context.watch<ThemeProvider>();
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(translations.settings),
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: ListView(
        children: [
          // Sección de Apariencia
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
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
                    isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: colorScheme.primary,
                  ),
                  title: Text(translations.darkMode),
                  trailing: Switch(
                    value: isDarkMode,
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

          const SizedBox(height: 16),

          // Sección de Base de Datos
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
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

          const SizedBox(height: 16),

          // Sección Social
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: const SocialLinks(),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}