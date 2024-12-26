import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      
      // Si el documento no existe, crearlo con valores por defecto
      if (!userDoc.exists) {
        final defaultData = {
          'email': user.email ?? '',
          'displayName': user.displayName ?? '',
          'photoUrl': user.photoURL ?? '',
          'acceptedMarketing': false,
          'createdAt': FieldValue.serverTimestamp(),
          'lastLoginAt': FieldValue.serverTimestamp(),
        };
        
        await _firestore.collection('users').doc(user.uid).set(defaultData);
        return UserEntity.fromMap({
          'id': user.uid,
          ...defaultData,
        });
      }

      // Si el documento existe, actualizar último login
      await _firestore.collection('users').doc(user.uid).update({
        'lastLoginAt': FieldValue.serverTimestamp(),
      });

      return UserEntity.fromMap({
        'id': user.uid,
        ...userDoc.data() ?? {},
      });
    } catch (e) {
      debugPrint('Error in getCurrentUser: $e');
      return null;
    }
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    try {
      // Iniciar el proceso de sign-in con Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw Exception('Sign in aborted by user');

      // Obtener detalles de autenticación
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Crear credencial para Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in con Firebase
      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
      
      if (user == null) throw Exception('Failed to sign in with Google');

      // Preparar datos del usuario
      final userData = {
        'email': user.email ?? '',
        'displayName': user.displayName ?? '',
        'photoUrl': user.photoURL ?? '',
        'acceptedMarketing': false,
        'lastLoginAt': FieldValue.serverTimestamp(),
      };

      // Referencia al documento del usuario
      final userDoc = _firestore.collection('users').doc(user.uid);
      
      // Si el documento no existe, agregar timestamp de creación
      if (!(await userDoc.get()).exists) {
        userData['createdAt'] = FieldValue.serverTimestamp();
        await userDoc.set(userData);
      } else {
        // Si existe, solo actualizar
        await userDoc.update(userData);
      }

      return UserEntity(
        id: user.uid,
        email: user.email ?? '',
        displayName: user.displayName ?? '',
        photoUrl: user.photoURL ?? '',
        acceptedMarketing: false,
      );
    } catch (e) {
      debugPrint('Error in signInWithGoogle: $e');
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'lastLogoutAt': FieldValue.serverTimestamp(),
        });
      }
      
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      debugPrint('Error in signOut: $e');
      throw Exception('Failed to sign out: $e');
    }
  }

  @override
  Future<void> updateUserPreferences({required bool acceptedMarketing}) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user signed in');

      await _firestore.collection('users').doc(user.uid).update({
        'acceptedMarketing': acceptedMarketing,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Error in updateUserPreferences: $e');
      throw Exception('Failed to update user preferences: $e');
    }
  }
}
