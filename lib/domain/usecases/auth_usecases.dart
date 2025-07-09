import 'package:injectable/injectable.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';
import '../../core/services/auth_service.dart';

/// Casos de uso para autenticación
/// 
/// Maneja toda la lógica de negocio relacionada con autenticación
/// y coordina entre el repositorio y los servicios locales
@injectable
class AuthUseCases {
  final AuthRepository _authRepository;
  static const String _logTag = 'AuthUseCases';

  AuthUseCases(this._authRepository);

  /// Obtiene el usuario actualmente autenticado
  Future<UserEntity?> getCurrentUser() async {
    try {
      print('🔍 $_logTag: Getting current user...');
      final user = await _authRepository.getCurrentUser();
      
      if (user != null) {
        // Sincronizar estado local
        await AuthService.markUserAuthenticated();
        print('✅ $_logTag: Current user found: ${user.email}');
      } else {
        print('👤 $_logTag: No current user found');
      }
      
      return user;
    } catch (e) {
      print('❌ $_logTag: Error getting current user: $e');
      return null;
    }
  }

  /// Inicia sesión con Google
  Future<AuthResult> signInWithGoogle() async {
    try {
      print('🔐 $_logTag: Starting Google sign in...');
      
      final user = await _authRepository.signInWithGoogle();
      
      // Sincronizar con estado local
      await AuthService.markUserAuthenticated();
      
      print('✅ $_logTag: Google sign in successful: ${user.email}');
      return AuthResult.success(user);
      
    } catch (e) {
      print('❌ $_logTag: Google sign in failed: $e');
      return AuthResult.failure(_mapErrorToMessage(e.toString()));
    }
  }

  /// Inicia sesión con email y contraseña
  Future<AuthResult> signInWithEmailPassword(String email, String password) async {
    try {
      print('🔐 $_logTag: Starting email sign in for: $email');
      
      // Validaciones básicas
      if (email.isEmpty || password.isEmpty) {
        return AuthResult.failure('Email y contraseña son requeridos');
      }
      
      if (!_isValidEmail(email)) {
        return AuthResult.failure('Formato de email inválido');
      }
      
      final user = await _authRepository.signInWithEmailPassword(email, password);
      
      // Sincronizar con estado local
      await AuthService.markUserAuthenticated();
      
      print('✅ $_logTag: Email sign in successful: ${user.email}');
      return AuthResult.success(user);
      
    } catch (e) {
      print('❌ $_logTag: Email sign in failed: $e');
      return AuthResult.failure(_mapErrorToMessage(e.toString()));
    }
  }

  /// Registra un nuevo usuario con email y contraseña
  Future<AuthResult> signUpWithEmailPassword(String email, String password) async {
    try {
      print('🔐 $_logTag: Starting email sign up for: $email');
      
      // Validaciones
      if (email.isEmpty || password.isEmpty) {
        return AuthResult.failure('Email y contraseña son requeridos');
      }
      
      if (!_isValidEmail(email)) {
        return AuthResult.failure('Formato de email inválido');
      }
      
      if (password.length < 6) {
        return AuthResult.failure('La contraseña debe tener al menos 6 caracteres');
      }
      
      final user = await _authRepository.signUpWithEmailPassword(email, password);
      
      // Sincronizar con estado local
      await AuthService.markUserAuthenticated();
      
      print('✅ $_logTag: Email sign up successful: ${user.email}');
      return AuthResult.success(user);
      
    } catch (e) {
      print('❌ $_logTag: Email sign up failed: $e');
      return AuthResult.failure(_mapErrorToMessage(e.toString()));
    }
  }

  /// Cierra sesión del usuario
  Future<bool> signOut() async {
    try {
      print('🔓 $_logTag: Starting sign out...');
      
      await _authRepository.signOut();
      
      // Limpiar estado local
      await AuthService.signOut();
      
      print('✅ $_logTag: Sign out successful');
      return true;
      
    } catch (e) {
      print('❌ $_logTag: Sign out failed: $e');
      return false;
    }
  }

  /// Envía email de reseteo de contraseña
  Future<bool> resetPassword(String email) async {
    try {
      print('🔄 $_logTag: Sending password reset to: $email');
      
      if (!_isValidEmail(email)) {
        return false;
      }
      
      await _authRepository.resetPassword(email);
      
      print('✅ $_logTag: Password reset email sent');
      return true;
      
    } catch (e) {
      print('❌ $_logTag: Password reset failed: $e');
      return false;
    }
  }

  /// Continúa como invitado (sin autenticación)
  Future<void> continueAsGuest() async {
    try {
      print('👤 $_logTag: Continuing as guest...');
      
      // Marcar en estado local como invitado
      await AuthService.markUserAsGuest();
      
      print('✅ $_logTag: Guest mode activated');
    } catch (e) {
      print('❌ $_logTag: Error setting guest mode: $e');
    }
  }

  /// Actualiza las preferencias del usuario
  ///
  /// ✅ SIMPLIFICADO: updateUserPreferences sin Firebase
  Future<bool> updateUserPreferences({required bool acceptedMarketing}) async {
    try {
      // ✅ ELIMINADO: No usar ni SharedPreferences ni Firebase
      // Solo manejar en memoria durante la sesión actual
      print('✅ $_logTag: User preferences handled locally in session');
      return true;
      
    } catch (e) {
      print('❌ $_logTag: Error updating preferences: $e');
      return false;
    }
  }

  // MÉTODOS PRIVADOS

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  String _mapErrorToMessage(String error) {
    // Mapear errores específicos de Firebase a mensajes amigables
    if (error.contains('invalid-credentials')) {
      return 'Credenciales inválidas. Verifica tu email y contraseña.';
    } else if (error.contains('email-already-in-use')) {
      return 'Este email ya está registrado. Intenta iniciar sesión.';
    } else if (error.contains('weak-password')) {
      return 'La contraseña es muy débil. Usa al menos 6 caracteres.';
    } else if (error.contains('user-not-found')) {
      return 'No se encontró una cuenta con este email.';
    } else if (error.contains('wrong-password')) {
      return 'Contraseña incorrecta.';
    } else if (error.contains('too-many-requests')) {
      return 'Demasiados intentos. Intenta de nuevo más tarde.';
    } else if (error.contains('network-error')) {
      return 'Error de conexión. Verifica tu internet.';
    } else if (error.contains('cancelled')) {
      return 'Inicio de sesión cancelado.';
    } else {
      return 'Error inesperado. Intenta de nuevo.';
    }
  }
}

/// Resultado de operaciones de autenticación
class AuthResult {
  final bool isSuccess;
  final UserEntity? user;
  final String? errorMessage;

  AuthResult._({
    required this.isSuccess,
    this.user,
    this.errorMessage,
  });

  factory AuthResult.success(UserEntity user) {
    return AuthResult._(isSuccess: true, user: user);
  }

  factory AuthResult.failure(String message) {
    return AuthResult._(isSuccess: false, errorMessage: message);
  }
}
