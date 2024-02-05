import 'package:elarise/feature_auth/data/repositories/user_repository.dart';
import 'package:elarise/feature_auth/data/repositories_impl/user_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_provider.g.dart';

@riverpod
UserRepository userRepository(UserRepositoryRef ref) => UserRepositoryImpl();
