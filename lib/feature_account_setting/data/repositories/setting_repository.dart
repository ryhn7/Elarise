import 'package:elarise/core/common/result_state.dart';

abstract interface class SettingRepository {
  Future<ResultState<bool>> logout();
}