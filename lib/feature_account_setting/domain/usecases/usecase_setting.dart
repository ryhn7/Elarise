import 'package:elarise/feature_account_setting/domain/usecases/delete_account.dart';
import 'package:elarise/feature_account_setting/domain/usecases/logout.dart';
import 'package:elarise/feature_account_setting/domain/usecases/update_password.dart';
import 'package:elarise/feature_account_setting/domain/usecases/update_profile.dart';

class UseCaseSetting {
  final Logout logout;
  final UpdateProfile updateProfile;
  final UpdatePassword updatePassword;
  final DeleteAccount deleteAccount;

  UseCaseSetting(
      {required this.logout,
      required this.updateProfile,
      required this.updatePassword,
      required this.deleteAccount});
}
