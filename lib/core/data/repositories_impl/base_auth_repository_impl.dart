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
}

class FirebaseAuthException implements Exception {
  String message;
  FirebaseAuthException(this.message);

  @override
  String toString() => message;
}
