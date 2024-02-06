import 'package:elarise/feature_auth/domain/entities/user.dart';

class HomeState {
  final bool isLoading;
  final String? error;

  final User? user;

  HomeState({this.isLoading = false, this.error, this.user});

  HomeState copyWith(
      {bool? isLoading, bool? isUserLoggedIn, String? error, User? user}) {
    return HomeState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        user: user ?? this.user);
  }
}
