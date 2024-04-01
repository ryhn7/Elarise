import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/di/usecases/auth_usecases/usecase_auth_provider.dart';
import 'package:elarise/feature_assistant/presentation/home/home_state_notifier.dart';
import 'package:elarise/feature_auth/presentation/login/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginStateNotifier extends StateNotifier<LoginState> {
  final Ref ref;

  LoginStateNotifier(this.ref)
      : super(LoginState(isLoading: false, user: null, error: null));

  Future<void> login({required String email, required String password}) async {
    try {
      state = state.copyWith(isLoading: true, user: null, error: null);

      final useCase = ref.read(useCaseAuthProvider);

      var result = await useCase.loginEmailPassword(email, password);

      if (result is Success) {
        state = state.copyWith(
            user: result.resultData, isLoading: false, error: null);
        ref.read(homeStateNotifierProvider.notifier).getAllFreelyTalkRooms();
      } else {
        state = state.copyWith(
            error: result.errorMessage ?? 'Failed to login',
            isLoading: false,
            user: null);
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

final loginStateNotifierProvider =
    StateNotifierProvider<LoginStateNotifier, LoginState>((ref) {
  return LoginStateNotifier(ref);
});
