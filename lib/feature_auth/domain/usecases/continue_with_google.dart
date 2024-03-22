import 'package:elarise/feature_auth/data/repositories/authentication_repository.dart.dart';

import '../../../core/common/result_state.dart';
import '../entities/user.dart';

class ContinueWithGoogle {
  final AuthenticationRepository _authenticationRepository;

  ContinueWithGoogle(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  Future<ResultState<User?>> call() async {
    return await _authenticationRepository.continueWithGoogle();
  }
}
