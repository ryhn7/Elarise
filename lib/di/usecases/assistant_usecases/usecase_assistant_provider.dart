import 'package:elarise/di/repositories/assistant_repository/assistant_repository_provider.dart';
import 'package:elarise/feature_assistant/domain/usecases/usecase_assistant.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../feature_assistant/domain/usecases/create_freely_talk_room.dart';

part 'usecase_assistant_provider.g.dart';

@riverpod
UseCaseAssistant useCaseAssistant(UseCaseAssistantRef ref) => UseCaseAssistant(
      createFreelyTalkRoom: CreateFreelyTalkRoom(assistantRepository: ref.watch(assistantRepositoryProvider)),
    );