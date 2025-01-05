import 'package:flutter/foundation.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';

class AppAuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  UserEntity? _currentUser;
  bool _isLoading = false;

  AppAuthProvider(AuthRepository authRepository) : _authRepository = authRepository {
    _init();
  }

  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;
  UserEntity? get currentUser => _currentUser;

  Future<void> _init() async {
    _currentUser = await _authRepository.getCurrentUser();
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    try {
      _isLoading = true;
      notifyListeners();

      _currentUser = await _authRepository.signInWithGoogle();
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

      _currentUser = await _authRepository.signInWithEmailPassword(email, password);
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUpWithEmailPassword(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      _currentUser = await _authRepository.signUpWithEmailPassword(email, password);
      notifyListeners();
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
