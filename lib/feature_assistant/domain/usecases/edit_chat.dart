import 'package:elarise/feature_assistant/data/repositories/assistant_repository.dart';

import '../../../core/common/result_state.dart';
import '../entities/elara_response.dart';

class EditChat {
  final AssistantRepository _assistantRepository;

  EditChat({required AssistantRepository assistantRepository})
      : _assistantRepository = assistantRepository;

  Future<ResultState<ElaraResponse>> call({
    required String chatRoomId,
    required String idMessage,
    required String messageText,
  }) async {
    return await _assistantRepository.editChat(
        chatRoomId: chatRoomId, idMessage: idMessage, messageText: messageText);
  }
}
