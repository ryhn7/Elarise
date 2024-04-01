import 'dart:developer';

import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/di/repositories/user_datastore_repository/user_datastore_repository_provider.dart';
import 'package:elarise/di/usecases/setting_usecases/usecase_setting_provider.dart';
import 'package:elarise/feature_account_setting/presentation/account_setting/manage_account/account_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature_assistant/presentation/home/home_state_notifier.dart';
import '../../../../feature_auth/presentation/login/login_state.dart';
import '../../../../feature_auth/presentation/login/login_state_notifier.dart';

class AccountStateNotifier extends StateNotifier<AccountState> {
  final Ref ref;

  AccountStateNotifier(this.ref) : super(AccountState());

  Future<void> _clearUserLogin() async {
    await ref.read(userDatastoreRepositoryProvider).clearUserLogin();
    log('User login cleared');
  }

  Future<void> logout() async {
    try {
      final useCase = ref.read(useCaseSettingProvider);
      var result = await useCase.logout();

      if (result is Success) {
        await _clearUserLogin();
        state = state.copyWith(firebaseUser: null, isLogout: true, user: null);
        ref.read(homeStateNotifierProvider.notifier).clearChatRoomHistory();
        log('User logout successfully');
        ref.read(loginStateNotifierProvider.notifier).state =
            LoginState(isLoading: false, user: null);
      } else {
        state = state.copyWith(isLogout: false);
      }
    } catch (e) {
      state = state.copyWith(isLogout: false);
    }
  }

  Future<void> deleteAccount() async {
    try {
      final useCase = ref.read(useCaseSettingProvider);
      var result = await useCase.deleteAccount();

      if (result is Success) {
        await _clearUserLogin();
        state = state.copyWith(firebaseUser: null, isDelete: true);
        ref.read(loginStateNotifierProvider.notifier).state =
            LoginState(isLoading: false, user: null);
      } else {
        state = state.copyWith(isDelete: false);
      }
    } catch (e) {
      state = state.copyWith(isDelete: false);
    }
  }
}

final accountStateNotifierProvider =
    StateNotifierProvider<AccountStateNotifier, AccountState>((ref) {
  return AccountStateNotifier(ref);
});
