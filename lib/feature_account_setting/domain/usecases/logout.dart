import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/feature_account_setting/data/repositories/setting_repository.dart';

class Logout {
  final SettingRepository _settingRepository;

  Logout({required SettingRepository settingRepository})
      : _settingRepository = settingRepository;

  Future<ResultState<void>> call() async {
    return await _settingRepository.logout();
  }
}
