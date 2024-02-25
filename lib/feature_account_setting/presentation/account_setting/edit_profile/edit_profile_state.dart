import '../../../../core/domain/entities/user_preferences.dart';
import '../../../../feature_auth/domain/entities/user.dart';

class EditProfileState {
  final bool isLoading;
  final String? error;
  final User? user;

  final UserPreferences? userPreferences;

  EditProfileState({
    this.isLoading = false,
    this.error,
    this.userPreferences,
    this.user,
  });

  EditProfileState copyWith({
    bool? isLoading,
    UserPreferences? userPreferences,
    String? error,
    User? user,
  }) {
    return EditProfileState(
      isLoading: isLoading ?? this.isLoading,
      userPreferences: userPreferences ?? this.userPreferences,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }
}
