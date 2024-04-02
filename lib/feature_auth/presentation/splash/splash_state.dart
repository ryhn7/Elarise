import '../../../core/domain/entities/user_preferences.dart';

class SplashState {
  final bool isLoading;
  final String? error;

  final UserPreferences? userPreferences;

  SplashState({this.isLoading = false, this.error, this.userPreferences});

  SplashState copyWith(
      {bool? isLoading, String? error, UserPreferences? userPreferences}) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      userPreferences: userPreferences ?? this.userPreferences,
    );
  }
}
