import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/entities/user_entity.dart';

class AppAuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  final SharedPreferences _prefs;
  UserEntity? _currentUser;
  bool _isLoading = true;  
  static const String _authKey = 'auth_state';

  AppAuthProvider(AuthRepository authRepository, SharedPreferences prefs) 
    : _authRepository = authRepository,
      _prefs = prefs {
    _init();
  }

  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;
  UserEntity? get currentUser => _currentUser;

  Future<void> _init() async {
    try {
      _isLoading = true;
      notifyListeners();

      final wasAuthenticated = _prefs.getBool(_authKey) ?? false;
      if (wasAuthenticated) {
        try {
          _currentUser = await _authRepository.getCurrentUser();
          print('Init: Current user loaded: ${_currentUser?.email}'); // Debug log
        } catch (e) {
          print('Init: Error getting current user: $e'); // Debug log
          _currentUser = null;
          await _prefs.setBool(_authKey, false);
        }
      }
    } catch (e) {
      print('Init: Unexpected error: $e'); // Debug log
      _currentUser = null;
      await _prefs.setBool(_authKey, false);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      _isLoading = true;
      notifyListeners();

      _currentUser = await _authRepository.signInWithGoogle();
      await _prefs.setBool(_authKey, true);
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      print('AuthProvider: Starting sign in process'); // Debug log

      _currentUser = await _authRepository.signInWithEmailPassword(email, password);
      print('AuthProvider: Sign in successful, user: ${_currentUser?.email}'); // Debug log
      
      if (_currentUser != null) {
        await _prefs.setBool(_authKey, true);
        print('AuthProvider: Auth state saved to preferences'); // Debug log
      } else {
        throw Exception('User is null after successful sign in');
      }
      
      notifyListeners();
    } catch (e) {
      print('AuthProvider: Error during sign in: $e'); // Debug log
      // Asegurarnos de que el estado se limpie en caso de error
      _currentUser = null;
      await _prefs.setBool(_authKey, false);
      notifyListeners();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUpWithEmailPassword(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      print('AuthProvider: Starting sign up process'); // Debug log

      _currentUser = await _authRepository.signUpWithEmailPassword(email, password);
      print('AuthProvider: Sign up successful, user: ${_currentUser?.email}'); // Debug log
      
      if (_currentUser != null) {
        await _prefs.setBool(_authKey, true);
        print('AuthProvider: Auth state saved to preferences'); // Debug log
      } else {
        throw Exception('User is null after successful sign up');
      }
      
      notifyListeners();
    } catch (e) {
      print('AuthProvider: Error during sign up: $e'); // Debug log
      // Asegurarnos de que el estado se limpie en caso de error
      _currentUser = null;
      await _prefs.setBool(_authKey, false);
      notifyListeners();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading = true;
      notifyListeners();

      await _authRepository.signOut();
      await _prefs.setBool(_authKey, false);
      _currentUser = null;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _authRepository.resetPassword(email);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUserPreferences({required bool acceptedMarketing}) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _authRepository.updateUserPreferences(
        acceptedMarketing: acceptedMarketing,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
