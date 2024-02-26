import 'package:elarise/di/repositories/user_datastore_repository/user_datastore_repository_provider.dart';
import 'package:elarise/feature_assistant/presentation/home/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeStateNotifier extends StateNotifier<HomeState> {
  final Ref ref;

  HomeStateNotifier(this.ref) : super(HomeState()) {
    _loadUserPreferences();
  }

  Future<void> refreshUserPreferences() async {
    _loadUserPreferences(); // This method should fetch the latest user data
  }

  Future<void> _loadUserPreferences() async {
    state = state.copyWith(isLoading: true);

    try {
      final userPreferences =
          await ref.read(userDatastoreRepositoryProvider).getUser();
      state =
          state.copyWith(userPreferences: userPreferences, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}

final homeStateNotifierProvider =
    StateNotifierProvider<HomeStateNotifier, HomeState>((ref) {
  return HomeStateNotifier(ref);
});
