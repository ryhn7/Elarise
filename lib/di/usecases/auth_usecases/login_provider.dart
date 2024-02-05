import 'package:elarise/di/repositories/authentication_repository/authentication_repository_provider.dart';
import 'package:elarise/di/repositories/user_repository/user_repository_provider.dart';
import 'package:elarise/feature_auth/domain/usecases/login/login.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
Login login(LoginRef ref) => Login(
    authenticationRepository: ref.watch(authenticationRepositoryProvider),
    userRepository: ref.watch(userRepositoryProvider));
