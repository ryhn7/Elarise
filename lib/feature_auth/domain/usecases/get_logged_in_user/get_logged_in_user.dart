import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/core/common/usecases.dart';
import 'package:elarise/feature_auth/domain/entities/user.dart';

import '../../../data/repositories/authentication_repository.dart.dart';
import '../../../data/repositories/user_repository.dart';

class GetLoggedInUser implements UseCases<ResultState<User>, void> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  GetLoggedInUser(
      {required AuthenticationRepository authenticationRepository,
      required UserRepository userRepository})
      : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository;

  @override
  Future<ResultState<User>> call(void _) async {
    try {
      String? loggedId = _authenticationRepository.getLoggedInUserId();

      var userResult = await _userRepository.getUser(uid: loggedId);

      if (userResult.isSuccess) {
        return ResultState.success(userResult.resultData!);
      } else {
        return ResultState.error(userResult.errorMessage!);
      }
    } catch (e) {
      return const ResultState.error("No user logged in.");
    }
  }
}
