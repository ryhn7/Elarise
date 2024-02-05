import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/core/common/usecases.dart';
import 'package:elarise/feature_auth/data/repositories/authentication_repository.dart.dart';
import 'package:elarise/feature_auth/data/repositories/user_repository.dart';
import 'package:elarise/feature_auth/domain/entities/user.dart';

part 'login_params.dart';

class Login implements UseCases<ResultState<User>, LoginParams> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  Login({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository;
  

  @override
  Future<ResultState<User>> call(LoginParams params) async {
    var idResult = await _authenticationRepository.login(
        email: params.email, password: params.password);

    if (idResult is Success) {
      var userResult = await _userRepository.getUser(uid: idResult.resultData!);
      return switch (userResult) {
        Success(data: final user) => ResultState.success(user),
        Error(errorMessage: final errorMessage) =>
          ResultState.error(errorMessage!),
      };
    } else {
      return ResultState.error(idResult.errorMessage!);
    }
  }
}
