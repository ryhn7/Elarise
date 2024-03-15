import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/feature_assistant/domain/entities/get_all_talk_freely_response.dart';
import 'package:elarise/feature_assistant/domain/entities/elara_response.dart';

import '../../domain/entities/chatroom_response.dart';

abstract interface class AssistantRepository {
  Future<ResultState<ChatRoomResponse>> createFreelyTalkRoom();
  Future<ResultState<ChatRoomResponse>> createGrammarTalkRoom();

  Future<ResultState<List<TalkFreelyChatRoom>>> getAllFreelyTalkRooms();

  Future<ResultState<ElaraResponse>> freelyTalkChat({
    required String chatRoomId,
    required String messageText,
  });

  Future<ResultState<ElaraResponse>> grammarTalkChat({
    required String chatRoomId,
    required String messageText,
  });
}
