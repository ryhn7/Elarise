import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/feature_auth/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../di/usecases/auth_usecases/login_provider.dart';
import '../../domain/usecases/login/login.dart';

class LoginState extends StateNotifier<AsyncValue<User?>> {
  final Ref ref;

  LoginState(this.ref) : super(const AsyncData(null));

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();

    Login login = ref.read(loginProvider);

    var result = await login(LoginParams(email: email, password: password));

    switch (result) {
      case Success(data: final user):
        state = AsyncData(user);
      case Error(message: final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }
}

final loginStateProvider =
    StateNotifierProvider<LoginState, AsyncValue<User?>>((ref) {
  return LoginState(ref);
});
