import 'package:elarise/di/remote/assistant_api/assistant_api_provider.dart';
import 'package:elarise/di/repositories/user_datastore_repository/user_datastore_repository_provider.dart';
import 'package:elarise/feature_assistant/data/repositories/assistant_repository.dart';
import 'package:elarise/feature_assistant/data/repositories_impl/assistant_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assistant_repository_provider.g.dart';

@riverpod
AssistantRepository assistantRepository(AssistantRepositoryRef ref) =>
    AssistantRepositoryImpl(
        assistantApi: ref.watch(assistantApiProvider),
        userDatastoreRepository: ref.watch(userDatastoreRepositoryProvider));
