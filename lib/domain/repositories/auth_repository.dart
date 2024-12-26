import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> getCurrentUser();
  Future<UserEntity> signInWithGoogle();
  Future<void> signOut();
  Future<void> updateUserPreferences({required bool acceptedMarketing});
}
