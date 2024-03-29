import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/feature_assistant/domain/entities/get_all_chatroom_response.dart';
import 'package:elarise/feature_assistant/domain/entities/elara_response.dart';

import '../../domain/entities/chatroom_response.dart';

abstract interface class AssistantRepository {
  Future<ResultState<ChatRoomResponse>> createFreelyTalkRoom();
  Future<ResultState<ChatRoomResponse>> createGrammarTalkRoom();

  Future<ResultState<List<ChatRoom>>> getAllFreelyTalkRooms();
  Future<ResultState<List<ChatRoom>>> getAllGrammarTalkRooms();

  Future<ResultState<ChatRoomResponse>> editChatRoom(
      {required String chatRoomId, required String chatRoomName});

  Future<ResultState<void>> deleteChatRoom({required String chatRoomId});

  Future<ResultState<ElaraResponse>> freelyTalkChat({
    required String chatRoomId,
    required String messageText,
  });

  Future<ResultState<ElaraResponse>> grammarTalkChat({
    required String chatRoomId,
    required String messageText,
  });

  Future<ResultState<ElaraResponse>> editChat({
    required String chatRoomId,
    required String idMessage,
    required String messageText,
  });

  Future<ResultState<void>> deleteChat({
    required String chatRoomId,
    required String idMessage,
  });

  Future<ResultState<List<ElaraResponse>>> getDetailChatRoom({
    required String chatRoomId,
  });
}
