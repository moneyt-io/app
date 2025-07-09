import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_storage_keys.dart';
import '../enums/initialization_state.dart';
import '../../presentation/core/services/onboarding_service.dart';
import 'data_seed_service.dart';
import 'auth_service.dart';

/// Servicio central para coordinar la inicialización de la aplicación
/// 
/// Se encarga de:
/// - Determinar el estado actual de inicialización
/// - Coordinar el flujo entre onboarding, seeds y auth
/// - Manejar errores y recuperación
/// - Proporcionar información de estado para la UI
class AppInitializationService {
  static const String _logTag = 'AppInitializationService';
  
  /// Determina el estado actual de inicialización de la aplicación
  static Future<InitializationState> checkInitializationState() async {
    try {
      print('🔍 $_logTag: Checking initialization state...');
      
      // Verificar si hay flags de desarrollo activas
      final devState = await _checkDevelopmentFlags();
      if (devState != null) {
        print('🔧 $_logTag: Development mode detected: $devState');
        return devState;
      }
      
      // Verificar estado de onboarding
      final onboardingInfo = await OnboardingService.getOnboardingInfo();
      final needsOnboarding = onboardingInfo['needsOnboarding'] as bool;
      
      if (needsOnboarding) {
        print('🎬 $_logTag: Needs onboarding');
        return InitializationState.firstLaunch;
      }
      
      // Verificar estado de seeds
      final seedInfo = await DataSeedService.getSeedInfo();
      final seedsValid = seedInfo['isValid'] as bool;
      final seedsCompleted = seedInfo['completed'] as bool;
      
      if (!seedsCompleted || !seedsValid) {
        print('🌱 $_logTag: Needs seeds - completed: $seedsCompleted, valid: $seedsValid');
        return InitializationState.needsSeeds;
      }
      
      // Verificar estado de autenticación
      final authState = await AuthService.getAuthState();
      
      if (authState == AuthState.required) {
        print('🔐 $_logTag: Needs authentication');
        return InitializationState.needsAuth;
      }
      
      // Todo está completado
      print('✅ $_logTag: Initialization completed');
      return InitializationState.completed;
      
    } catch (e) {
      print('❌ $_logTag: Error checking initialization state: $e');
      return InitializationState.error;
    }
  }
  
  /// Ejecuta los pasos de inicialización necesarios según el estado
  static Future<bool> runInitializationSteps(InitializationState state) async {
    try {
      print('🚀 $_logTag: Running initialization steps for state: ${state.name}');
      
      switch (state) {
        case InitializationState.firstLaunch:
          return await _handleFirstLaunch();
          
        case InitializationState.needsSeeds:
          return await _handleSeedsInitialization();
          
        case InitializationState.needsAuth:
          // La autenticación se maneja en UI, solo preparar estado
          return true;
          
        case InitializationState.completed:
          // Marcar última apertura
          await _markAppOpened();
          return true;
          
        case InitializationState.error:
          return await _handleInitializationError();
          
        default:
          print('⚠️ $_logTag: Unhandled initialization state: $state');
          return false;
      }
      
    } catch (e) {
      print('❌ $_logTag: Error running initialization steps: $e');
      return false;
    }
  }
  
