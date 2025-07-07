import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import '../../core/atoms/app_button.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import 'package:package_info_plus/package_info_plus.dart'; // ✅ AGREGADO: Para versión dinámica

/// Pantalla de login simplificada - Enfoque Minimalista Premium
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _logoController;
  late AnimationController _particlesController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _logoScale;
  late Animation<double> _logoRotation;
  late Animation<double> _particlesAnimation;
  
  bool _isLoading = false;
  String? _error;
  String _appVersion = '1.0.0'; // ✅ AGREGADO: Variable para versión dinámica

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startEntryAnimations();
    _loadAppVersion(); // ✅ AGREGADO: Cargar versión real
  }

  /// ✅ AGREGADO: Cargar versión real de la aplicación
  Future<void> _loadAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      if (mounted) {
        setState(() {
          _appVersion = packageInfo.version;
        });
      }
    } catch (e) {
      // Mantener versión por defecto si hay error
      print('Error loading app version: $e');
    }
  }

  void _initializeAnimations() {
    // ✅ MEJORADO: Animaciones más sofisticadas
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    );

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _particlesController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutQuart),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15), // ✅ REDUCIDO: Menos movimiento, más sutil
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // ✅ NUEVO: Animación de logo más elegante
    _logoScale = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    ));

    _logoRotation = Tween<double>(
      begin: -0.1,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.3, 0.8, curve: Curves.easeOutBack),
    ));

    // ✅ NUEVO: Animación sutil para partículas flotantes
    _particlesAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _particlesController,
      curve: Curves.linear,
    ));
  }

  void _startEntryAnimations() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _fadeController.forward();
        _slideController.forward();
        _logoController.forward();
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _logoController.dispose();
    _particlesController.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    HapticFeedback.mediumImpact(); // ✅ MEJORADO: Feedback más prominente
    
    setState(() => _isLoading = true);

    // Simulación de Google Sign In
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() => _isLoading = false);
      
      // Navegar al dashboard
      NavigationService.navigateToAndClearStack(AppRoutes.home);
    }
  }

  void _skipForNow() {
    HapticFeedback.lightImpact();
    NavigationService.navigateToAndClearStack(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // ✅ MEJORADO: Gradiente más vibrante y dinámico
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0F2FE), // sky-100 - Más vibrante
              Color(0xFFDDD6FE), // violet-200 - Más saturado
              Color(0xFFECFDF5), // emerald-50 - Toque de verde
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // ✅ MEJORADO: Partículas flotantes animadas
            ..._buildAnimatedParticles(),
            
            // Main Content - Layout más compacto
            SafeArea(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: _buildMainContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ NUEVO: Partículas flotantes animadas para dinamismo
  List<Widget> _buildAnimatedParticles() {
    return [
      // Partícula grande superior derecha
      AnimatedBuilder(
        animation: _particlesAnimation,
        builder: (context, child) {
          return Positioned(
            top: -150 + (50 * (_particlesAnimation.value * 2 % 1)),
            right: -150 + (30 * (_particlesAnimation.value * 1.5 % 1)),
            child: Transform.rotate(
              angle: _particlesAnimation.value * 0.5,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF60A5FA).withOpacity(0.15),
                      const Color(0xFF3B82F6).withOpacity(0.05),
                      Colors.transparent,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        },
      ),
      
      // Partícula mediana inferior izquierda
      AnimatedBuilder(
        animation: _particlesAnimation,
        builder: (context, child) {
          return Positioned(
            bottom: -100 + (40 * (_particlesAnimation.value * 1.8 % 1)),
            left: -100 + (25 * (_particlesAnimation.value * 1.3 % 1)),
            child: Transform.rotate(
              angle: -_particlesAnimation.value * 0.3,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF34D399).withOpacity(0.12),
                      const Color(0xFF10B981).withOpacity(0.04),
                      Colors.transparent,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        },
      ),

      // Partícula pequeña centro derecho
      AnimatedBuilder(
        animation: _particlesAnimation,
        builder: (context, child) {
          return Positioned(
            top: MediaQuery.of(context).size.height * 0.3 + (20 * (_particlesAnimation.value * 2.2 % 1)),
            right: -80 + (15 * (_particlesAnimation.value * 1.7 % 1)),
            child: Transform.scale(
              scale: 0.8 + (0.2 * (_particlesAnimation.value * 3 % 1)),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFA78BFA).withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        },
      ),
    ];
  }

  /// ✅ MEJORADO: Layout más compacto y elegante
  Widget _buildMainContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40), // ✅ AUMENTADO: Más padding lateral
      child: Column(
        children: [
          const SizedBox(height: 40), // ✅ REDUCIDO: Menos espacio superior
          
          // Logo y Header
          _buildEnhancedHeader(),
          
          const SizedBox(height: 60), // ✅ REDUCIDO: Menos espacio entre header y card
          
          // Form Card - Más prominente
          _buildPremiumFormCard(),
          
          const SizedBox(height: 40), // ✅ REDUCIDO: Menos espacio entre card y features
          
          // Features Preview - Más elegante
          _buildElegantFeaturesPreview(),
          
          const Spacer(), // ✅ MANTENIDO: Solo el spacer inferior para empujar todo hacia arriba
        ],
      ),
    );
  }

  /// ✅ MEJORADO: Header con animaciones más sofisticadas
  Widget _buildEnhancedHeader() {
    return Column(
      children: [
        // Logo animado
        AnimatedBuilder(
          animation: Listenable.merge([_logoScale, _logoRotation]),
          builder: (context, child) {
            return Transform.scale(
              scale: _logoScale.value,
              child: Transform.rotate(
                angle: _logoRotation.value,
                child: Container(
                  width: 88, // ✅ AUMENTADO: Más prominente
                  height: 88,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // ✅ AUMENTADO: Más redondeado
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF4AE3B5),
                        Color(0xFF36D399),
                        Color(0xFF059669), // ✅ AGREGADO: Tercer color para más profundidad
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4AE3B5).withOpacity(0.4), // ✅ AUMENTADO: Sombra más prominente
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                      BoxShadow(
                        color: const Color(0xFF4AE3B5).withOpacity(0.2),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                    size: 40, // ✅ AUMENTADO: Ícono más grande
                  ),
                ),
              ),
            );
          },
        ),
        
        const SizedBox(height: 32), // ✅ AUMENTADO: Más espacio para respirar
        
        // Title con animación de texto
        const Text(
          'Bienvenido a MoneyT',
          style: TextStyle(
            fontSize: 32, // ✅ AUMENTADO: Más prominente
            fontWeight: FontWeight.w800, // ✅ AUMENTADO: Más peso
            color: Color(0xFF0F172A),
            height: 1.1,
            letterSpacing: -0.5, // ✅ AGREGADO: Tracking más ajustado
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 16), // ✅ AUMENTADO: Más espacio
        
        // Subtitle mejorado
        const Text(
          'Inicia sesión para comenzar tu viaje financiero',
          style: TextStyle(
            fontSize: 17, // ✅ AUMENTADO: Ligeramente más grande
            color: Color(0xFF64748B), // ✅ CAMBIADO: Color más suave
            height: 1.4,
            fontWeight: FontWeight.w500, // ✅ AGREGADO: Peso medio
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// ✅ MEJORADO: Card premium con efectos visuales avanzados
  Widget _buildPremiumFormCard() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 380), // ✅ REDUCIDO: Más compacto
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9), // ✅ AUMENTADO: Más opacidad
        borderRadius: BorderRadius.circular(24), // ✅ AUMENTADO: Más redondeado
        border: Border.all(
          color: Colors.white.withOpacity(0.6), // ✅ AUMENTADO: Borde más visible
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08), // ✅ AUMENTADO: Sombra más profunda
            blurRadius: 32,
            offset: const Offset(0, 16),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.1), // ✅ AGREGADO: Sombra de color
            blurRadius: 60,
            offset: const Offset(0, 24),
            spreadRadius: -8,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16), // ✅ AUMENTADO: Más blur
          child: Container(
            padding: const EdgeInsets.all(36), // ✅ AUMENTADO: Más padding
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.1),
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Error Message (si existe)
                if (_error != null) ...[
                  Container(
                    padding: const EdgeInsets.all(16), // ✅ AUMENTADO: Más padding
                    margin: const EdgeInsets.only(bottom: 28),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(12), // ✅ AUMENTADO: Más redondeado
                      border: Border.all(
                        color: const Color(0xFFEF4444),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Color(0xFFEF4444),
                          size: 22, // ✅ AUMENTADO: Ícono más grande
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _error!,
                            style: const TextStyle(
                              color: Color(0xFFEF4444),
                              fontSize: 15, // ✅ AUMENTADO: Texto más legible
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                
                // Google Sign In Button - Hero element
                _buildPremiumGoogleButton(),
                
                const SizedBox(height: 28), // ✅ AUMENTADO: Más espaciado
                
                // Skip Button - Más elegante
                _buildElegantSkipButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ MEJORADO: Botón de Google con logo SVG realista
  Widget _buildPremiumGoogleButton() {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: -4,
          ),
          BoxShadow(
            color: const Color(0xFF4285F4).withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 12),
            spreadRadius: -8,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isLoading ? null : _signInWithGoogle,
          borderRadius: BorderRadius.circular(18),
          splashColor: const Color(0xFF4285F4).withOpacity(0.1),
          highlightColor: const Color(0xFF4285F4).withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isLoading) ...[
                  Container(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        const Color(0xFF4285F4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'Conectando...',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ] else ...[
                  // ✅ MEJORADO: Logo de Google SVG realista
                  _buildGoogleLogo(),
                  const SizedBox(width: 20),
                  const Text(
                    'Continuar con Google',
                    style: TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ NUEVO: Logo de Google SVG realista
  Widget _buildGoogleLogo() {
    return Container(
      width: 28,
      height: 28,
      child: CustomPaint(
        painter: GoogleLogoPainter(),
      ),
    );
  }

  /// ✅ MEJORADO: Features preview con iconos perfectamente centrados y versión dinámica
  Widget _buildElegantFeaturesPreview() {
    return Column(
      children: [
        // Features Icons - ✅ CORREGIDO: Iconos perfectamente centrados
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPremiumFeatureItem(
              Icons.verified_rounded,
              'Seguro',
              const Color(0xFF16A34A),
            ),
            const SizedBox(width: 40),
            _buildPremiumFeatureItem(
              Icons.cloud_sync_rounded,
              'Sincronización',
              const Color(0xFF3B82F6),
            ),
            const SizedBox(width: 40),
            _buildPremiumFeatureItem(
              Icons.account_balance_rounded,
              'Open Banking',
              const Color(0xFF8B5CF6),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Version and Copyright - ✅ MEJORADO: Versión dinámica
        Column(
          children: [
            Text(
              'MoneyT v$_appVersion', // ✅ CAMBIADO: Usar versión dinámica
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '© ${DateTime.now().year} MoneyT. Todos los derechos reservados.', // ✅ MEJORADO: Año dinámico
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFFCBD5E1),
                letterSpacing: 0.1,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }

  /// ✅ CORREGIDO: Feature item con centrado perfecto
  Widget _buildPremiumFeatureItem(IconData icon, String label, Color color) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.9 + (0.1 * _fadeAnimation.value),
          child: SizedBox(
            width: 80, // ✅ AGREGADO: Ancho fijo para centrado perfecto
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // ✅ AGREGADO: Centrado vertical
              crossAxisAlignment: CrossAxisAlignment.center, // ✅ AGREGADO: Centrado horizontal
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: color.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                  ),
                  textAlign: TextAlign.center, // ✅ AGREGADO: Centrado del texto
                  maxLines: 1, // ✅ AGREGADO: Una sola línea
                  overflow: TextOverflow.ellipsis, // ✅ AGREGADO: Manejo de overflow
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// ✅ MEJORADO: Skip button más elegante
  Widget _buildElegantSkipButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _skipForNow,
          borderRadius: BorderRadius.circular(12),
          splashColor: const Color(0xFF64748B).withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // ✅ AUMENTADO: Más área de toque
            child: const Text(
              'Explorar sin cuenta',
              style: TextStyle(
                fontSize: 17, // ✅ AUMENTADO: Más legible
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w500,
                letterSpacing: -0.1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ✅ NUEVO: Painter para crear el logo de Google SVG realista
class GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Escala para el tamaño del contenedor
    final scale = size.width / 24.0;
    canvas.scale(scale);
    
    // Ruta G azul (parte principal)
    paint.color = const Color(0xFF4285F4);
    final gPath = Path();
    gPath.moveTo(22.56, 12.25);
    gPath.cubicTo(22.56, 11.47, 22.49, 10.72, 22.36, 10.0);
    gPath.lineTo(12.0, 10.0);
    gPath.lineTo(12.0, 14.26);
    gPath.lineTo(17.92, 14.26);
    gPath.cubicTo(17.66, 15.63, 16.88, 16.79, 15.71, 17.57);
    gPath.lineTo(15.71, 20.34);
    gPath.lineTo(19.28, 20.34);
    gPath.cubicTo(21.36, 18.42, 22.56, 15.6, 22.56, 12.25);
    gPath.close();
    canvas.drawPath(gPath, paint);
    
    // Ruta verde (parte inferior derecha)
    paint.color = const Color(0xFF34A853);
    final greenPath = Path();
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
    
    // Ruta amarilla (parte inferior izquierda)
    paint.color = const Color(0xFFFBBC05);
    final yellowPath = Path();
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
    
    // Ruta roja (parte superior izquierda)
    paint.color = const Color(0xFFEA4335);
    final redPath = Path();
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