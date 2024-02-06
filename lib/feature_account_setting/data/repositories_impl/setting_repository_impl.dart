import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/core/data/repositories/base_auth_repository.dart';
import 'package:elarise/feature_account_setting/data/repositories/setting_repository.dart';

class SettingRepositoryImpl implements SettingRepository {
  final BaseAuthRepository _baseAuthRepository;

  SettingRepositoryImpl({required BaseAuthRepository baseAuthRepository})
      : _baseAuthRepository = baseAuthRepository;

  @override
  Future<ResultState<void>> logout() async {
    try {
      await _baseAuthRepository.logout();
      return const ResultState.success(null);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }
}
