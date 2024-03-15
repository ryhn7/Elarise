import 'package:elarise/di/repositories/assistant_repository/assistant_repository_provider.dart';
import 'package:elarise/feature_assistant/domain/usecases/create_grammar_talk_room.dart';
import 'package:elarise/feature_assistant/domain/usecases/freely_talk_chat.dart';
import 'package:elarise/feature_assistant/domain/usecases/get_all_freely_talk_rooms.dart';
import 'package:elarise/feature_assistant/domain/usecases/grammar_talk_chat.dart';
import 'package:elarise/feature_assistant/domain/usecases/usecase_assistant.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../feature_assistant/domain/usecases/create_freely_talk_room.dart';

part 'usecase_assistant_provider.g.dart';

@riverpod
UseCaseAssistant useCaseAssistant(UseCaseAssistantRef ref) => UseCaseAssistant(
    createFreelyTalkRoom: CreateFreelyTalkRoom(
      assistantRepository: ref.watch(assistantRepositoryProvider),
    ),
    freelyTalkChat: FreelyTalkChat(
      assistantRepository: ref.watch(assistantRepositoryProvider),
    ),
    getAllFreelyTalkRooms: GetAllFreelyTalkRooms(
      assistantRepository: ref.watch(assistantRepositoryProvider),
    ),
    createGrammarTalkRoom: CreateGrammarTalkRoom(
      assistantRepository: ref.watch(assistantRepositoryProvider),
    ),
    grammarTalkChat: GrammarTalkChat(
        assistantRepository: ref.watch(assistantRepositoryProvider)));
