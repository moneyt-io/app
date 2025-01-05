import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/loading_overlay.dart';
import '../providers/auth_provider.dart';
import '../../core/l10n/language_manager.dart';
import '../../core/l10n/models/language.dart';
import '../../routes/app_routes.dart';
import '../../data/local/database.dart';
import '../../core/di/injection_container.dart';
import '../../data/services/initialization_service.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Language? _selectedLanguage;
  bool _isLoading = false;
  bool _acceptedTerms = false;
  bool _acceptedMarketing = true; // Marketing marcado por defecto

  @override
  void initState() {
    super.initState();
    _selectedLanguage = context.read<LanguageManager>().currentLanguage;
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final translations = context.read<LanguageManager>().translations;
        return AlertDialog(
          title: Text(translations.termsAndConditions),
          content: SingleChildScrollView(
            child: Text(translations.termsText),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(translations.continue_),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onLanguageChanged(Language? newValue) async {
    if (newValue == null) return;
    
    setState(() {
      _selectedLanguage = newValue;
      _isLoading = true;
    });

    // Cambiar el idioma
    final languageManager = context.read<LanguageManager>();
    await languageManager.changeLanguage(newValue.code);

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _signInWithGoogle() async {
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.read<LanguageManager>().translations.acceptTerms),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authProvider = context.read<AppAuthProvider>();
      await authProvider.signInWithGoogle();
      
      if (!mounted) return;

      if (authProvider.isAuthenticated) {
        await _continueToApp();
      }
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

  Future<void> _continueToApp() async {
    if (_selectedLanguage == null) return;

    setState(() => _isLoading = true);

    try {
      // Inicializar datos por defecto con el idioma seleccionado
      final prefs = await SharedPreferences.getInstance();
      final bool isFirstRun = prefs.getBool('is_first_run') ?? true;
      
      if (isFirstRun) {
        final initService = InitializationService(
          getIt<AppDatabase>(),
          prefs,
          context.read<LanguageManager>(),
        );
        
        await initService.initializeDefaultDataIfNeeded();
        await prefs.setBool('is_first_run', false);
      }

      if (!mounted) return;

      // Navegar a la pantalla principal
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;
    final languages = context.watch<LanguageManager>().supportedLanguages;

    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo de la app
                const SizedBox(height: 24),
                Text(
                  translations.welcomeTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                DropdownButtonFormField<Language>(
                  value: _selectedLanguage,
                  decoration: InputDecoration(
                    labelText: translations.selectLanguage,
                    border: const OutlineInputBorder(),
                  ),
                  items: languages.map((Language language) {
                    return DropdownMenuItem<Language>(
                      value: language,
                      child: Text('${language.flag} ${language.nativeName}'),
                    );
                  }).toList(),
                  onChanged: _onLanguageChanged,
                ),
                const SizedBox(height: 24),
                CheckboxListTile(
                  title: Text(translations.acceptTermsAndConditions),
                  value: _acceptedTerms,
                  onChanged: (bool? value) {
                    setState(() {
                      _acceptedTerms = value ?? false;
                    });
                  },
                ),
                TextButton(
                  onPressed: _showTermsDialog,
                  child: Text(translations.readTerms),
                ),
                const SizedBox(height: 8),
                CheckboxListTile(
                  title: Text(translations.acceptMarketing),
                  value: _acceptedMarketing,
                  onChanged: (bool? value) {
                    setState(() {
                      _acceptedMarketing = value ?? true;
                    });
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _signInWithGoogle,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12.0),
                    backgroundColor: Colors.white,
                    elevation: 2,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.g_translate, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        translations.signInWithGoogle,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.email, size: 24, color: Theme.of(context).colorScheme.onPrimary),
                      const SizedBox(width: 12),
                      Text(translations.signInWithEmail),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _continueToApp,
                  child: Text(translations.skipSignIn),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
