import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/di/usecases/auth_usecases/get_logged_in_user_provider.dart';
import 'package:elarise/feature_auth/domain/usecases/get_logged_in_user/get_logged_in_user.dart';
import 'package:elarise/feature_auth/presentation/login/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../di/usecases/auth_usecases/login_provider.dart';
import '../../domain/usecases/login/login.dart';

class LoginStateNotifier extends StateNotifier<LoginState> {
  final Ref ref;

  LoginStateNotifier(this.ref) : super(LoginState(isLoading: false)) {
    _attemptAutoLogin();
  }

  Future<void> _attemptAutoLogin() async {
    try {
      GetLoggedInUser useCase = ref.read(getLoggedInUserProvider);
      var result = await useCase(null);

      if (result is Success) {
        state = state.copyWith(user: result.resultData, isLoading: false);
      } else {
        state = state.copyWith(user: null, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      state = state.copyWith(isLoading: true, user: null);

      Login useCase = ref.read(loginProvider);

      var result = await useCase(LoginParams(email: email, password: password));

      if (result is Success) {
        state = state.copyWith(user: result.resultData, isLoading: false);
      } else {
        state = state.copyWith(
            error: result.errorMessage ?? 'Failed to login', isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}

final loginStateNotifierProvider =
    StateNotifierProvider<LoginStateNotifier, LoginState>((ref) {
  return LoginStateNotifier(ref);
});
