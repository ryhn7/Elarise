import 'package:elarise/feature_account_setting/data/repositories/setting_repository.dart';

import '../../../core/common/result_state.dart';

class UpdatePassword {
  final SettingRepository _settingRepository;

  UpdatePassword({required SettingRepository settingRepository})
      : _settingRepository = settingRepository;

  Future<ResultState<bool>> call(
      {required String currentPassword, required String newPassword}) async {
    return await _settingRepository.updatePassword(
        currentPassword: currentPassword, newPassword: newPassword);
  }
}
