import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/core/data/repositories/base_auth_repository.dart';
import 'package:elarise/core/data/repositories/user_datastore_repository.dart';
import 'package:elarise/feature_auth/data/repositories/authentication_repository.dart.dart';
import 'package:elarise/feature_auth/domain/entities/user.dart';

import '../../domain/mapper/user_mapper.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final BaseAuthRepository _baseAuthRepository;
  final UserDatastoreRepository _userDatastoreRepository;

  AuthenticationRepositoryImpl(
      {required BaseAuthRepository baseAuthRepository,
      required UserDatastoreRepository userDatastoreRepository})
      : _baseAuthRepository = baseAuthRepository,
        _userDatastoreRepository = userDatastoreRepository;

  @override
  Future<ResultState<User?>> loginEmailPassword(
      {required String email, required String password}) async {
    try {
      final firebaseUser =
          await _baseAuthRepository.signInWithEmailPassword(email, password);

      final user =
          firebaseUser != null ? firebaseUserToUser(firebaseUser) : null;
      final token = await _baseAuthRepository.getUserToken() ?? '';

      // Save user data to shared preferences
      final userPreference = firebaseUser != null
          ? firebaseUserToUserPreference(firebaseUser, token)
          : null;
      await _userDatastoreRepository.saveUser(userPreference!);

      return ResultState.success(user);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }

  @override
  Future<ResultState<User?>> signUpEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final firebaseUser =
          await _baseAuthRepository.registerWithEmailPassword(email, password);

      await _baseAuthRepository.initProfile(name);

      await firebaseUser?.reload();

      final updatedUser = _baseAuthRepository.getCurrentUser();

      final user =
          firebaseUser != null ? firebaseUserToUser(updatedUser!) : null;

      final token = await _baseAuthRepository.getUserToken() ?? '';

      //  Save user data to shared preferences
      final userPreference = firebaseUser != null
          ? firebaseUserToUserPreference(updatedUser!, token)
          : null;
      await _userDatastoreRepository.saveUser(userPreference!);

      return ResultState.success(user);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }

  @override
  Future<ResultState<User?>> getCurrentUser() async {
    try {
      final userPref = await _userDatastoreRepository.getUser();

      if (userPref.email == null || userPref.email == '') {
        return const ResultState.error('User not found');
      }

      final user = userPreferenceToUser(userPref);
      final token = await _baseAuthRepository.getUserToken() ?? '';
      await _userDatastoreRepository.saveToken(token);

      return ResultState.success(user);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }
}
