import 'package:elarise/di/repositories/base_auth_repository/base_auth_repository_provider.dart';
import 'package:elarise/feature_auth/data/repositories/authentication_repository.dart.dart';
import 'package:elarise/feature_auth/data/repositories_impl/authentication_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../user_datastore_repository/user_datastore_repository_provider.dart';

part 'authentication_repository_provider.g.dart';

@riverpod
AuthenticationRepository authenticationRepository(
        AuthenticationRepositoryRef ref) =>
    AuthenticationRepositoryImpl(
        baseAuthRepository: ref.watch(baseAuthRepositoryProvider),
        userDatastoreRepository: ref.watch(userDatastoreRepositoryProvider));
