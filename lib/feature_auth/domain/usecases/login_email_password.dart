import '../../../core/common/result_state.dart';
import '../../data/repositories/authentication_repository.dart.dart';
import '../entities/user.dart';

class LoginEmailPassword {
  final AuthenticationRepository _authenticationRepository;

  LoginEmailPassword(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  Future<ResultState<User?>> call(String email, String password) async {
    return await _authenticationRepository.loginEmailPassword(
        email: email, password: password);
  }
}
