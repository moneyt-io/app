import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import 'auth_provider.dart' as app_auth; // ✅ AGREGADO: Alias para consistencia

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> _signInWithGoogle() async {
    HapticFeedback.mediumImpact();
    
    final authProvider = context.read<app_auth.AuthProvider>(); // ✅ CORREGIDO: Usar alias
    final success = await authProvider.signInWithGoogle();
    
    if (success && mounted) {
      NavigationService.navigateToAndClearStack(AppRoutes.home);
    }
  }

  void _skipForNow() {
    HapticFeedback.lightImpact();
    
    final authProvider = context.read<app_auth.AuthProvider>(); // ✅ CORREGIDO: Usar alias
    authProvider.continueAsGuest().then((_) {
      if (mounted) {
        NavigationService.navigateToAndClearStack(AppRoutes.home);
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
                    
                    // Google Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _signInWithGoogle,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF1F2937),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // ✅ MEJORADO: Icono de Google con proporciones oficiales
                            _buildGoogleIcon(),
                            const SizedBox(width: 12),
                            const Text(
                              'Continuar con Google',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
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

  // ✅ MEJORADO: Icono de Google con proporciones oficiales
  Widget _buildGoogleIcon() {
    return SizedBox(
      width: 20,
      height: 20,
      child: CustomPaint(
        painter: GoogleIconPainter(),
      ),
    );
  }
}

// ✅ MEJORADO: Painter del logo oficial de Google con proporciones correctas
class GoogleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    // Escalar al tamaño del widget
    final scale = size.width / 24.0;
    canvas.scale(scale);

    // Azul - Parte derecha de la "G"
    paint.color = const Color(0xFF4285F4);
    Path bluePath = Path();
    bluePath.moveTo(22.56, 12.25);
    bluePath.cubicTo(22.56, 11.47, 22.49, 10.72, 22.36, 10.0);
    bluePath.lineTo(12.0, 10.0);
    bluePath.lineTo(12.0, 14.26);
    bluePath.lineTo(17.92, 14.26);
    bluePath.cubicTo(17.66, 15.63, 16.88, 16.79, 15.71, 17.57);
    bluePath.lineTo(15.71, 20.34);
    bluePath.lineTo(19.28, 20.34);
    bluePath.cubicTo(21.36, 18.42, 22.56, 15.6, 22.56, 12.25);
    bluePath.close();
    canvas.drawPath(bluePath, paint);

    // Verde - Parte inferior derecha
    paint.color = const Color(0xFF34A853);
    Path greenPath = Path();
    greenPath.moveTo(12.0, 23.0);
    greenPath.cubicTo(14.97, 23.0, 17.46, 22.02, 19.28, 20.34);
    greenPath.lineTo(15.71, 17.57);
    greenPath.cubicTo(14.73, 18.23, 13.48, 18.63, 12.0, 18.63);
    greenPath.cubicTo(9.14, 18.63, 6.71, 16.7, 5.84, 14.1);
    greenPath.lineTo(2.18, 14.1);
    greenPath.lineTo(2.18, 16.94);
    greenPath.cubicTo(3.99, 20.53, 7.7, 23.0, 12.0, 23.0);
    greenPath.close();
    canvas.drawPath(greenPath, paint);

    // Amarillo - Parte inferior izquierda
    paint.color = const Color(0xFFFBBC05);
    Path yellowPath = Path();
    yellowPath.moveTo(5.84, 14.09);
    yellowPath.cubicTo(5.62, 13.43, 5.49, 12.73, 5.49, 12.0);
    yellowPath.cubicTo(5.49, 11.27, 5.62, 10.57, 5.84, 9.91);
    yellowPath.lineTo(5.84, 7.07);
    yellowPath.lineTo(2.18, 7.07);
    yellowPath.cubicTo(1.43, 8.55, 1.0, 10.22, 1.0, 12.0);
    yellowPath.cubicTo(1.0, 13.78, 1.43, 15.45, 2.18, 16.93);
    yellowPath.lineTo(5.03, 14.71);
    yellowPath.lineTo(5.84, 14.09);
    yellowPath.close();
    canvas.drawPath(yellowPath, paint);

    // Rojo - Parte superior izquierda
    paint.color = const Color(0xFFEA4335);
    Path redPath = Path();
    redPath.moveTo(12.0, 5.38);
    redPath.cubicTo(13.62, 5.38, 15.06, 5.94, 16.21, 7.02);
    redPath.lineTo(19.36, 3.87);
    redPath.cubicTo(17.45, 2.09, 14.97, 1.0, 12.0, 1.0);
    redPath.cubicTo(7.7, 1.0, 3.99, 3.47, 2.18, 7.07);
    redPath.lineTo(5.84, 9.91);
    redPath.cubicTo(6.71, 7.31, 9.14, 5.38, 12.0, 5.38);
    redPath.close();
    canvas.drawPath(redPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}