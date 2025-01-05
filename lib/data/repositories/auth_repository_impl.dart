import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../services/sync_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;
  final SyncService _syncService;

  AuthRepositoryImpl({
    required this.auth,
    required this.firestore,
    required this.googleSignIn,
    required SyncService syncService,
  }) : _syncService = syncService;

  UserEntity _mapUserToEntity(User user) {
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
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = userCredential.user;
      if (user == null) {
        throw Exception('Failed to sign in');
      }
      
      await _createUserDocument(user);
      return _mapUserToEntity(user);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
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
    final user = auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user');
    }

    await firestore.collection('users').doc(user.uid).update({
      'preferences': {
        'acceptedMarketing': acceptedMarketing,
        'updatedAt': FieldValue.serverTimestamp(),
      },
    });
  }

  Future<void> _createUserDocument(User user) async {
    final userDoc = firestore.collection('users').doc(user.uid);
    final docSnapshot = await userDoc.get();

    if (!docSnapshot.exists) {
      await userDoc.set({
        'email': user.email,
        'displayName': user.displayName,
        'photoUrl': user.photoURL,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
        'preferences': {
          'acceptedMarketing': false,
          'createdAt': FieldValue.serverTimestamp(),
        },
      });
    } else {
      await userDoc.update({
        'lastLogin': FieldValue.serverTimestamp(),
      });
    }

    // Iniciar sincronización y configurar listeners
    await _syncService.syncData();
    _syncService.setupRemoteChangeListeners();
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Wrong password';
      case 'email-already-in-use':
        return 'Email is already in use';
      case 'invalid-email':
        return 'Invalid email address';
      case 'weak-password':
        return 'Password is too weak';
      case 'operation-not-allowed':
        return 'Operation not allowed';
      case 'user-disabled':
        return 'User has been disabled';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later';
      case 'network-request-failed':
        return 'Network error. Please check your connection';
      default:
        return 'Authentication error: ${e.message}';
    }
  }
}
