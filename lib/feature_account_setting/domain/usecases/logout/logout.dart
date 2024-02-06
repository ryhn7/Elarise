import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/core/common/usecases.dart';
import 'package:elarise/feature_account_setting/data/repositories/setting_repository.dart';

class Logout implements UseCases<ResultState<void>, void> {
  final SettingRepository _settingRepository;

  Logout({required SettingRepository settingRepository})
      : _settingRepository = settingRepository;

  @override
  Future<ResultState<void>> call(void _) {
    return _settingRepository.logout();
  }
}
