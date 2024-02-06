import 'package:elarise/feature_account_setting/domain/usecases/logout/logout.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repositories/setting_repository/setting_repository_provider.dart';

part 'logout_provider.g.dart';

@riverpod
Logout logout(LogoutRef ref) =>
    Logout(settingRepository: ref.watch(settingRepositoryProvider));
