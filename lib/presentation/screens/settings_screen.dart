// lib/presentation/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        children: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return SwitchListTile(
                title: const Text('Modo Oscuro'),
                subtitle: const Text('Cambiar entre tema claro y oscuro'),
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
          // Aquí puedes agregar más opciones de configuración
        ],
      ),
    );
  }
}