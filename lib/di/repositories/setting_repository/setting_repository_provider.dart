import 'package:elarise/di/repositories/base_auth_repository/base_auth_repository_provider.dart';
import 'package:elarise/feature_account_setting/data/repositories/setting_repository.dart';
import 'package:elarise/feature_account_setting/data/repositories_impl/setting_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setting_repository_provider.g.dart';

@riverpod
SettingRepository settingRepository(SettingRepositoryRef ref) =>
    SettingRepositoryImpl(
        baseAuthRepository: ref.watch(baseAuthRepositoryProvider));
