import 'dart:io';

import '../../../core/common/result_state.dart';
import 'package:elarise/feature_account_setting/data/repositories/setting_repository.dart';
import 'package:elarise/feature_auth/domain/entities/user.dart';

class UpdateProfile {
  final SettingRepository _settingRepository;

  UpdateProfile({required SettingRepository settingRepository})
      : _settingRepository = settingRepository;

  Future<ResultState<User?>> call({String? name, File? photoPath}) async {
    return await _settingRepository.updateProfile(
        name: name, photoPath: photoPath);
  }
}
