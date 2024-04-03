import 'package:elarise/feature_auth/presentation/splash/splash_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/result_state.dart';
import '../../../di/repositories/user_datastore_repository/user_datastore_repository_provider.dart';
import '../../../di/usecases/auth_usecases/usecase_auth_provider.dart';
import '../../../feature_account_setting/presentation/account_setting/manage_account/account_state_notifier.dart';
import '../../../router/router_provider.dart';
import '../../domain/entities/user.dart';

class SplashStateNotifier extends StateNotifier<SplashState> {
  final Ref ref;

  SplashStateNotifier(this.ref)
      : super(SplashState(
            isLoading: false, userPreferences: null, user: null, error: null)) {
    _checkUser();
  }

  Future<void> _checkUser() async {
    try {
      // Attempt to get the locally cached user state
      await Future.delayed(const Duration(seconds: 2));
      final localUser =
          await ref.read(userDatastoreRepositoryProvider).getUser();

      if (localUser.uid != null &&
          localUser.token != null &&
          localUser.email != null &&
          localUser.name != null &&
          localUser.photoProfile != null) {
        state = state.copyWith(
          userPreferences: localUser,
          isLoading: false,
        );
        ref.read(routerProvider).goNamed('home');
      } else {
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
          ref.read(accountStateNotifierProvider.notifier).logout();
          ref.read(routerProvider).goNamed('login');
        }
      }
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
        userPreferences: null,
      );
      ref.read(accountStateNotifierProvider.notifier).logout();
      ref.read(routerProvider).goNamed('login');
    }
  }
}

final splashStateNotifierProvider =
    StateNotifierProvider<SplashStateNotifier, SplashState>((ref) {
  return SplashStateNotifier(ref);
});
