import 'package:elarise/feature_auth/presentation/splash/splash_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/result_state.dart';
import '../../../di/usecases/auth_usecases/usecase_auth_provider.dart';
import '../../../router/router_provider.dart';
import '../../domain/entities/user.dart';

class SplashStateNotifier extends StateNotifier<SplashState> {
  final Ref ref;

  SplashStateNotifier(this.ref)
      : super(SplashState(isLoading: false, user: null, error: null)) {
    _checkUser();
  }

  Future<void> _checkUser() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final useCase = ref.read(useCaseAuthProvider);
      var result = await useCase.getCurrentUser();

      if (result is Success<User?> && result.resultData != null) {

        state = state.copyWith(
            user: result.resultData, isLoading: false, error: null);
        ref.read(routerProvider).goNamed('home');
      } else {
        state = state.copyWith(
          user: null,
          isLoading: false,
          error: result.errorMessage ?? 'Failed to get user',
        );
        ref.read(routerProvider).goNamed('login');
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false, user: null);
    }
  }
}

final splashStateNotifierProvider =
    StateNotifierProvider<SplashStateNotifier, SplashState>((ref) {
  return SplashStateNotifier(ref);
});
