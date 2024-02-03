import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/feature_auth/data/interface_repositories/i_authentication_repository.dart.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class AuthenticationRepository implements IAuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  @override
  String getLoggedInUserId() {
    // TODO: implement getLoggedInUserId
    throw UnimplementedError();
  }

  @override
  Future<ResultState<String>> login(
      {required String email, required String password}) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return ResultState.success(userCredential.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return ResultState.error(e.message ?? 'An error occurred');
    }
  }

  @override
  Future<ResultState<void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<ResultState<String>> signUp(
      {required String email, required String password}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
