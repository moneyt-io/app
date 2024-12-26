// lib/presentation/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../../core/l10n/language_manager.dart';
import '../widgets/language_selector.dart';
import '../widgets/social_links.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;

    return Scaffold(
      appBar: AppBar(
        title: Text(translations.getText('settings')),
      ),
      body: ListView(
        children: [
          // Tema
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return SwitchListTile(
                title: Text(translations.getText('darkTheme')),
                subtitle: Text(translations.getText('darkThemeDescription')),
                secondary: Icon(
                  themeProvider.isDarkMode 
                    ? Icons.dark_mode 
                    : Icons.light_mode,
                ),
                value: themeProvider.isDarkMode,
                onChanged: (_) => themeProvider.toggleTheme(),
              );
            },
          ),
          const Divider(),

          // Idioma
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Text(
              translations.getText('language'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const LanguageSelector(showTitle: false),
          const Divider(),

          // Enlaces sociales
          const SocialLinks(),
        ],
      ),
    );
  }
}