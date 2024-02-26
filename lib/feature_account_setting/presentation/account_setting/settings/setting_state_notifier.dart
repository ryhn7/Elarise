import 'package:elarise/feature_account_setting/presentation/account_setting/settings/setting_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../di/repositories/user_datastore_repository/user_datastore_repository_provider.dart';

class SettingStateNotifier extends StateNotifier<SettingState> {
  final Ref ref;

  SettingStateNotifier(this.ref) : super(SettingState()) {
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

final settingStateNotifierProvider =
    StateNotifierProvider<SettingStateNotifier, SettingState>((ref) {
  return SettingStateNotifier(ref);
});
