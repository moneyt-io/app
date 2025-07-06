import 'package:flutter/material.dart';
import '../../core/services/onboarding_service.dart';
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

  // Estados contextuales de carga
  final List<String> _loadingStates = [
    "Starting MoneyT...",
    "Checking your profile...",
    "Preparing your dashboard...",
    "Almost ready!"
  ];

  @override
  void initState() {
    super.initState();
    
    _titleController = AnimationController(
      duration: const Duration(milliseconds: 600),
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

  Future<void> _startInitializationSequence() async {
    print('🚀 Enhanced SplashScreen: Starting initialization sequence...');
    
    // Fase 1: Mostrar logo (300ms delay)
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Fase 2: Mostrar título (600ms después del logo)
    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) {
      _titleController.forward();
    }
    
    // Fase 3: Mostrar indicador de progreso (900ms después del título)
    await Future.delayed(const Duration(milliseconds: 900));
    if (mounted) {
      setState(() {
        _showProgressIndicator = true;
      });
    }
  }

  Future<void> _completeInitialization() async {
    print('🎯 Enhanced SplashScreen: Completing initialization...');
    
    try {
      // Determinar ruta inicial
      final initialRoute = await OnboardingService.getInitialRoute();
      print('🎯 Enhanced SplashScreen: Initial route determined: $initialRoute');
      
      if (mounted) {
        if (initialRoute == '/onboarding') {
          print('📱 Enhanced SplashScreen: Navigating to onboarding...');
          NavigationService.navigateToAndClearStack(AppRoutes.onboarding);
        } else {
          print('🏠 Enhanced SplashScreen: Navigating to home...');
          NavigationService.navigateToAndClearStack(AppRoutes.home);
        }
      }
    } catch (e) {
      print('❌ Enhanced SplashScreen error: $e');
      // En caso de error, ir al home por defecto
      if (mounted) {
        NavigationService.navigateToAndClearStack(AppRoutes.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          stateDuration: const Duration(milliseconds: 600),
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
    );
  }
}
