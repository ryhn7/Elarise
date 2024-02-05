import 'package:elarise/core/common/result_state.dart';

abstract interface class AuthenticationRepository {
  Future<ResultState<String>> signUp({
    required String email,
    required String password,
  });

  Future<ResultState<String>> login({
    required String email,
    required String password,
  });

  String getLoggedInUserId();
}
