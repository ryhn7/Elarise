import 'package:elarise/feature_auth/domain/usecases/get_current_user.dart';
import 'package:elarise/feature_auth/domain/usecases/login_email_password.dart';
import 'package:elarise/feature_auth/domain/usecases/signup_email_password.dart';

class UseCaseAuth {
  final LoginEmailPassword loginEmailPassword;
  final SignUpEmailPassword signUpEmailPassword;
  final GetCurrentUser getCurrentUser;

  UseCaseAuth(
      {required this.loginEmailPassword,
      required this.signUpEmailPassword,
      required this.getCurrentUser});
}
