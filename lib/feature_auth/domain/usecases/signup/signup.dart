import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/core/common/usecases.dart';
import 'package:elarise/feature_auth/domain/entities/user.dart';

import '../../../data/repositories/authentication_repository.dart.dart';
import '../../../data/repositories/user_repository.dart';

part 'signup_params.dart';

class SignUp implements UseCases<ResultState<User>, SignUpParams> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  SignUp({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository;

  @override
  Future<ResultState<User>> call(params) async {
    try {
      var idResult = await _authenticationRepository.signUp(
          email: params.email, password: params.password);

      if (idResult.isSuccess) {
        var userResult = await _userRepository.createUser(
            email: params.email,
            username: params.username ?? "",
            photoProfile: params.photoProfile ??
                "https://firebasestorage.googleapis.com/v0/b/conversation-app-e3566.appspot.com/o/profileImage%2Fuser_placeholder.png?alt=media&token=77393a77-8952-4c2d-a0bc-c343dac4efed");
        if (userResult.isSuccess) {
          return ResultState.success(userResult.resultData!);
        } else {
          return ResultState.error(userResult.errorMessage!);
        }
      } else {
        return ResultState.error(idResult.errorMessage!);
      }
    } on Exception catch (e) {
      return ResultState.error(e.toString());
    }
  }
}
