import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

abstract class BaseAuthRepository {
  Future<firebase_auth.User?> signInWithEmailPassword(
      String email, String password);
  Future<firebase_auth.User?> registerWithEmailPassword(
      String email, String password);
  Future<void> sendPasswordResetEmail(String email);
  Future<void> logout();
  firebase_auth.User? getCurrentUser();
  Future<String?> getUserToken();
  Future<firebase_auth.User?> initProfile(String name);
  Future<firebase_auth.User?> continueWithGoogle();
  Future<bool> reauthenticateWithPassword(String currentPassword);
  Future<void> updatePassword(String newPassword);
  Future<void> deleteAccount();
}
