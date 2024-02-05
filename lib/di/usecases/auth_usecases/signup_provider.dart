import 'package:elarise/feature_auth/domain/usecases/signup/signup.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repositories/authentication_repository/authentication_repository_provider.dart';
import '../../repositories/user_repository/user_repository_provider.dart';

part 'signup_provider.g.dart';

@riverpod
SignUp signUp(SignUpRef ref) => SignUp(
    authenticationRepository: ref.watch(authenticationRepositoryProvider),
    userRepository: ref.watch(userRepositoryProvider));