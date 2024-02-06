import '../../../feature_auth/domain/entities/user.dart';

class SettingState {
  final User? user;
  final bool isLogout;

  SettingState({this.user, this.isLogout = false});

  SettingState copyWith({
    User? user,
    bool? isLogout,
  }) {
    return SettingState(
      user: user ?? this.user,
      isLogout: isLogout ?? this.isLogout,
    );
  }
}
