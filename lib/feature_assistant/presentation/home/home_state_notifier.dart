import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/feature_assistant/presentation/home/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeStateNotifier extends StateNotifier<HomeState> {
  final Ref ref;

  HomeStateNotifier(this.ref) : super(HomeState(isLoading: false, user: null)) {
    // _fetchUserData();
  }

  // Future<void> _fetchUserData() async {
  //   try {
  //     GetLoggedInUser useCase = ref.read(getLoggedInUserProvider);
  //     var result = await useCase(null);

  //     if (result is Success) {
  //       state = HomeState(
  //           user: result.resultData, isLoading: false, error: null);
  //     } else {
  //       state = HomeState(
  //           user: null,
  //           isLoading: false,
  //           error: result.errorMessage ?? 'User not found');
  //     }
  //   } catch (e) {
  //     state = HomeState(error: e.toString(), isLoading: false, user: null);
  //   }
  // }
}

final homeStateNotifierProvider =
    StateNotifierProvider<HomeStateNotifier, HomeState>((ref) {
  return HomeStateNotifier(ref);
});
