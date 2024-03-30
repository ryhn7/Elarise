import 'package:elarise/feature_auth/presentation/signup/signup_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/result_state.dart';
import '../../../di/usecases/auth_usecases/usecase_auth_provider.dart';

class SignUpStateNotifier extends StateNotifier<SignUpState> {
  final Ref ref;

  SignUpStateNotifier(this.ref)
      : super(SignUpState(isLoading: false, user: null, error: null)) {
    _checkUser();
  }

  Future<void> _checkUser() async {
    try {
      final useCase = ref.read(useCaseAuthProvider);
      var result = await useCase.getCurrentUser();

      if (result is Success) {
        state = state.copyWith(
            user: result.resultData, isLoading: false, error: null);
      } else {
        state = state.copyWith(
          user: null,
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false, user: null);
    }
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(isLoading: true, user: null, error: null);
      final useCase = ref.read(useCaseAuthProvider);

      var result = await useCase.signUpEmailPassword(name, email, password);

      if (result is Success) {
        state = state.copyWith(
            user: result.resultData, isLoading: false, error: null);
      } else {
        state = state.copyWith(
            error: result.errorMessage ?? 'Failed to sign up',
            isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false, user: null);
    }
  }

  Future<void> continueWithGoogle() async {
    try {
      state = state.copyWith(
          continueWithGoogleLoading: true, user: null, error: null);

      final useCase = ref.read(useCaseAuthProvider);

      var result = await useCase.continueWithGoogle();

      if (result is Success) {
        state = state.copyWith(
            user: result.resultData,
            continueWithGoogleLoading: false,
            error: null);
      } else {
        state = state.copyWith(
            error: result.errorMessage ?? 'Failed to login',
            continueWithGoogleLoading: false,
            user: null);
      }
    } catch (e) {
      state = state.copyWith(
          error: e.toString(), continueWithGoogleLoading: false, user: null);
    }
  }

  Future<void> clearState() async {
    state = state.copyWith(error: null);
  }
}

final signUpStateNotifierProvider =
    StateNotifierProvider<SignUpStateNotifier, SignUpState>((ref) {
  return SignUpStateNotifier(ref);
});
