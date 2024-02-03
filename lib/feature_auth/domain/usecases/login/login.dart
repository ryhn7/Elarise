import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/core/common/usecases.dart';
import 'package:elarise/feature_auth/data/interface_repositories/i_authentication_repository.dart.dart';
import 'package:elarise/feature_auth/data/interface_repositories/i_user_repository.dart';
import 'package:elarise/feature_auth/domain/entities/user.dart';

part 'login_params.dart';

class Login implements UseCases<ResultState<User>, LoginParams> {
  final IAuthenticationRepository authenticationRepository;
  final IUserRepository userRepository;

  Login({
    required this.authenticationRepository,
    required this.userRepository,
  });

  @override
  Future<ResultState<User>> call(LoginParams params) async {
    var idResult = await authenticationRepository.login(
        email: params.email, password: params.password);

    if (idResult is Success) {
      var userResult = await userRepository.getUser(uid: idResult.resultData!);
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
