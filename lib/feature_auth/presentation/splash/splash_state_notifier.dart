import 'package:elarise/feature_auth/presentation/splash/splash_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../di/repositories/user_datastore_repository/user_datastore_repository_provider.dart';
import '../../../router/router_provider.dart';

class SplashStateNotifier extends StateNotifier<SplashState> {
  final Ref ref;

  SplashStateNotifier(this.ref)
      : super(
            SplashState(isLoading: false, userPreferences: null, error: null)) {
    _checkUser();
  }

  Future<void> _checkUser() async {
    try {
      // Attempt to get the locally cached user state
      await Future.delayed(const Duration(seconds: 2));
      final localUser =
          await ref.read(userDatastoreRepositoryProvider).getUser();

      state = state.copyWith(userPreferences: localUser, isLoading: false);
      ref.read(routerProvider).goNamed('home');
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
        userPreferences: null,
      );
      ref.read(routerProvider).goNamed('login');
    }
  }
}

final splashStateNotifierProvider =
    StateNotifierProvider<SplashStateNotifier, SplashState>((ref) {
  return SplashStateNotifier(ref);
});
