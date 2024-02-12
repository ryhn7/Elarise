import 'dart:io';

import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/di/usecases/setting_usecases/usecase_setting_provider.dart';
import 'package:elarise/feature_account_setting/presentation/account_setting/setting_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../feature_auth/presentation/login/login_state.dart';
import '../../../feature_auth/presentation/login/login_state_notifier.dart';
import '../../../router/router_provider.dart';

class SettingStateNotifier extends StateNotifier<SettingState> {
  final Ref ref;

  SettingStateNotifier(this.ref) : super(SettingState());

  Future<void> logout() async {
    try {
      final useCase = ref.read(useCaseSettingProvider);
      var result = await useCase.logout();

      if (result is Success) {
        state = state.copyWith(firebaseUser: null, isLogout: true);
        ref.read(loginStateNotifierProvider.notifier).state =
            LoginState(isLoading: false, user: null);
      } else {
        state = state.copyWith(isLogout: false);
      }
    } catch (e) {
      state = state.copyWith(isLogout: false);
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
        ref.read(routerProvider).goNamed('setting');
      } else {
        state = state.copyWith(error: result.errorMessage, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

final settingStateNotifierProvider =
    StateNotifierProvider<SettingStateNotifier, SettingState>((ref) {
  return SettingStateNotifier(ref);
});
