import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import 'auth_provider.dart' as app_auth; // ✅ AGREGADO: Alias para consistencia

class LoginScreen extends StatefulWidget {
  final bool hasJustSeenPaywall;

  const LoginScreen({Key? key, this.hasJustSeenPaywall = false}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  void _skipForNow() {
    HapticFeedback.lightImpact();
    
    final authProvider = context.read<app_auth.AuthProvider>(); // ✅ CORREGIDO: Usar alias
    authProvider.continueAsGuest().then((_) {
      if (mounted) {
        NavigationService.navigateToAndClearStack(
          AppRoutes.home,
          arguments: {'hasJustSeenPaywall': widget.hasJustSeenPaywall},
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0F2FE),
              Color(0xFFDDD6FE),
              Color(0xFFECFDF5),
            ],
          ),
        ),
        child: SafeArea(
          child: Consumer<app_auth.AuthProvider>( // ✅ CORREGIDO: Usar alias
            builder: (context, authProvider, child) {
              if (authProvider.isLoading) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Conectando...'),
                    ],
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4AE3B5), Color(0xFF059669)],
                        ),
                      ),
                      child: const Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Title
                    const Text(
                      'Bienvenido a MoneyT',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Subtitle
                    const Text(
                      'Inicia sesión para comenzar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF64748B),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 48),
                    
                    // Error Message
                    if (authProvider.errorMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 24),
                        decoration: BoxDecoration(
                          color: colorScheme.errorContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error, color: colorScheme.error),
                            const SizedBox(width: 12),
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
                    ],
                    
                    const SizedBox(height: 16),
                    
                    // Skip Button
                    TextButton(
                      onPressed: _skipForNow,
                      child: const Text(
                        'Continuar sin cuenta', // ✅ CAMBIADO: De "Explorar" a "Continuar"
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Features
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFeature(Icons.security, 'Seguro', Colors.green),
                        _buildFeature(Icons.sync, 'Sync', Colors.blue),
                        _buildFeature(Icons.account_balance, 'Banking', Colors.purple),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

}
