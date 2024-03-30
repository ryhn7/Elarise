import 'package:elarise/feature_account_setting/presentation/account_setting/change_password/change_password_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/result_state.dart';
import '../../../../di/usecases/setting_usecases/usecase_setting_provider.dart';

class ChangePasswordStateNotifier extends StateNotifier<ChangePasswordState> {
  final Ref ref;

  ChangePasswordStateNotifier(this.ref) : super(ChangePasswordState());

  Future<void> updatePassword(
      {required String currentPassword, required String newPassword}) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final usecase = ref.read(useCaseSettingProvider);

      var result = await usecase.updatePassword(
          currentPassword: currentPassword, newPassword: newPassword);

      if (result is Success) {
        state = state.copyWith(
            isLoading: false, isPasswordChanged: true, error: null);
      } else {
        state = state.copyWith(
            error: result.errorMessage ?? 'Failed to update password',
            isPasswordChanged: false,
            isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
          error: e.toString(), isLoading: false, isPasswordChanged: false);
    }
  }

  Future<void> clearState() async {
    state = state.copyWith(isPasswordChanged: false, error: null);
  }
}

final changePasswordStateNotifierProvider =
    StateNotifierProvider<ChangePasswordStateNotifier, ChangePasswordState>(
        (ref) => ChangePasswordStateNotifier(ref));
