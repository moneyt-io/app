import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart' show AppAuthProvider;
import '../widgets/loading_overlay.dart';
import '../../core/l10n/language_manager.dart';
import '../routes/app_routes.dart';

// Estado del formulario de login
class LoginFormState {
  final String email;
  final String password;
  final bool isSignUp;
  final bool obscurePassword;
  final bool isLoading;
  final String? error;

  const LoginFormState({
    this.email = '',
    this.password = '',
    this.isSignUp = false,
    this.obscurePassword = true,
    this.isLoading = false,
    this.error,
  });

  LoginFormState copyWith({
    String? email,
    String? password,
    bool? isSignUp,
    bool? obscurePassword,
    bool? isLoading,
    String? error,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSignUp: isSignUp ?? this.isSignUp,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  var _state = const LoginFormState();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateState(LoginFormState Function(LoginFormState) update) {
    setState(() {
      _state = update(_state);
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    _updateState((s) => s.copyWith(isLoading: true, error: null));
    print('Starting login/signup process...'); // Debug log

    try {
      final authProvider = context.read<AppAuthProvider>();
   
      if (_state.isSignUp) {
        print('Attempting signup...'); // Debug log
        await authProvider.signUpWithEmailPassword(
          _emailController.text,
          _passwordController.text,
        );
      } else {
        print('Attempting login...'); // Debug log
        await authProvider.signInWithEmailPassword(
          _emailController.text,
          _passwordController.text,
        );
      }

      if (!mounted) return;

      // Verificar el estado de autenticación después de un breve delay
      // para asegurar que Firebase haya actualizado el estado
      await Future.delayed(const Duration(milliseconds: 500));
      print('Checking authentication state...'); // Debug log
      
      if (authProvider.isAuthenticated && authProvider.currentUser != null) {
        print('Authentication successful, navigating to home...'); // Debug log
        if (!mounted) return;
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.home,
          (route) => false,
        );
      } else {
        print('Authentication state check failed'); // Debug log
        throw Exception('authentication-failed');
      }
    } catch (e) {
      print('Error caught: $e'); // Debug log
      if (!mounted) return;
      
      final translations = context.read<LanguageManager>().translations;
      String errorMessage;

      // Extraer el mensaje de error real
      final errorString = e.toString().toLowerCase();
      print('Processing error: $errorString'); // Debug log

      if (errorString.contains('invalid-credentials') ||
          errorString.contains('user-not-found') ||
          errorString.contains('wrong-password') ||
          errorString.contains('invalid-credential')) {
        errorMessage = translations.invalidCredentials;
      } else if (errorString.contains('email-already-in-use')) {
        errorMessage = translations.emailAlreadyInUse;
      } else if (errorString.contains('weak-password')) {
        errorMessage = translations.weakPassword;
      } else if (errorString.contains('network-error') ||
                 errorString.contains('network-request-failed')) {
        errorMessage = translations.networkError;
      } else {
        errorMessage = '${translations.unknownError}: $errorString';
      }

      print('Setting error message: $errorMessage'); // Debug log
      
      // Asegurarnos de que el estado se actualice en el siguiente frame
      Future.microtask(() {
        if (mounted) {
          _updateState((s) => s.copyWith(error: errorMessage));
        }
      });
    } finally {
      if (mounted) {
        _updateState((s) => s.copyWith(isLoading: false));
      }
    }
  }

  Future<void> _resetPassword() async {
    if (_emailController.text.isEmpty) {
      _updateState((s) => s.copyWith(
        error: context.read<LanguageManager>().translations.emailRequired
      ));
      return;
    }

    _updateState((s) => s.copyWith(isLoading: true, error: null));

    try {
      await context.read<AppAuthProvider>().resetPassword(_emailController.text);
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.read<LanguageManager>().translations.passwordResetEmailSent),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      _updateState((s) => s.copyWith(error: e.toString()));
    } finally {
      if (mounted) {
        _updateState((s) => s.copyWith(isLoading: false));
      }
    }
  }

  Widget _buildErrorBanner() {
    if (_state.error == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.error.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _state.error!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onErrorContainer,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: Theme.of(context).colorScheme.onErrorContainer,
              size: 20,
            ),
            onPressed: () => _updateState((s) => s.copyWith(error: null)),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final translations = context.watch<LanguageManager>().translations;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return LoadingOverlay(
      isLoading: _state.isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_state.isSignUp ? translations.signUp : translations.signIn),
          backgroundColor: colorScheme.surface,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildErrorBanner(),
                  ),

                  // Email field
                  FilledButton.tonal(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: colorScheme.surfaceVariant.withOpacity(0.3),
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: translations.email,
                        prefixIcon: Icon(
                          Icons.email,
                          color: colorScheme.primary,
                        ),
                        border: InputBorder.none,
                        filled: false,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return translations.emailRequired;
                        }
                        if (!value.contains('@')) {
                          return translations.invalidEmail;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password field
                  FilledButton.tonal(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: colorScheme.surfaceVariant.withOpacity(0.3),
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: translations.password,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: colorScheme.primary,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _state.obscurePassword ? Icons.visibility : Icons.visibility_off,
                            color: colorScheme.primary,
                          ),
                          onPressed: () {
                            _updateState((s) => s.copyWith(
                              obscurePassword: !s.obscurePassword
                            ));
                          },
                        ),
                        border: InputBorder.none,
                        filled: false,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      obscureText: _state.obscurePassword,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return translations.passwordRequired;
                        }
                        if (_state.isSignUp && value.length < 6) {
                          return translations.passwordTooShort;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Submit button
                  FilledButton(
                    onPressed: _submit,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      _state.isSignUp ? translations.signUp : translations.signIn,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Toggle sign in/up
                  TextButton(
                    onPressed: () => _updateState((s) => s.copyWith(
                      isSignUp: !s.isSignUp,
                      error: null,
                    )),
                    child: Text(
                      _state.isSignUp 
                        ? translations.alreadyHaveAccount 
                        : translations.dontHaveAccount,
                    ),
                  ),

                  // Forgot password
                  if (!_state.isSignUp)
                    TextButton(
                      onPressed: _resetPassword,
                      child: Text(translations.forgotPassword),
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
