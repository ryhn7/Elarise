class ChangePasswordState {
  final bool isLoading;
  final bool isPasswordChanged;
  final String? error;

  ChangePasswordState(
      {this.isLoading = false, this.error, this.isPasswordChanged = false});

  ChangePasswordState copyWith(
      {bool? isLoading, String? error, bool? isPasswordChanged}) {
    return ChangePasswordState(
        isLoading: isLoading ?? this.isLoading,
        isPasswordChanged: isPasswordChanged ?? this.isPasswordChanged,
        error: error ?? this.error);
  }
}
