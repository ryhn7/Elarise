import 'package:elarise/feature_auth/data/interface_repositories/i_user_repository.dart';
import 'package:elarise/feature_auth/data/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_provider.g.dart';

@riverpod
IUserRepository userRepository(UserRepositoryRef ref) => UserRepository();
