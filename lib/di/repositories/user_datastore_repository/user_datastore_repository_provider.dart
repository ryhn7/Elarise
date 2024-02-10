import 'package:elarise/core/data/repositories/user_datastore_repository.dart';
import 'package:elarise/core/data/repositories_impl/user_datastore_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_datastore_repository_provider.g.dart';

@riverpod
UserDatastoreRepository userDatastoreRepository(
        UserDatastoreRepositoryRef ref) =>
    UserDataStoreRepositoryImpl();
