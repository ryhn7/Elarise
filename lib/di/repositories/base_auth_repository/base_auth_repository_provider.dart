import 'package:elarise/core/data/repositories/base_auth_repository.dart';
import 'package:elarise/core/data/repositories_impl/base_auth_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'base_auth_repository_provider.g.dart';

@riverpod
BaseAuthRepository baseAuthRepository(BaseAuthRepositoryRef ref) =>
    BaseAuthRepositoryImpl();
