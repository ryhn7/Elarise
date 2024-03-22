import 'package:elarise/feature_auth/domain/usecases/continue_with_google.dart';
import 'package:elarise/feature_auth/domain/usecases/login_email_password.dart';
import 'package:elarise/feature_auth/domain/usecases/usecase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../feature_auth/domain/usecases/get_current_user.dart';
import '../../../feature_auth/domain/usecases/signup_email_password.dart';
import '../../repositories/authentication_repository/authentication_repository_provider.dart';

part 'usecase_auth_provider.g.dart';

@riverpod
UseCaseAuth useCaseAuth(UseCaseAuthRef ref) => UseCaseAuth(
      loginEmailPassword: LoginEmailPassword(
          authenticationRepository:
              ref.watch(authenticationRepositoryProvider)),
      signUpEmailPassword: SignUpEmailPassword(
          authenticationRepository:
              ref.watch(authenticationRepositoryProvider)),
      getCurrentUser: GetCurrentUser(
          authenticationRepository:
              ref.watch(authenticationRepositoryProvider)),
      continueWithGoogle: ContinueWithGoogle(
          authenticationRepository:
              ref.watch(authenticationRepositoryProvider)),
    );
