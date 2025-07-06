import 'package:shared_preferences/shared_preferences.dart';

/// Servicio para gestionar el estado del onboarding
class OnboardingService {
  static const String _onboardingCompletedKey = 'onboarding_completed';
  static const String _appFirstLaunchKey = 'app_first_launch';
  
  // ✅ AGREGADO: Flag de desarrollo para forzar onboarding
  // 🚨 DESARROLLO: Cambiar a false para producción
  static const bool _forceOnboardingInDevelopment = true; // TODO: Cambiar a false para release
  
  /// Verifica si es la primera vez que se abre la app
  static Future<bool> isFirstLaunch() async {
    // ✅ DESARROLLO: Si está activado el flag, siempre es "primera vez"
    if (_forceOnboardingInDevelopment) {
      print('🔄 DEV MODE: Forcing first launch = true');
      return true;
    }
    
    final prefs = await SharedPreferences.getInstance();
    return !prefs.containsKey(_appFirstLaunchKey);
  }
  
  /// Verifica si el onboarding ya fue completado
  static Future<bool> isOnboardingCompleted() async {
    // ✅ DESARROLLO: Si está activado el flag, nunca está completado
    if (_forceOnboardingInDevelopment) {
      print('🔄 DEV MODE: Forcing onboarding completed = false');
      return false;
    }
    
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompletedKey) ?? false;
  }
  
  /// Marca el onboarding como completado
  static Future<void> markOnboardingCompleted() async {
    // ✅ DESARROLLO: En modo desarrollo, no persistir para que se resetee en cada inicio
    if (_forceOnboardingInDevelopment) {
      print('🔄 DEV MODE: Not persisting onboarding completion');
      return; // No guardar nada, se reseteará en el próximo inicio
    }
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompletedKey, true);
    await prefs.setBool(_appFirstLaunchKey, true);
  }
  
  /// Marca la app como ya lanzada (no primera vez)
  static Future<void> markAppLaunched() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_appFirstLaunchKey, true);
  }
  
  /// Resetea el onboarding (para testing)
  static Future<void> resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_onboardingCompletedKey);
    await prefs.remove(_appFirstLaunchKey);
  }
  
  /// Determina cuál debe ser la ruta inicial
  static Future<String> getInitialRoute() async {
    final isFirst = await isFirstLaunch();
    final isCompleted = await isOnboardingCompleted();
    
    print('🔍 DEBUG: isFirst=$isFirst, isCompleted=$isCompleted'); // Debug
    
    // ✅ DESARROLLO: Mostrar flag activo en logs
    if (_forceOnboardingInDevelopment) {
      print('🚨 DEV MODE: Force onboarding flag is ACTIVE');
    }
    
    if (isFirst || !isCompleted) {
      return '/onboarding';
    }
    
    return '/'; // Home
  }
}
