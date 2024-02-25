import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/di/usecases/auth_usecases/usecase_auth_provider.dart';
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
}

final loginStateNotifierProvider =
    StateNotifierProvider<LoginStateNotifier, LoginState>((ref) {
  return LoginStateNotifier(ref);
});
