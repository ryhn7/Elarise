import 'package:elarise/core/common/result_state.dart';

import '../../domain/entities/user.dart';

abstract interface class AuthenticationRepository {
  Future<ResultState<User?>> signUpEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<ResultState<User?>> loginEmailPassword({
    required String email,
    required String password,
  });


  Future<ResultState<User?>> getCurrentUser();
}
