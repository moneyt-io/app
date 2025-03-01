import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/loading_overlay.dart';
import '../providers/auth_provider.dart';
import '../../core/l10n/language_manager.dart';
import '../../core/l10n/models/language.dart';
import '../routes/app_routes.dart';
import '../../data/datasources/local/database.dart';
import '../../core/di/injection_container.dart';
import '../../data/services/initialization_service.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../screens/home_screen.dart';

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
    print('_continueToApp called');
    if (_selectedLanguage == null) {
      print('No language selected');
      return;
    }

    if (!_acceptedTerms) {
      print('Terms not accepted');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.read<LanguageManager>().translations.acceptTermsAndConditions),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    print('Setting loading state');
    setState(() => _isLoading = true);

    try {
      print('Initializing app...');
      // Inicializar datos por defecto con el idioma seleccionado
      final prefs = await SharedPreferences.getInstance();
      
      // Marcar que el onboarding se ha completado
      await prefs.setBool('has_completed_onboarding', true);
      
      // Inicializar datos por defecto si es necesario
      final bool isFirstRun = prefs.getBool('first_run') ?? true;
      if (isFirstRun) {
        print('First run, initializing default data');
        final initService = InitializationService(
          getIt<AppDatabase>(),
          prefs,
          context.read<LanguageManager>(),
        );
        
        await initService.initializeDefaultDataIfNeeded();
        await prefs.setBool('first_run', false);
      }

      if (!mounted) return;

      print('Navigating to home screen');
      // Usar Navigator.pushReplacement para reemplazar la pantalla actual
      final navigator = Navigator.of(context);
      final route = MaterialPageRoute(
        builder: (context) => HomeScreen(
          transactionUseCases: getIt<TransactionUseCases>(),
        ),
      );
      await navigator.pushReplacement(route);
      
    } catch (e, stackTrace) {
      print('Error in _continueToApp: $e');
      print('Stack trace: $stackTrace');
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;
    final languages = context.watch<LanguageManager>().supportedLanguages;
    final colorScheme = Theme.of(context).colorScheme;

    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 48),
                  // Logo y título
                  Icon(
                    Icons.account_balance_wallet,
                    size: 72,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    translations.welcomeTitle,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  
                  // Selector de idioma
                  DropdownButtonFormField<Language>(
                    value: _selectedLanguage,
                    decoration: InputDecoration(
                      labelText: translations.selectLanguage,
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: colorScheme.surface,
                    ),
                    items: languages.map((Language language) {
                      return DropdownMenuItem<Language>(
                        value: language,
                        child: Text('${language.flag} ${language.nativeName}'),
                      );
                    }).toList(),
                    onChanged: _onLanguageChanged,
                  ),
                  const SizedBox(height: 32),
                  
                  // Términos y condiciones
                  Card(
                    elevation: 0,
                    color: colorScheme.surfaceVariant,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
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
                          CheckboxListTile(
                            title: Text(translations.acceptMarketing),
                            value: _acceptedMarketing,
                            onChanged: (bool? value) {
                              setState(() {
                                _acceptedMarketing = value ?? true;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Botones de inicio de sesión
                  ElevatedButton(
                    onPressed: _signInWithGoogle,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      backgroundColor: colorScheme.surface,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.g_mobiledata,
                          size: 28,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          translations.signInWithGoogle,
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      backgroundColor: colorScheme.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.email, color: colorScheme.onPrimary),
                        const SizedBox(width: 12),
                        Text(
                          translations.signInWithEmail,
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: _acceptedTerms ? _continueToApp : null,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    child: Text(translations.skipSignIn),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
