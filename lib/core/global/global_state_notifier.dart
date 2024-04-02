import 'package:elarise/core/global/global_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/repositories/user_datastore_repository/user_datastore_repository_provider.dart';
import '../../router/router_provider.dart';
import '../utils/network_util.dart';

class GlobalStateNotifier extends StateNotifier<GlobalState> {
  final Ref ref;
  String? _routeName;

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

  Future<void> checkInternetConnection() async {
    final isOnline = await NetworkUtil().isInternetAvailable();
    if (!isOnline) {
      // Set a state indicating no internet connection
      state = state.copyWith(hasInternetConnection: false);
    } else {
      state = state.copyWith(hasInternetConnection: true);
    }
  }

  Future<void> setInternetConnection(bool hasInternetConnection) async {
    state = state.copyWith(hasInternetConnection: hasInternetConnection);
  }

  set routeName(String routeName) {
    _routeName = routeName;
  }

  // method go to the previous route
  void goBack() {
    if (_routeName != null) {
      ref.read(routerProvider).goNamed(_routeName!);
    }
  }
}

final globalStateNotifierProvider =
    StateNotifierProvider<GlobalStateNotifier, GlobalState>((ref) {
  return GlobalStateNotifier(ref);
});
