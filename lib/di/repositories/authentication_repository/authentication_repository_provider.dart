import 'package:elarise/feature_auth/data/interface_repositories/i_authentication_repository.dart.dart';
import 'package:elarise/feature_auth/data/repositories/authentication_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_repository_provider.g.dart';

@riverpod
IAuthenticationRepository authenticationRepository(
        AuthenticationRepositoryRef ref) =>
    AuthenticationRepository();
