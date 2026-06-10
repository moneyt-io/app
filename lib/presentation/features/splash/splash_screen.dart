import 'package:flutter/material.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import '../../../core/services/app_initialization_service.dart';
import '../../../core/enums/initialization_state.dart';
import '../../../core/services/analytics_service.dart';
import '../../../core/services/video_cache_service.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';
import 'widgets/animated_moneyt_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startInitializationSequence();
  }

  void _startInitializationSequence() {
    print('🚀 Minimal SplashScreen: Starting initialization immediately...');
    // Si la inicialización es TAN rápida que causa un parpadeo molesto,
    // podríamos poner un Future.delayed de 500ms, pero reducimos "al máximo".
    _completeInitialization();
  }

  Future<void> _completeInitialization() async {
    try {
      final initState = await AppInitializationService.checkInitializationState();
      
      if (initState.requiresSeeds) {
        final success = await AppInitializationService.runInitializationSteps(initState);
        if (!success) {
          print('❌ Minimal SplashScreen: Initialization steps failed');
        }
      }

      try {
        await Posthog().reloadFeatureFlags();
      } catch (_) {}

      // Precarga del video de onboarding en cache — fire-and-forget
      // No esperamos (await) para no bloquear la navegación
      _warmupVideoCache();

      if (mounted) {
        _navigateBasedOnState(initState);
      }
    } catch (e) {
      print('❌ Minimal SplashScreen error: $e');
      if (mounted) {
        NavigationService.navigateToAndClearStack(AppRoutes.home);
      }
    }
  }

  /// Pre-carga el video de onboarding en cache local.
  /// Se llama de forma fire-and-forget para no bloquear la navegación.
  void _warmupVideoCache() {
    AnalyticsService().getOnboardingVideoConfig().then((config) {
      if (config != null) {
        // Precalentamos con la URL 'default' (siempre presente en el fallback)
        final url = config.getUrlForLocale('default');
        if (url.isNotEmpty) {
          VideoCacheService.warmupCache(url).then((_) {
            print('✅ SplashScreen: Video warmup complete');
          }).catchError((e) {
            print('⚠️ SplashScreen: Video warmup failed: $e');
          });
        }
      }
    }).catchError((e) {
      print('⚠️ SplashScreen: getOnboardingVideoConfig failed: $e');
    });
  }

  void _navigateBasedOnState(InitializationState state) {
    switch (state) {
      case InitializationState.firstLaunch:
      case InitializationState.needsOnboarding:
        NavigationService.navigateToAndClearStack(AppRoutes.onboarding);
        break;
      case InitializationState.needsAuth:
        NavigationService.navigateToAndClearStack(AppRoutes.home);
        break;
      case InitializationState.completed:
        NavigationService.navigateToAndClearStack(AppRoutes.home);
        break;
      case InitializationState.error:
      default:
        NavigationService.navigateToAndClearStack(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF8FF), // Light theme background
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF), // white
                Color(0xFFF0F4FF), // very light blue
              ],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const AnimatedMoneyTLogo(
                    size: 90,
                    animationDelay: Duration(milliseconds: 0),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'MoneyT',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.0,
                      color: Color(0xFF131B2E), // Oscuro para que se lea en fondo claro
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)), // Azul app
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
