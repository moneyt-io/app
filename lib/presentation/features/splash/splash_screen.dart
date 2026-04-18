import 'package:flutter/material.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
// ✅ ACTUALIZADO: Imports para nuevo sistema de inicialización
import '../../../core/services/app_initialization_service.dart';
import '../../../core/enums/initialization_state.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import 'widgets/animated_moneyt_logo.dart';
import 'widgets/animated_gradient_background.dart';
import 'widgets/splash_progress_indicator.dart';
import 'widgets/floating_particles.dart';

/// Splash screen rediseñado con experiencia visual mejorada
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _titleController;
  late Animation<double> _titleFadeAnimation;
  late Animation<Offset> _titleSlideAnimation;

  bool _showProgressIndicator = false;

  // ✅ ACTUALIZADO: Estados contextuales más específicos
  final List<String> _loadingStates = [
    "Starting MoneyT...",
    "Initializing services...",
    "Checking data integrity...",
    "Preparing your experience...",
    "Almost ready!"
  ];

  @override
  void initState() {
    super.initState();

    _titleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _titleFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _titleController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    ));

    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _titleController,
      curve: Curves.easeOutQuart,
    ));

    _startInitializationSequence();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _startInitializationSequence() {
    print('🚀 Enhanced SplashScreen: Starting initialization sequence...');

    // Iniciar animaciones de UI inmediatamente
    _titleController.forward();

    // Mostrar el indicador de progreso y comenzar la inicialización real
    // sin delays artificiales.
    setState(() {
      _showProgressIndicator = true;
    });
  }

  Future<void> _completeInitialization() async {
    print('🎯 Enhanced SplashScreen: Completing initialization...');

    try {
      // ✅ ACTUALIZADO: Usar el nuevo servicio de inicialización
      final initState =
          await AppInitializationService.checkInitializationState();

      print(
          '🔍 Enhanced SplashScreen: Initialization state: ${initState.name}');

      // Ejecutar pasos de inicialización si es necesario
      if (initState.requiresSeeds) {
        final success =
            await AppInitializationService.runInitializationSteps(initState);
        if (!success) {
          print('❌ Enhanced SplashScreen: Initialization steps failed');
          // Continuar de todos modos, mostrar error en UI si es necesario
        }
      }

      // Pre-cargar feature flags para que OnboardingScreen los tenga cacheados
      try {
        await Posthog().reloadFeatureFlags();
      } catch (_) {}

      // Navegar según el estado
      if (mounted) {
        _navigateBasedOnState(initState);
      }
    } catch (e) {
      print('❌ Enhanced SplashScreen error: $e');
      // En caso de error, ir al home por defecto
      if (mounted) {
        NavigationService.navigateToAndClearStack(AppRoutes.home);
      }
    }
  }

  /// ✅ NUEVO: Navegación basada en el estado de inicialización
  void _navigateBasedOnState(InitializationState state) {
    final route = state.suggestedRoute;
    print('🎯 Enhanced SplashScreen: Navigating to: $route');

    switch (state) {
      case InitializationState.firstLaunch:
      case InitializationState.needsOnboarding:
        NavigationService.navigateToAndClearStack(AppRoutes.onboarding);
        break;

      case InitializationState.needsAuth:
        // TODO: Implementar cuando tengamos AuthWelcomeScreen
        print('🔐 Auth required, navigating to home for now');
        NavigationService.navigateToAndClearStack(AppRoutes.home);
        break;

      case InitializationState.completed:
        NavigationService.navigateToAndClearStack(AppRoutes.home);
        break;

      case InitializationState.error:
        print('❌ Initialization error, navigating to home with error handling');
        NavigationService.navigateToAndClearStack(AppRoutes.home);
        break;

      default:
        print('⚠️ Unknown state, navigating to home');
        NavigationService.navigateToAndClearStack(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: AnimatedGradientBackground(
          duration: const Duration(seconds: 3),
          child: Stack(
            children: [
              // Partículas flotantes
              const Positioned.fill(
                child: FloatingParticles(particleCount: 15),
              ),

              // Contenido principal
              SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),

                      // Logo animado
                      const AnimatedMoneyTLogo(
                        size: 120,
                        animationDelay: Duration(milliseconds: 100),
                      ),

                      const SizedBox(height: 32),

                      // Título con animación staggered
                      AnimatedBuilder(
                        animation: _titleController,
                        builder: (context, child) {
                          return FadeTransition(
                            opacity: _titleFadeAnimation,
                            child: SlideTransition(
                              position: _titleSlideAnimation,
                              child: const Column(
                                children: [
                                  Text(
                                    'MoneyT',
                                    style: TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: -1.0,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Your wealth, your way',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      const Spacer(),

                      // Indicador de progreso contextual
                      if (_showProgressIndicator)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 60),
                          child: SplashProgressIndicator(
                            states: _loadingStates,
                            onComplete: _completeInitialization,
                            stateDuration: const Duration(milliseconds: 200),
                          ),
                        )
                      else
                        const SizedBox(height: 120), // Espacio equivalente
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
