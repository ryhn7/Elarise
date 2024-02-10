import '../../../core/common/result_state.dart';
import '../../data/repositories/authentication_repository.dart.dart';
import '../entities/user.dart';

class SignUpEmailPassword {
  final AuthenticationRepository _authenticationRepository;

  SignUpEmailPassword(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  Future<ResultState<User?>> call(
      String name, String email, String password) async {
    return await _authenticationRepository.signUpEmailPassword(
        name: name, email: email, password: password);
  }
}
