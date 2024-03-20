import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/feature_assistant/data/repositories/assistant_repository.dart';
import 'package:elarise/feature_assistant/domain/entities/chatroom_response.dart';

class EditChatRoom {
  final AssistantRepository _assistantRepository;

  EditChatRoom({required AssistantRepository assistantRepository})
      : _assistantRepository = assistantRepository;

  Future<ResultState<ChatRoomResponse>> call(
      {required String chatRoomId, required String chatRoomName}) async {
    return await _assistantRepository.editChatRoom(
        chatRoomId: chatRoomId, chatRoomName: chatRoomName);
  }
}
