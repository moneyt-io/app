// lib/presentation/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../../core/l10n/language_manager.dart';
import '../widgets/social_links.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(translations.settings),
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
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
                // Tema
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return ListTile(
                      leading: Icon(
                        themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                        color: colorScheme.primary,
                      ),
                      title: Text(translations.darkTheme),
                      subtitle: Text(translations.darkThemeDescription),
                      trailing: Switch(
                        value: themeProvider.isDarkMode,
                        onChanged: (_) => themeProvider.toggleTheme(),
                      ),
                    );
                  },
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
                            child: Text(lang.nativeName),
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
          // Enlaces sociales
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
                    translations.about,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SocialLinks(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}