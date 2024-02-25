import 'dart:io';

import 'package:elarise/feature_account_setting/presentation/account_setting/edit_profile/edit_profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/result_state.dart';
import '../../../../di/repositories/user_datastore_repository/user_datastore_repository_provider.dart';
import '../../../../di/usecases/setting_usecases/usecase_setting_provider.dart';
import '../../../../router/router_provider.dart';

class EditProfileStateNotifier extends StateNotifier<EditProfileState> {
  final Ref ref;

  EditProfileStateNotifier(this.ref) : super(EditProfileState()) {
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

  Future<void> updateProfile({String? name, File? photoPath}) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final useCase = ref.read(useCaseSettingProvider);
      var result =
          await useCase.updateProfile(name: name, photoPath: photoPath);

      if (result is Success) {
        state = state.copyWith(user: result.resultData, isLoading: false);
      } else {
        state = state.copyWith(error: result.errorMessage, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

final editProfileStateNotifierProvider =
    StateNotifierProvider<EditProfileStateNotifier, EditProfileState>((ref) {
  return EditProfileStateNotifier(ref);
});
