import 'package:flutter/foundation.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/auth_usecases.dart';
import '../../../core/services/auth_service.dart';

/// Provider para manejar el estado de autenticación en la UI
class AuthProvider extends ChangeNotifier {
  final AuthUseCases _authUseCases;
  static const String _logTag = 'AuthProvider';

  // Estado
  UserEntity? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isAuthenticated = false;
  bool _isGuest = false;

  AuthProvider(this._authUseCases) {
    _initializeAuthState();
  }

  // Getters
  UserEntity? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _isAuthenticated;
  bool get isGuest => _isGuest;
  bool get canUseApp => _isAuthenticated || _isGuest;

  /// Inicializa el estado de autenticación
  Future<void> _initializeAuthState() async {
    try {
      print('🔍 $_logTag: Initializing auth state...');
      
      _setLoading(true);
      
      // Verificar usuario actual en Firebase
      final user = await _authUseCases.getCurrentUser();
      
      if (user != null) {
        _currentUser = user;
        _isAuthenticated = true;
        _isGuest = false;
        print('✅ $_logTag: User authenticated: ${user.email}');
      } else {
        // Verificar si está en modo invitado
        _isGuest = await AuthService.isUserGuest();
        _isAuthenticated = false;
        print('👤 $_logTag: ${_isGuest ? 'Guest mode' : 'No authentication'}');
      }
      
      _clearError();
      
    } catch (e) {
      print('❌ $_logTag: Error initializing auth state: $e');
      _setError('Error al verificar autenticación');
    } finally {
      _setLoading(false);
    }
  }

  /// Inicia sesión con Google
  Future<bool> signInWithGoogle() async {
    try {
      print('🔐 $_logTag: Starting Google sign in...');
      
      _setLoading(true);
      _clearError();
      
      final result = await _authUseCases.signInWithGoogle();
      
      if (result.isSuccess && result.user != null) {
        _currentUser = result.user;
        _isAuthenticated = true;
        _isGuest = false;
        
        print('✅ $_logTag: Google sign in successful');
        notifyListeners();
        return true;
      } else {
        _setError(result.errorMessage ?? 'Error en inicio de sesión con Google');
        return false;
      }
      
    } catch (e) {
      print('❌ $_logTag: Google sign in error: $e');
      _setError('Error inesperado con Google Sign-In');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Inicia sesión con email y contraseña
  Future<bool> signInWithEmailPassword(String email, String password) async {
    try {
      print('🔐 $_logTag: Starting email sign in...');
      
      _setLoading(true);
      _clearError();
      
      final result = await _authUseCases.signInWithEmailPassword(email, password);
      
      if (result.isSuccess && result.user != null) {
        _currentUser = result.user;
        _isAuthenticated = true;
        _isGuest = false;
        
        print('✅ $_logTag: Email sign in successful');
        notifyListeners();
        return true;
      } else {
        _setError(result.errorMessage ?? 'Error en inicio de sesión');
        return false;
      }
      
    } catch (e) {
      print('❌ $_logTag: Email sign in error: $e');
      _setError('Error inesperado en inicio de sesión');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Registra un nuevo usuario
  Future<bool> signUpWithEmailPassword(String email, String password) async {
    try {
      print('🔐 $_logTag: Starting email sign up...');
      
      _setLoading(true);
      _clearError();
      
      final result = await _authUseCases.signUpWithEmailPassword(email, password);
      
      if (result.isSuccess && result.user != null) {
        _currentUser = result.user;
        _isAuthenticated = true;
        _isGuest = false;
        
        print('✅ $_logTag: Email sign up successful');
        notifyListeners();
        return true;
      } else {
        _setError(result.errorMessage ?? 'Error en registro');
        return false;
      }
      
    } catch (e) {
      print('❌ $_logTag: Email sign up error: $e');
      _setError('Error inesperado en registro');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Cierra sesión
  Future<bool> signOut() async {
    try {
      print('🔓 $_logTag: Starting sign out...');
      
      _setLoading(true);
      
      final success = await _authUseCases.signOut();
      
      if (success) {
        _currentUser = null;
        _isAuthenticated = false;
        _isGuest = false;
        _clearError();
        
        print('✅ $_logTag: Sign out successful');
        notifyListeners();
        return true;
      } else {
        _setError('Error al cerrar sesión');
        return false;
      }
      
    } catch (e) {
      print('❌ $_logTag: Sign out error: $e');
      _setError('Error inesperado al cerrar sesión');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Continúa como invitado
  Future<void> continueAsGuest() async {
    try {
      print('👤 $_logTag: Continuing as guest...');
      
      _setLoading(true);
      
      await _authUseCases.continueAsGuest();
      
      _currentUser = null;
      _isAuthenticated = false;
      _isGuest = true;
      _clearError();
      
      print('✅ $_logTag: Guest mode activated');
      notifyListeners();
      
    } catch (e) {
      print('❌ $_logTag: Guest mode error: $e');
      _setError('Error al activar modo invitado');
    } finally {
      _setLoading(false);
    }
  }

  /// Envía email de reseteo de contraseña
  Future<bool> resetPassword(String email) async {
    try {
      print('🔄 $_logTag: Sending password reset...');
      
      _setLoading(true);
      _clearError();
      
      final success = await _authUseCases.resetPassword(email);
      
      if (success) {
        print('✅ $_logTag: Password reset email sent');
        return true;
      } else {
        _setError('Error al enviar email de reseteo');
        return false;
      }
      
    } catch (e) {
      print('❌ $_logTag: Password reset error: $e');
      _setError('Error inesperado al resetear contraseña');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Actualiza preferencias del usuario
  /// ✅ SIMPLIFICADO: updateUserPreferences sin persistencia
  Future<bool> updateUserPreferences({required bool acceptedMarketing}) async {
    try {
      _setLoading(true);
      
      // ✅ ELIMINADO: No llamar al repository ni guardar en ningún lado
      // Solo simular que se actualizó
      print('✅ $_logTag: User preferences handled locally');
      return true;
      
    } catch (e) {
      print('❌ $_logTag: Update preferences error: $e');
      _setError('Error inesperado al actualizar preferencias');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Refresca el estado de autenticación
  Future<void> refreshAuthState() async {
    await _initializeAuthState();
  }

  /// Limpia el error actual
  void clearError() {
    _clearError();
    notifyListeners();
  }

  // MÉTODOS PRIVADOS

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    print('❌ $_logTag: $error');
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}
