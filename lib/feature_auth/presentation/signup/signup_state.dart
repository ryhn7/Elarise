import 'package:elarise/feature_auth/domain/entities/user.dart';

class SignUpState {
  final bool isLoading;
  final bool continueWithGoogleLoading;
  final String? error;

  final User? user;

  SignUpState({this.isLoading = false, this.error, this.user, this.continueWithGoogleLoading = false});

  SignUpState copyWith(
      {bool? isLoading, String? error, User? user, bool? continueWithGoogleLoading}) {
    return SignUpState(
        isLoading: isLoading ?? this.isLoading,
        continueWithGoogleLoading: continueWithGoogleLoading ?? this.continueWithGoogleLoading,
        error: error ?? this.error,
        user: user ?? this.user);
  }
}
