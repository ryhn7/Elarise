import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/core/data/repositories/base_auth_repository.dart';
import 'package:elarise/feature_auth/data/repositories/authentication_repository.dart.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final BaseAuthRepository _baseAuthRepository;

  AuthenticationRepositoryImpl({required BaseAuthRepository baseAuthRepository})
      : _baseAuthRepository = baseAuthRepository;

  @override
  String getLoggedInUserId() {
    final user = _baseAuthRepository.getCurrentUser();
    return user?.uid ?? '';
  }

  @override
  Future<ResultState<String>> login(
      {required String email, required String password}) async {
    try {
      final user =
          await _baseAuthRepository.signInWithEmailPassword(email, password);
      return ResultState.success(user!.uid);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }

  @override
  Future<ResultState<String>> signUp(
      {required String email, required String password}) async {
    try {
      final user =
          await _baseAuthRepository.registerWithEmailPassword(email, password);
      if (user != null) {
        return ResultState.success(user.uid);
      } else {
        return const ResultState.error('Failed to register user');
      }
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }
}
