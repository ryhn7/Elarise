import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/di/usecases/auth_usecases/get_logged_in_user_provider.dart';
import 'package:elarise/feature_assistant/presentation/home/home_state.dart';
import 'package:elarise/feature_auth/domain/usecases/get_logged_in_user/get_logged_in_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeStateNotifier extends StateNotifier<HomeState> {
  final Ref ref;

  HomeStateNotifier(this.ref) : super(HomeState(isLoading: true)) {
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      GetLoggedInUser useCase = ref.read(getLoggedInUserProvider);
      var result = await useCase(null);

      if (result is Success) {
        state = state.copyWith(user: result.resultData, isLoading: false);
      } else {
        state = state.copyWith(user: null, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}

final homeStateNotifierProvider =
    StateNotifierProvider<HomeStateNotifier, HomeState>((ref) {
  return HomeStateNotifier(ref);
});
