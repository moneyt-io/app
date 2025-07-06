import 'package:flutter/material.dart';
import '../../core/services/onboarding_service.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/app_routes.dart';

/// Pantalla de splash que determina la navegación inicial
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    print('🚀 SplashScreen: Initializing app...'); // Debug
    
    // Simular tiempo de carga mínimo
    await Future.delayed(const Duration(milliseconds: 2000));
    
    try {
      // Determinar ruta inicial
      final initialRoute = await OnboardingService.getInitialRoute();
      print('🎯 SplashScreen: Initial route determined: $initialRoute'); // Debug
      
      if (mounted) {
        if (initialRoute == '/onboarding') {
          print('📱 SplashScreen: Navigating to onboarding...'); // Debug
          NavigationService.navigateToAndClearStack(AppRoutes.onboarding);
        } else {
          print('🏠 SplashScreen: Navigating to home...'); // Debug
          NavigationService.navigateToAndClearStack(AppRoutes.home);
        }
      }
    } catch (e) {
      print('❌ SplashScreen error: $e'); // Debug
      // En caso de error, ir al home por defecto
      if (mounted) {
        NavigationService.navigateToAndClearStack(AppRoutes.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color(0xFFF8FAFC),
              Color(0x264AE3B5), // rgba(74, 227, 181, 0.15)
            ],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo de MoneyT
              Icon(
                Icons.account_balance_wallet,
                size: 80,
                color: Color(0xFF14B8A6), // Teal
              ),
              SizedBox(height: 24),
              Text(
                'MoneyT',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF475569),
                ),
              ),
              SizedBox(height: 40),
              CircularProgressIndicator(
                color: Color(0xFF14B8A6),
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
