import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;
//final SyncService syncService;

  AuthRepositoryImpl({
    required this.auth,
    required this.firestore,
    required this.googleSignIn,
    //required this.syncService,
  });

  UserEntity _mapUserToEntity(User user) {
    print('  email: ${user.email}'); // Debug log
    
    return UserEntity(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = auth.currentUser;
    return user != null ? _mapUserToEntity(user) : null;
  }

  @override
  Future<UserEntity> signInWithEmailPassword(String email, String password) async {
    try {
      print('Attempting to sign in with email: $email'); // Debug log
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = userCredential.user;
      if (user == null) {
        print('Sign in failed: user is null'); // Debug log
        throw Exception('Failed to sign in');
      }
      
      print('Sign in successful for user: ${user.uid}'); // Debug log
      
      // Crear o actualizar el documento del usuario
      await _createUserDocument(user);
      
      // Mapear el usuario a nuestra entidad
      final userEntity = _mapUserToEntity(user);
      
      return userEntity;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException during sign in: ${e.code}'); // Debug log
      throw _handleAuthException(e);
    } catch (e) {
      print('Unexpected error during sign in: $e'); // Debug log
      rethrow;
    }
  }

  @override
  Future<UserEntity> signUpWithEmailPassword(String email, String password) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = userCredential.user;
      if (user == null) {
        throw Exception('Failed to sign up');
      }
      
      await _createUserDocument(user);
      return _mapUserToEntity(user);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign in cancelled');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await auth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) {
        throw Exception('Failed to sign in with Google');
      }
      
      await _createUserDocument(user);
      return _mapUserToEntity(user);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Error signing in with Google: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.wait([
        auth.signOut(),
        googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw Exception('Error signing out: $e');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  @override
  Future<void> updateUserPreferences({required bool acceptedMarketing}) async {
    // ✅ ELIMINADO: No enviar preferences a Firebase
    print('📝 User preferences handled locally (not stored in Firebase)');
    // No hacer nada - las preferencias se manejan solo en la UI
  }

  Future<void> _createUserDocument(User user) async {
    try {
      final userDoc = firestore.collection('users').doc(user.uid);
      final docSnapshot = await userDoc.get();

      // ✅ SIMPLIFICADO: Solo campos básicos para Firebase
      final userData = {
        'email': user.email,
        'displayName': user.displayName ?? '',
        'photoUrl': user.photoURL ?? '',
        'lastLogin': FieldValue.serverTimestamp(),
        // ❌ ELIMINADO: syncEnabled
        // ❌ ELIMINADO: preferences
        // ❌ ELIMINADO: acceptedMarketing
      };

      if (!docSnapshot.exists) {
        print('Creating new user document for ${user.uid}');
        await userDoc.set({
          ...userData,
          'createdAt': FieldValue.serverTimestamp(),
          // ❌ ELIMINADO: preferences object completamente
        });
      } else {
        print('Updating existing user document for ${user.uid}');
        await userDoc.update(userData);
      }

      final updatedDoc = await userDoc.get();
      if (!updatedDoc.exists) {
        throw Exception('User document not found after creation');
      }
      
      print('User document data:');
      print(updatedDoc.data());
    } catch (e) {
      print('Error in _createUserDocument: $e');
      throw Exception('Failed to create/update user document: $e');
    }
  }

  String _handleAuthException(FirebaseAuthException e) {
    final errorCode = switch (e.code) {
      'user-not-found' || 'wrong-password' || 'invalid-credential' => 'invalid-credentials',
      'email-already-in-use' => 'email-already-in-use',
      'invalid-email' => 'invalid-email',
      'weak-password' => 'weak-password',
      'operation-not-allowed' => 'operation-not-allowed',
      'user-disabled' => 'user-disabled',
      'too-many-requests' => 'too-many-requests',
      'network-request-failed' => 'network-error',
      _ => 'unknown-error'
    };
    print('Mapped error code ${e.code} to $errorCode'); // Debug log
    return errorCode;
  }
}