  /// Obtiene información completa del estado de inicialización
  static Future<Map<String, dynamic>> getInitializationInfo() async {
    try {
      final state = await checkInitializationState();
      final onboardingInfo = await OnboardingService.getOnboardingInfo();
      final seedInfo = await DataSeedService.getSeedInfo();
      final authState = await AuthService.getAuthState();
      
      return {
        'state': state.name,
        'stateDescription': state.description,
        'suggestedRoute': state.suggestedRoute,
        'requiresOnboarding': state.requiresOnboarding,
        'requiresSeeds': state.requiresSeeds,
        'requiresAuth': state.requiresAuth,
        'canProceedToApp': state.canProceedToApp,
        'onboarding': onboardingInfo,
        'seeds': seedInfo,
        'auth': {
          'state': authState.name,
          'description': authState.description,
        },
        'timestamp': DateTime.now().toIso8601String(),
      };
      
    } catch (e) {
      print('❌ $_logTag: Error getting initialization info: $e');
      return {
        'state': 'error',
        'error': e.toString(),
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
  }
  
  /// Reinicia completamente el estado de inicialización (para desarrollo)
  static Future<void> resetInitializationState() async {
    try {
      print('🔄 $_logTag: Resetting initialization state...');
      
      await Future.wait([
        OnboardingService.resetOnboarding(),
        DataSeedService.resetSeeds(),
        AuthService.resetAuth(),
      ]);
      
      // Limpiar flags de desarrollo
      final prefs = await SharedPreferences.getInstance();
      for (final key in AppStorageKeys.developmentKeys) {
        await prefs.remove(key);
      }
      
      print('✅ $_logTag: Initialization state reset completed');
    } catch (e) {
      print('❌ $_logTag: Error resetting initialization state: $e');
    }
  }
  
  // MÉTODOS PRIVADOS
  
  /// Verifica flags de desarrollo que pueden alterar el flujo
  static Future<InitializationState?> _checkDevelopmentFlags() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Flag para resetear completamente
      if (prefs.getBool(AppStorageKeys.devForceReset) ?? false) {
        await resetInitializationState();
        return InitializationState.firstLaunch;
      }
      
      // Flag para forzar onboarding
      if (prefs.getBool(AppStorageKeys.devSkipOnboarding) ?? false) {
        return InitializationState.needsSeeds;
      }
      
      // Flag para forzar auth
      if (prefs.getBool(AppStorageKeys.devSkipAuth) ?? false) {
        return InitializationState.completed;
      }
      
      return null;
    } catch (e) {
      print('❌ $_logTag: Error checking development flags: $e');
      return null;
    }
  }
  
  /// Maneja la primera apertura de la aplicación
  static Future<bool> _handleFirstLaunch() async {
    try {
      print('🎬 $_logTag: Handling first launch...');
      
      // Ejecutar seeds en background si no están completados
      final seedsSuccess = await DataSeedService.runSeedsIfNeeded();
      
      if (!seedsSuccess) {
        print('❌ $_logTag: Seeds failed during first launch');
        return false;
      }
      
      // Marcar app como lanzada
      await OnboardingService.markAppLaunched();
      
      print('✅ $_logTag: First launch handled successfully');
      return true;
      
    } catch (e) {
      print('❌ $_logTag: Error handling first launch: $e');
      return false;
    }
  }
  
  /// Maneja la inicialización de seeds
  static Future<bool> _handleSeedsInitialization() async {
    try {
      print('🌱 $_logTag: Handling seeds initialization...');
      
      final success = await DataSeedService.runSeedsIfNeeded();
      
      if (success) {
        print('✅ $_logTag: Seeds initialization completed');
      } else {
        print('❌ $_logTag: Seeds initialization failed');
      }
      
      return success;
      
    } catch (e) {
      print('❌ $_logTag: Error handling seeds initialization: $e');
      return false;
    }
  }
  
  /// Maneja errores de inicialización
  static Future<bool> _handleInitializationError() async {
    try {
      print('🔧 $_logTag: Handling initialization error...');
      
      // Intentar validar y reparar estados
      final seedsValid = await DataSeedService.validateSeedData();
      
      if (!seedsValid) {
        print('🔧 $_logTag: Attempting to repair seeds...');
        await DataSeedService.forceRunSeeds();
      }
      
      // Verificar si se pudo reparar
      final newState = await checkInitializationState();
      final isRepaired = newState != InitializationState.error;
      
      if (isRepaired) {
        print('✅ $_logTag: Initialization error repaired');
      } else {
        print('❌ $_logTag: Could not repair initialization error');
      }
      
      return isRepaired;
      
    } catch (e) {
      print('❌ $_logTag: Error handling initialization error: $e');
      return false;
    }
  }
  
  /// Marca la aplicación como abierta
  static Future<void> _markAppOpened() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        AppStorageKeys.lastAppOpen,
        DateTime.now().toIso8601String(),
      );
    } catch (e) {
      print('❌ $_logTag: Error marking app as opened: $e');
    }
  }
}
