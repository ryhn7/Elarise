import '../../domain/entities/user.dart';


class SplashState {
  final bool isLoading;
  final String? error;

  final User? user;

  SplashState({this.isLoading = false, this.error, this.user});

  SplashState copyWith(
      {bool? isLoading, bool? isUserLoggedIn, String? error, User? user}) {
    return SplashState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        user: user ?? this.user);
  }
}
