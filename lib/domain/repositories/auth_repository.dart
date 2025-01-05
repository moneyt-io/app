import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> getCurrentUser();
  Future<UserEntity> signInWithGoogle();
  Future<UserEntity> signInWithEmailPassword(String email, String password);
  Future<UserEntity> signUpWithEmailPassword(String email, String password);
  Future<void> resetPassword(String email);
  Future<void> signOut();
  Future<void> updateUserPreferences({required bool acceptedMarketing});
}
