import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/feature_assistant/data/repositories/assistant_repository.dart';

class DeleteChat {
  final AssistantRepository _assistantRepository;

  DeleteChat({required AssistantRepository assistantRepository})
      : _assistantRepository = assistantRepository;

  Future<ResultState<void>> call(
      {required String chatRoomId, required String idMessage}) async {
    return await _assistantRepository.deleteChat(
        chatRoomId: chatRoomId, idMessage: idMessage);
  }
}
