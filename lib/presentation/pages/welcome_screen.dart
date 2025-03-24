import 'package:flutter/material.dart';
import '../atoms/app_button.dart';
import '../molecules/language_selector.dart';
import '../molecules/terms_checkbox.dart';
import '../organisms/welcome_header.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isLoading = false;
  bool _acceptedTerms = false;
  bool _acceptedMarketing = true; // Marketing marcado por defecto
  String _selectedLanguage = 'es'; // Idioma por defecto

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Términos y Condiciones'),
          content: const SingleChildScrollView(
            child: Text(
              'Aquí irían los términos y condiciones de la aplicación. '
              'Este es un texto de ejemplo que será reemplazado en el futuro '
              'por los términos y condiciones reales de MoneyT.'
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continuar'),
            ),
          ],
        );
      },
    );
  }

  void _onLanguageChanged(String? languageCode) {
    if (languageCode == null) return;
    
    // Esta función se implementará cuando se conecte con el sistema de idiomas
    setState(() {
      _isLoading = true;
      _selectedLanguage = languageCode;
    });

    // Simular cambio de idioma
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _signInWithGoogle() async {
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes aceptar los términos y condiciones'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulación de inicio de sesión
    await Future.delayed(const Duration(seconds: 1));
    
    if (mounted) {
      setState(() => _isLoading = false);
      
      // En el futuro, este código navegaría a la pantalla principal
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Future<void> _signInWithEmail() async {
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes aceptar los términos y condiciones'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Esta función navegará a la pantalla de login
    Navigator.pushNamed(context, '/login');
  }

  Future<void> _continueAsGuest() async {
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes aceptar los términos y condiciones'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulación de inicialización
    await Future.delayed(const Duration(seconds: 1));
    
    if (mounted) {
      setState(() => _isLoading = false);
      
      // En el futuro, este código navegaría a la pantalla principal
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    // Lista de idiomas disponibles (mock)
    final languages = [
      LanguageItem(code: 'es', name: 'Español', flag: '🇪🇸'),
      LanguageItem(code: 'en', name: 'English', flag: '🇺🇸'),
      LanguageItem(code: 'fr', name: 'Français', flag: '🇫🇷'),
    ];

    return Scaffold(
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 48),
                    
                    // Logo y título
                    const WelcomeHeader(
                      title: 'Bienvenido a MoneyT',
                      subtitle: 'Tu app de finanzas personales',
                    ),
                    const SizedBox(height: 48),
                    
                    // Selector de idioma
                    LanguageSelector(
                      languages: languages,
                      value: _selectedLanguage,
                      onChanged: _onLanguageChanged, 
                      showAsDropDown: true,
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
                            TermsCheckbox(
                              label: 'Acepto los términos y condiciones',
                              value: _acceptedTerms,
                              onChanged: (bool? value) {
                                setState(() {
                                  _acceptedTerms = value ?? false;
                                });
                              },
                              onReadTerms: _showTermsDialog,
                            ),
                            CheckboxListTile(
                              title: const Text('Acepto recibir comunicaciones de marketing'),
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
                    AppButton(
                      text: 'Continuar con Google',
                      onPressed: _signInWithGoogle,
                      type: AppButtonType.secondary, // Cambiado de outlined a secondary
                      isFullWidth: true,
                      icon: Icons.g_mobiledata,
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      text: 'Continuar con Email',
                      onPressed: _signInWithEmail,
                      type: AppButtonType.primary,
                      isFullWidth: true,
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 24),
                    AppButton(
                      text: 'Continuar sin registrarme',
                      onPressed: _acceptedTerms ? _continueAsGuest : null,
                      type: AppButtonType.text,
                      isFullWidth: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
