import 'package:elarise/core/global/global_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/repositories/user_datastore_repository/user_datastore_repository_provider.dart';

class GlobalStateNotifier extends StateNotifier<GlobalState> {
  final Ref ref;

  GlobalStateNotifier(this.ref) : super(GlobalState()) {
    _loadUserPreferences();
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

final globalStateNotifierProvider =
    StateNotifierProvider<GlobalStateNotifier, GlobalState>((ref) {
  return GlobalStateNotifier(ref);
});