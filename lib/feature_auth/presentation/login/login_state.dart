import '../../domain/entities/user.dart';

class LoginState {
  final bool isLoading;
  final String? error;

  final User? user;

  LoginState({this.isLoading = false, this.error, this.user});

  LoginState copyWith(
      {bool? isLoading, bool? isUserLoggedIn, String? error, User? user}) {
    return LoginState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        user: user ?? this.user);
  }
}
