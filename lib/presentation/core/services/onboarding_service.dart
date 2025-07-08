import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_storage_keys.dart';

/// Servicio para gestionar el estado del onboarding
/// 
/// Responsabilidades:
/// - Gestionar solo el estado del onboarding
/// - Determinar si se debe mostrar el onboarding
/// - Marcar el onboarding como completado
/// 
/// NOTA: Ya no maneja autenticación ni seeds
class OnboardingService {
  static const String _logTag = 'OnboardingService';
  
  // SIMPLIFICADO: Cambiar flag de desarrollo a false para que funcione normalmente
  static const bool _forceOnboardingInDevelopment = false; // CAMBIADO: a false
  
  /// Verifica si es la primera vez que se abre la app
  static Future<bool> isFirstLaunch() async {
    try {
      // 🔧 DESARROLLO: Si está activado el flag, siempre es "primera vez"
      if (_forceOnboardingInDevelopment) {
        print('🔄 DEV MODE: Forcing first launch = true');
        return true;
      }
      
      final prefs = await SharedPreferences.getInstance();
      final isFirst = !prefs.containsKey(AppStorageKeys.appFirstLaunch);
      
      print('🎬 $_logTag: Is first launch: $isFirst');
      return isFirst;
    } catch (e) {
      print('❌ $_logTag: Error checking first launch: $e');
      return true; // En caso de error, asumir primera vez
    }
  }
  
  /// Verifica si el onboarding ya fue completado
  static Future<bool> isOnboardingCompleted() async {
    try {
      // 🔧 DESARROLLO: Si está activado el flag, nunca está completado
      if (_forceOnboardingInDevelopment) {
        print('🔄 DEV MODE: Forcing onboarding completed = false');
        return false;
      }
      
      final prefs = await SharedPreferences.getInstance();
      final completed = prefs.getBool(AppStorageKeys.onboardingCompleted) ?? false;
      
      print('🎬 $_logTag: Onboarding completed: $completed');
      return completed;
    } catch (e) {
      print('❌ $_logTag: Error checking onboarding completion: $e');
      return false; // En caso de error, asumir no completado
    }
  }
  
  /// Marca el onboarding como completado
  static Future<void> markOnboardingCompleted() async {
    try {
      // 🔧 DESARROLLO: En modo desarrollo, no persistir para testing
      if (_forceOnboardingInDevelopment) {
        print('🔄 DEV MODE: Not persisting onboarding completion');
        return;
      }
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppStorageKeys.onboardingCompleted, true);
      await prefs.setBool(AppStorageKeys.appFirstLaunch, true);
      
      print('✅ $_logTag: Onboarding marked as completed');
    } catch (e) {
      print('❌ $_logTag: Error marking onboarding completed: $e');
    }
  }
  
  /// Marca la app como ya lanzada (no primera vez)
  static Future<void> markAppLaunched() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppStorageKeys.appFirstLaunch, true);
      
      print('📱 $_logTag: App marked as launched');
    } catch (e) {
      print('❌ $_logTag: Error marking app launched: $e');
    }
  }
  
  /// Resetea el onboarding (para testing)
  static Future<void> resetOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppStorageKeys.onboardingCompleted);
      await prefs.remove(AppStorageKeys.appFirstLaunch);
      
      print('🔄 $_logTag: Onboarding state reset');
    } catch (e) {
      print('❌ $_logTag: Error resetting onboarding: $e');
    }
  }
  
  /// Obtiene información del estado del onboarding
  static Future<Map<String, dynamic>> getOnboardingInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isFirst = await isFirstLaunch();
      final completed = await isOnboardingCompleted();
      
      return {
        'isFirstLaunch': isFirst,
        'isCompleted': completed,
        'needsOnboarding': isFirst || !completed,
        'devModeActive': _forceOnboardingInDevelopment,
      };
    } catch (e) {
      print('❌ $_logTag: Error getting onboarding info: $e');
      return {
        'isFirstLaunch': true,
        'isCompleted': false,
        'needsOnboarding': true,
        'devModeActive': _forceOnboardingInDevelopment,
        'error': e.toString(),
      };
    }
  }
  
  /// Habilita/deshabilita el modo desarrollo
  static Future<void> setDevelopmentMode(bool enabled) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      if (enabled) {
        await prefs.setBool(AppStorageKeys.devForceReset, true);
        print('🔧 $_logTag: Development mode enabled');
      } else {
        await prefs.remove(AppStorageKeys.devForceReset);
        print('🔧 $_logTag: Development mode disabled');
      }
    } catch (e) {
      print('❌ $_logTag: Error setting development mode: $e');
    }
  }
}

