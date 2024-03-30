import 'package:elarise/feature_account_setting/domain/usecases/logout.dart';
import 'package:elarise/feature_account_setting/domain/usecases/update_password.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../feature_account_setting/domain/usecases/update_profile.dart';
import '../../../feature_account_setting/domain/usecases/usecase_setting.dart';
import '../../repositories/setting_repository/setting_repository_provider.dart';

part 'usecase_setting_provider.g.dart';

@riverpod
UseCaseSetting useCaseSetting(UseCaseSettingRef ref) => UseCaseSetting(
    logout: Logout(settingRepository: ref.watch(settingRepositoryProvider)),
    updateProfile: UpdateProfile(
      settingRepository: ref.watch(settingRepositoryProvider),
    ),
    updatePassword: UpdatePassword(
        settingRepository: ref.watch(settingRepositoryProvider)));
