import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/atoms/app_button.dart';
import '../../core/molecules/language_selector.dart';
import '../../core/molecules/terms_checkbox.dart';
import '../../core/organisms/welcome_header.dart';
import '../../navigation/app_routes.dart';
import 'auth_provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _acceptedTerms = false;
  bool _acceptedMarketing = true;
  String _selectedLanguage = 'es';

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Términos y Condiciones'),
        content: const Text('Términos y condiciones de MoneyT...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }

  void _onLanguageChanged(String? languageCode) {
    if (languageCode != null) {
      setState(() {
        _selectedLanguage = languageCode;
      });
    }
  }

  Future<void> _signInWithGoogle() async {
    if (!_acceptedTerms) {
      _showError('Debes aceptar los términos y condiciones');
      return;
    }

    final authProvider = context.read<AuthProvider>(); // ✅ CORREGIDO: Usar alias correcto
    
    // ✅ SIMPLIFICADO: Solo hacer sign in, no enviar preferences a Firebase
    final success = await authProvider.signInWithGoogle();
    
    // ✅ ELIMINADO: No guardar _acceptedMarketing en ningún lado
    // Las preferencias solo existen durante esta sesión
    
    if (success && mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  Future<void> _signInWithEmail() async {
    if (!_acceptedTerms) {
      _showError('Debes aceptar los términos y condiciones');
      return;
    }

    Navigator.pushNamed(context, AppRoutes.login);
  }

  Future<void> _continueAsGuest() async {
    if (!_acceptedTerms) {
      _showError('Debes aceptar los términos y condiciones');
      return;
    }

    final authProvider = context.read<AuthProvider>();
    await authProvider.continueAsGuest();
    
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Iniciando sesión...'),
                ],
              ),
            );
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 48),
                    
                    const WelcomeHeader(
                      title: 'Bienvenido a MoneyT',
                      subtitle: 'Tu app de finanzas personales',
                    ),
                    
                    const SizedBox(height: 48),
                    
                    LanguageSelector(
                      languages: const [
                        LanguageItem(code: 'es', name: 'Español', flag: '🇪🇸'),
                        LanguageItem(code: 'en', name: 'English', flag: '🇺🇸'),
                        LanguageItem(code: 'fr', name: 'Français', flag: '🇫🇷'),
                      ],
                      value: _selectedLanguage,
                      onChanged: _onLanguageChanged, 
                      showAsDropDown: true,
                    ),
                    
                    const SizedBox(height: 32),
                    
                    if (authProvider.errorMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorScheme.errorContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error, color: colorScheme.error),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                authProvider.errorMessage!,
                                style: TextStyle(color: colorScheme.error),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => authProvider.clearError(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    
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
                    
                    AppButton(
                      text: 'Continuar con Google',
                      onPressed: _signInWithGoogle,
                      type: AppButtonType.outlined,
                      isFullWidth: true,
                      icon: Icons.g_mobiledata,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    AppButton(
                      text: 'Continuar con Email',
                      onPressed: _signInWithEmail,
                      type: AppButtonType.filled,
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
          );
        },
      ),
    );
  }
}
