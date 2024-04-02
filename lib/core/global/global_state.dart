import '../domain/entities/user_preferences.dart';
import '../../feature_auth/domain/entities/user.dart';

class GlobalState {
  final bool isLoading;
  final String? error;
  final User? user;
  final bool hasInternetConnection;

  final UserPreferences? userPreferences;

  GlobalState({
    this.isLoading = false,
    this.error,
    this.userPreferences,
    this.user,
    this.hasInternetConnection = true,
  });

  GlobalState copyWith({
    bool? isLoading,
    UserPreferences? userPreferences,
    String? error,
    User? user,
    bool? hasInternetConnection,
  }) {
    return GlobalState(
      isLoading: isLoading ?? this.isLoading,
      userPreferences: userPreferences ?? this.userPreferences,
      error: error ?? this.error,
      user: user ?? this.user,
      hasInternetConnection: hasInternetConnection ?? this.hasInternetConnection,
    );
  }
}
