import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  static const String _offlineUserEmailKey = 'offline_user_email';
  
  AuthRepositoryImpl();

  @override
  Future<UserEntity?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_offlineUserEmailKey);
    
    if (email != null) {
      return UserEntity(
        id: 'local_offline_user',
        email: email,
        displayName: 'Offline User',
        photoUrl: null,
      );
    }
    return null;
  }

  @override
  Future<UserEntity> signInWithEmailPassword(String email, String password) async {
    try {
      print('Attempting offline sign in with email: $email'); // Debug log
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_offlineUserEmailKey, email);
      
      return UserEntity(
        id: 'local_offline_user',
        email: email,
        displayName: 'Offline User',
        photoUrl: null,
      );
    } catch (e) {
      print('Unexpected error during offline sign in: $e'); // Debug log
      rethrow;
    }
  }

  @override
  Future<UserEntity> signUpWithEmailPassword(String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_offlineUserEmailKey, email);
      
      return UserEntity(
        id: 'local_offline_user',
        email: email,
        displayName: 'Offline User',
        photoUrl: null,
      );
    } catch (e) {
      throw Exception('Failed to sign up offline: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_offlineUserEmailKey);
    } catch (e) {
      throw Exception('Error signing out offline: $e');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    // Offline implementation: no-op since there's no backend
  }

  @override
  Future<void> updateUserPreferences({required bool acceptedMarketing}) async {
    print('📝 User preferences handled locally');
  }
}