import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/feature_assistant/data/repositories/assistant_repository.dart';

class DeleteChatRoom {
  final AssistantRepository _assistantRepository;

  DeleteChatRoom({required AssistantRepository assistantRepository})
      : _assistantRepository = assistantRepository;

  Future<ResultState<void>> call({required String chatRoomId}) async {
    return await _assistantRepository.deleteChatRoom(chatRoomId: chatRoomId);
  }
}
