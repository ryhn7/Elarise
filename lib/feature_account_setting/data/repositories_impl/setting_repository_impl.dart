import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/core/data/repositories/base_auth_repository.dart';
import 'package:elarise/feature_account_setting/data/repositories/setting_repository.dart';

import '../../../core/data/repositories/user_datastore_repository.dart';

class SettingRepositoryImpl implements SettingRepository {
  final BaseAuthRepository _baseAuthRepository;
    final UserDatastoreRepository _userDatastoreRepository;


  SettingRepositoryImpl(
      {required BaseAuthRepository baseAuthRepository,
      required UserDatastoreRepository userDatastoreRepository})
      : _baseAuthRepository = baseAuthRepository,
        _userDatastoreRepository = userDatastoreRepository;

  @override
  Future<ResultState<bool>> logout() async {
    try {
      await _userDatastoreRepository.clearUserLogin();
      await _baseAuthRepository.logout();
      return const ResultState.success(true);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }
}
