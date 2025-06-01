import 'package:flutter/material.dart';
import '../../core/atoms/app_button.dart';
import '../../core/molecules/form_field_container.dart';

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

    try {
      // Simulamos el proceso de login/signup
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        // Navegaríamos a la pantalla principal
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        );
      }
    } catch (e) {
      if (!mounted) return;
      
      String errorMessage = 'Ha ocurrido un error';
      _updateState((s) => s.copyWith(error: errorMessage));
    } finally {
      if (mounted) {
        _updateState((s) => s.copyWith(isLoading: false));
      }
    }
  }

  Future<void> _resetPassword() async {
    if (_emailController.text.isEmpty) {
      _updateState((s) => s.copyWith(
        error: 'Por favor, ingresa tu correo electrónico'
      ));
      return;
    }

    _updateState((s) => s.copyWith(isLoading: true, error: null));

    try {
      // Simulamos el proceso de reset de contraseña
      await Future.delayed(const Duration(seconds: 1));
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Se ha enviado un correo para restablecer la contraseña'),
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_state.isSignUp ? 'Registro' : 'Iniciar sesión'),
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: _state.isLoading 
        ? const Center(child: CircularProgressIndicator())
        : SafeArea(
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
                  FormFieldContainer(
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Correo electrónico',
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
                          return 'Ingresa tu correo electrónico';
                        }
                        if (!value.contains('@')) {
                          return 'Ingresa un correo electrónico válido';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password field
                  FormFieldContainer(
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
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
                          return 'Ingresa tu contraseña';
                        }
                        if (_state.isSignUp && value.length < 6) {
                          return 'La contraseña debe tener al menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Submit button
                  AppButton(
                    text: _state.isSignUp ? 'Registrarme' : 'Iniciar sesión',
                    onPressed: _submit,
                    type: AppButtonType.filled,
                    isFullWidth: true,
                  ),
                  const SizedBox(height: 16),

                  // Toggle sign in/up
                  AppButton(
                    text: _state.isSignUp 
                      ? '¿Ya tienes una cuenta? Inicia sesión' 
                      : '¿No tienes cuenta? Regístrate',
                    onPressed: () => _updateState((s) => s.copyWith(
                      isSignUp: !s.isSignUp,
                      error: null,
                    )),
                    type: AppButtonType.text,
                    isFullWidth: true,
                  ),

                  // Forgot password
                  if (!_state.isSignUp)
                    AppButton(
                      text: '¿Olvidaste tu contraseña?',
                      onPressed: _resetPassword,
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
