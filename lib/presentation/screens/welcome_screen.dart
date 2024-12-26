import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/l10n/language_manager.dart';
import '../../core/l10n/models/language.dart';
import '../../routes/app_routes.dart';
import '../../main.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Language? _selectedLanguage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = context.read<LanguageManager>().currentLanguage;
  }

  Future<void> _continueToApp() async {
    if (_selectedLanguage == null) return;

    setState(() => _isLoading = true);

    try {
      // Cambiar el idioma
      final languageManager = context.read<LanguageManager>();
      await languageManager.changeLanguage(_selectedLanguage!.code);

      // Inicializar la base de datos y los datos por defecto
      await AppInitializer.initializeDatabase();

      // Marcar que ya no es primera ejecución
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_first_run', false);

      if (!mounted) return;

      // Navegar a la pantalla principal
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageManager = Provider.of<LanguageManager>(context);
    final translations = languageManager.translations;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo o Icono
              const Icon(
                Icons.account_balance_wallet,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 32),

              // Título de bienvenida
              Text(
                translations.welcome,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Texto de selección de idioma
              Text(
                translations.selectLanguage,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Lista de idiomas
              Card(
                elevation: 4,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: languageManager.supportedLanguages.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final language = languageManager.supportedLanguages[index];
                    return RadioListTile<Language>(
                      title: Row(
                        children: [
                          Text(language.flag),
                          const SizedBox(width: 12),
                          Text(language.nativeName),
                        ],
                      ),
                      subtitle: Text(language.name),
                      value: language,
                      groupValue: _selectedLanguage,
                      onChanged: (Language? value) {
                        setState(() => _selectedLanguage = value);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 48),

              // Botón continuar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _continueToApp,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(translations.continue_),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
