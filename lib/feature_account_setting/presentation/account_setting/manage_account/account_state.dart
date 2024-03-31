import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../../../feature_auth/domain/entities/user.dart';

class AccountState {
  final firebase_auth.User? firebaseUser;
  final String? error;
  final bool isLoading;
  final User? user;

  final bool isLogout;
  final bool isDelete;

  AccountState({
    firebase_auth.User? firebaseUser,
    this.isLogout = false,
    this.isDelete = false,
    this.error,
    this.user,
    this.isLoading = false,
  }) : firebaseUser =
            firebaseUser ?? firebase_auth.FirebaseAuth.instance.currentUser;

  AccountState copyWith({
    firebase_auth.User? firebaseUser,
    String? error,
    User? user,
    bool? isLogout,
    bool? isDelete,
    bool? isLoading,
  }) {
    return AccountState(
      firebaseUser: firebaseUser ?? firebaseUser,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isLogout: isLogout ?? this.isLogout,
      isDelete: isDelete ?? this.isDelete,
    );
  }
}
