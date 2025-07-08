import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_storage_keys.dart';

/// Estados de autenticación de la aplicación
enum AuthState {
  /// Autenticación no requerida - usuario puede usar sin cuenta
  notRequired,
  
  /// Autenticación requerida - usuario debe iniciar sesión
  required,
  
  /// Usuario autenticado correctamente
  authenticated,
  
  /// Sesión expirada - requiere nueva autenticación
  expired,
  
  /// Usuario eligió modo invitado
  guest;
  
  /// Descripción del estado
  String get description {
    switch (this) {
      case AuthState.notRequired:
        return 'Autenticación no requerida';
      case AuthState.required:
        return 'Requiere autenticación';
      case AuthState.authenticated:
        return 'Usuario autenticado';
      case AuthState.expired:
        return 'Sesión expirada';
      case AuthState.guest:
        return 'Modo invitado';
    }
  }
  
  /// Determina si el usuario puede usar la app
  bool get canUseApp {
    return this == AuthState.authenticated || 
           this == AuthState.guest || 
           this == AuthState.notRequired;
  }
  
  /// Determina si necesita mostrar pantalla de auth
  bool get needsAuthScreen {
    return this == AuthState.required || 
           this == AuthState.expired;
  }
}

/// Servicio para gestionar el estado de autenticación de la aplicación
/// 
/// Se encarga de:
/// - Determinar si se requiere autenticación
/// - Gestionar estados de autenticación
/// - Coordinar con AuthRepository para operaciones reales
/// - Manejar modo invitado
class AuthService {
  static const String _logTag = 'AuthService';
  
  /// Obtiene el estado actual de autenticación
  static Future<AuthState> getAuthState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Verificar si el usuario está autenticado
      final isLoggedIn = prefs.getBool(AppStorageKeys.userLoggedIn) ?? false;
      final authCompleted = prefs.getBool(AppStorageKeys.authCompleted) ?? false;
      
      if (isLoggedIn && authCompleted) {
        print('✅ $_logTag: User is authenticated');
        return AuthState.authenticated;
      }
      
      // Verificar si eligió modo invitado
      final isGuest = prefs.getBool(AppStorageKeys.authSkipped) ?? false;
      
      if (isGuest) {
        print('👤 $_logTag: User is in guest mode');
        return AuthState.guest;
      }
      
      // Verificar si la autenticación es requerida
      final isAuthRequired = prefs.getBool(AppStorageKeys.authRequired) ?? false;
      
      if (isAuthRequired) {
        print('🔐 $_logTag: Authentication is required');
        return AuthState.required;
      }
      
      // Por defecto, no se requiere autenticación
      print('🔓 $_logTag: Authentication not required');
      return AuthState.notRequired;
      
    } catch (e) {
      print('❌ $_logTag: Error getting auth state: $e');
      return AuthState.notRequired;
    }
  }
  
  /// Configura si la autenticación es requerida
  static Future<void> setAuthRequired(bool required) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppStorageKeys.authRequired, required);
      
      print('🔧 $_logTag: Auth required set to: $required');
    } catch (e) {
      print('❌ $_logTag: Error setting auth required: $e');
    }
  }
  
  /// Marca al usuario como autenticado
  static Future<void> markUserAuthenticated() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppStorageKeys.userLoggedIn, true);
      await prefs.setBool(AppStorageKeys.authCompleted, true);
      await prefs.remove(AppStorageKeys.authSkipped); // Limpiar modo invitado
      
      print('✅ $_logTag: User marked as authenticated');
    } catch (e) {
      print('❌ $_logTag: Error marking user as authenticated: $e');
    }
  }
  
  /// Marca al usuario como invitado (sin autenticación)
  static Future<void> markUserAsGuest() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppStorageKeys.authSkipped, true);
      await prefs.remove(AppStorageKeys.userLoggedIn);
      await prefs.remove(AppStorageKeys.authCompleted);
      
      print('👤 $_logTag: User marked as guest');
    } catch (e) {
      print('❌ $_logTag: Error marking user as guest: $e');
    }
  }
  
  /// Cierra sesión del usuario
  static Future<void> signOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppStorageKeys.userLoggedIn);
      await prefs.remove(AppStorageKeys.authCompleted);
      await prefs.remove(AppStorageKeys.authSkipped);
      
      print('🔓 $_logTag: User signed out');
    } catch (e) {
      print('❌ $_logTag: Error signing out user: $e');
    }
  }
  
  /// Verifica si el usuario está autenticado
  static Future<bool> isUserAuthenticated() async {
    final state = await getAuthState();
    return state == AuthState.authenticated;
  }
  
  /// Verifica si el usuario está en modo invitado
  static Future<bool> isUserGuest() async {
    final state = await getAuthState();
    return state == AuthState.guest;
  }
  
  /// Verifica si se requiere autenticación
  static Future<bool> isAuthRequired() async {
    final state = await getAuthState();
    return state.needsAuthScreen;
  }
  
  /// Obtiene información detallada del estado de autenticación
  static Future<Map<String, dynamic>> getAuthInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final state = await getAuthState();
      
      return {
        'state': state.name,
        'description': state.description,
        'canUseApp': state.canUseApp,
        'needsAuthScreen': state.needsAuthScreen,
        'isAuthenticated': state == AuthState.authenticated,
        'isGuest': state == AuthState.guest,
        'authRequired': prefs.getBool(AppStorageKeys.authRequired) ?? false,
        'lastAuthAction': prefs.getString('last_auth_action'),
      };
      
    } catch (e) {
      print('❌ $_logTag: Error getting auth info: $e');
      return {
        'state': 'error',
        'error': e.toString(),
      };
    }
  }
  
  /// Resetea el estado de autenticación (para desarrollo)
  static Future<void> resetAuth() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppStorageKeys.authRequired);
      await prefs.remove(AppStorageKeys.authCompleted);
      await prefs.remove(AppStorageKeys.userLoggedIn);
      await prefs.remove(AppStorageKeys.authSkipped);
      
      print('🔄 $_logTag: Auth state reset');
    } catch (e) {
      print('❌ $_logTag: Error resetting auth state: $e');
    }
  }
  
  /// Configura el modo de autenticación por defecto
  static Future<void> setDefaultAuthMode({
    bool requireAuth = false,
    bool allowGuest = true,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      if (requireAuth) {
        await prefs.setBool(AppStorageKeys.authRequired, true);
      } else if (allowGuest) {
        await prefs.setBool(AppStorageKeys.authRequired, false);
      }
      
      print('🔧 $_logTag: Default auth mode configured - requireAuth: $requireAuth, allowGuest: $allowGuest');
    } catch (e) {
      print('❌ $_logTag: Error setting default auth mode: $e');
    }
  }
}
