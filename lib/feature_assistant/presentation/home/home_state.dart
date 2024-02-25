import '../../../core/domain/entities/user_preferences.dart';

class HomeState {
  final bool isLoading;
  final String? error;

  final UserPreferences? userPreferences;

  HomeState({this.isLoading = false, this.error, this.userPreferences});

  HomeState copyWith({
    bool? isLoading,
    UserPreferences? userPreferences,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      userPreferences: userPreferences ?? this.userPreferences,
      error: error ?? this.error,
    );
  }
}
