import '../../domain/entities/user.dart';

class LoginState {
  final bool isLoading;
  bool isAttemptingLogin;
  final bool continueWithGoogleLoading;
  final String? error;

  final User? user;

  LoginState(
      {this.isLoading = false,
      this.error,
      this.user,
      this.continueWithGoogleLoading = false,
      this.isAttemptingLogin = false});

  LoginState copyWith(
      {bool? isLoading,
      String? error,
      User? user,
      bool? continueWithGoogleLoading,
      bool? isAttemptingLogin}) {
    return LoginState(
        isLoading: isLoading ?? this.isLoading,
        isAttemptingLogin: isAttemptingLogin ?? this.isAttemptingLogin,
        continueWithGoogleLoading:
            continueWithGoogleLoading ?? this.continueWithGoogleLoading,
        error: error ?? this.error,
        user: user ?? this.user);
  }
}
