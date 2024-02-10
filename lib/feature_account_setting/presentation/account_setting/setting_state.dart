import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SettingState {
  final firebase_auth.User? firebaseUser;
  final bool isLogout;

  SettingState({
    firebase_auth.User? firebaseUser,
    this.isLogout = false,
  }) : firebaseUser =
            firebaseUser ?? firebase_auth.FirebaseAuth.instance.currentUser;

  SettingState copyWith({
    firebase_auth.User? firebaseUser,
    bool? isLogout,
  }) {
    return SettingState(
      firebaseUser: firebaseUser ?? firebaseUser,
      isLogout: isLogout ?? this.isLogout,
    );
  }
}
