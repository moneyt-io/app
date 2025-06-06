import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/atoms/app_button.dart';
import '../../core/molecules/settings_list_item.dart';
import '../../core/molecules/language_selector.dart';
import '../../core/molecules/theme_switcher.dart';
import '../../core/organisms/settings_section.dart';
import '../../core/organisms/account_section.dart';
import '../../core/organisms/app_drawer.dart';
import '../../core/providers/language_provider.dart';
import '../../core/l10n/l10n_helper.dart';
import '../../core/l10n/generated/strings.g.dart' show AppLocale; // Solo importar AppLocale
import '../../navigation/app_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.navigation.settings),
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Sección de cuenta
              const AccountSection(),
              const SizedBox(height: 16),
              
              // Sección de apariencia
              SettingsSection(
                title: 'Apariencia',
                icon: Icons.palette_outlined,
                children: [
                  // Selector de tema
                  const ThemeSwitcher(),
                  
                  // Selector de idioma
                  LanguageSelector(
                    languages: [
                      LanguageItem(code: 'es', name: 'Español', flag: '🇪🇸'),
                      LanguageItem(code: 'en', name: 'English', flag: '🇺🇸'),
                    ],
                    value: languageProvider.currentLocale.languageCode,
                    onChanged: (value) async {
                      if (value != null) {
                        final locale = AppLocale.values.firstWhere(
                          (locale) => locale.languageCode == value,
                          orElse: () => AppLocale.en,
                        );
                        await languageProvider.setLanguage(locale);
                      }
                    },
                    showAsDropDown: true,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Sección de gestión de datos
              SettingsSection(
                title: 'Datos',
                icon: Icons.storage_outlined,
                children: [
                  // Sincronización
                  SettingsListItem(
                    leading: Icons.sync,
                    title: 'Sincronización',
                    subtitle: 'Configurar sincronización automática',
                    trailing: Switch(
                      value: false, // Valor por defecto
                      onChanged: (value) {
                        // Aquí iría la lógica para cambiar la sincronización
                      },
                    ),
                  ),
                  
                  // Respaldos
                  SettingsListItem(
                    leading: Icons.backup,
                    title: 'Respaldos',
                    subtitle: 'Gestionar copias de seguridad',
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Navegación a la pantalla de respaldos
                      Navigator.pushNamed(context, AppRoutes.backups);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Sección de información
              SettingsSection(
                title: 'Información',
                icon: Icons.info_outline,
                children: [
                  SettingsListItem(
                    leading: Icons.privacy_tip_outlined,
                    title: 'Política de privacidad',
                    onTap: () {
                      // Abrir política de privacidad
                    },
                  ),
                  
                  SettingsListItem(
                    leading: Icons.description_outlined,
                    title: 'Términos de uso',
                    onTap: () {
                      // Abrir términos de uso
                    },
                  ),
                  
                  SettingsListItem(
                    leading: Icons.help_outline,
                    title: 'Acerca de',
                    subtitle: 'Versión 1.0.0',
                    onTap: () {
                      // Mostrar información sobre la app
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Botón de cerrar sesión (solo visible si está autenticado)
              AppButton(
                text: 'Cerrar sesión',
                type: AppButtonType.outlined,
                isFullWidth: true,
                icon: Icons.logout,
                onPressed: () {
                  // Mostrar diálogo de confirmación
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Cerrar sesión'),
                      content: const Text('¿Estás seguro que deseas cerrar la sesión?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Aquí iría la lógica para cerrar sesión
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: colorScheme.error,
                          ),
                          child: const Text('Cerrar sesión'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
