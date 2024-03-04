import 'package:elarise/core/data/repositories/base_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class BaseAuthRepositoryImpl implements BaseAuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  BaseAuthRepositoryImpl({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  @override
  firebase_auth.User? getCurrentUser() => _firebaseAuth.currentUser;

  @override
  Future<firebase_auth.User?> signInWithEmailPassword(
      String email, String password) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      throw FirebaseAuthException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      if (_firebaseAuth.currentUser == null) {
        return;
      } else {
        throw FirebaseAuthException('Failed to logout user');
      }
    } catch (e) {
      throw FirebaseAuthException(e.toString());
    }
  }

  @override
  Future<firebase_auth.User?> registerWithEmailPassword(
      String email, String password) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      throw FirebaseAuthException(e.toString());
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw FirebaseAuthException(e.toString());
    }
  }

  @override
  Future<String?> getUserToken() async {
    try {
      return await _firebaseAuth.currentUser?.getIdToken(true);
    } catch (e) {
      throw FirebaseAuthException(e.toString());
    }
  }

  @override
  Future<firebase_auth.User?> initProfile(String name) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updateDisplayName(name);
        await user.updatePhotoURL(
            'https://firebasestorage.googleapis.com/v0/b/elarise-1d057.appspot.com/o/profileImage%2Fuser_placeholder.png?alt=media&token=edfb4a25-2f56-479c-9ed3-f58e90ca8ce5');
        await user.reload();
        final updatedUser = _firebaseAuth.currentUser;
        return updatedUser;
      } else {
        throw FirebaseAuthException('User not found');
      }
    } catch (e) {
      throw FirebaseAuthException(e.toString());
    }
  }
}

class FirebaseAuthException implements Exception {
  String message;
  FirebaseAuthException(this.message);

  @override
  String toString() => message;
}
