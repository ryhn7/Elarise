import '../core/domain/entities/user_preferences.dart';
import '../feature_auth/domain/entities/user.dart';

class GlobalState {
  final bool isLoading;
  final String? error;
  final User? user;

  final UserPreferences? userPreferences;

  GlobalState({
    this.isLoading = false,
    this.error,
    this.userPreferences,
    this.user,
  });

  GlobalState copyWith({
    bool? isLoading,
    UserPreferences? userPreferences,
    String? error,
    User? user,
  }) {
    return GlobalState(
      isLoading: isLoading ?? this.isLoading,
      userPreferences: userPreferences ?? this.userPreferences,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }
}