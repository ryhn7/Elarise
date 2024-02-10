import 'package:elarise/feature_auth/domain/entities/user.dart';

class SignUpState {
  final bool isLoading;
  final String? error;

  final User? user;

  SignUpState({this.isLoading = false, this.error, this.user});

  SignUpState copyWith(
      {bool? isLoading, bool? isUserLoggedIn, String? error, User? user}) {
    return SignUpState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        user: user ?? this.user);
  }
}
