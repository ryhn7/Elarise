import 'dart:io';

import 'package:elarise/core/common/result_state.dart';

import '../../../feature_auth/domain/entities/user.dart';

abstract interface class SettingRepository {
  Future<ResultState<bool>> logout();

  Future<ResultState<User?>> updateProfile({String? name, File? photoPath});

  Future<ResultState<bool>> updatePassword({
    required String currentPassword,
    required String newPassword,
  });

}
