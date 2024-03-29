import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/feature_assistant/data/repositories/assistant_repository.dart';
import 'package:elarise/feature_assistant/domain/entities/elara_response.dart';

class FreelyTalkChat {
  final AssistantRepository _assistantRepository;

  FreelyTalkChat({required AssistantRepository assistantRepository})
      : _assistantRepository = assistantRepository;

  Future<ResultState<ElaraResponse>> call(
      {required String chatRoomId, required String messageText}) async {
    return await _assistantRepository.freelyTalkChat(
        chatRoomId: chatRoomId, messageText: messageText);
  }
}
