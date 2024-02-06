import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/di/usecases/auth_usecases/get_logged_in_user_provider.dart';
import 'package:elarise/feature_auth/domain/entities/user.dart';
import 'package:elarise/feature_auth/domain/usecases/get_logged_in_user/get_logged_in_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_state.g.dart';

@Riverpod(keepAlive: true)
class HomeState extends _$HomeState {
  @override
  Future<User?> build() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);
    var userResult = await getLoggedInUser(null);

    switch (userResult) {
      case Success(data: final user):
        return user;
      case Error(message: _):
        return null;
    }
  }
}
