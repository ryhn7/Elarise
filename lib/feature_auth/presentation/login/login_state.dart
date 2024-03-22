import '../../domain/entities/user.dart';

class LoginState {
  final bool isLoading;
  final bool continueWithGoogleLoading;
  final String? error;

  final User? user;

  LoginState({this.isLoading = false, this.error, this.user, this.continueWithGoogleLoading = false});

  LoginState copyWith(
      {bool? isLoading, String? error, User? user, bool? continueWithGoogleLoading}) {
    return LoginState(
        isLoading: isLoading ?? this.isLoading,
        continueWithGoogleLoading: continueWithGoogleLoading ?? this.continueWithGoogleLoading,
        error: error ?? this.error,
        user: user ?? this.user);
  }
}
