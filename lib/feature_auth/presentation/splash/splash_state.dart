import '../../../core/domain/entities/user_preferences.dart';
import '../../domain/entities/user.dart';

class SplashState {
  final bool isLoading;
  final String? error;

  final UserPreferences? userPreferences;
  final User? user;

  SplashState({this.isLoading = false, this.error, this.userPreferences, this.user});

  SplashState copyWith(
      {bool? isLoading, String? error, UserPreferences? userPreferences, User? user}) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
      userPreferences: userPreferences ?? this.userPreferences,
    );
  }
}
