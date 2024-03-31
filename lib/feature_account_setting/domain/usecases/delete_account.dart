import 'package:elarise/feature_account_setting/data/repositories/setting_repository.dart';

import '../../../core/common/result_state.dart';

class DeleteAccount {
  final SettingRepository _settingRepository;

  DeleteAccount({required SettingRepository settingRepository})
      : _settingRepository = settingRepository;

  Future<ResultState<void>> call() async {
    return await _settingRepository.deleteAccount();
  }
}
