import 'package:elarise/di/repositories/base_auth_repository/base_auth_repository_provider.dart';
import 'package:elarise/feature_auth/data/repositories/authentication_repository.dart.dart';
import 'package:elarise/feature_auth/data/repositories_impl/authentication_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_repository_provider.g.dart';

@riverpod
AuthenticationRepository authenticationRepository(
        AuthenticationRepositoryRef ref) =>
    AuthenticationRepositoryImpl(
        baseAuthRepository: ref.watch(baseAuthRepositoryProvider));
