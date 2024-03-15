import '../../../core/common/result_state.dart';
import '../../data/repositories/assistant_repository.dart';
import '../entities/elara_response.dart';

class GrammarTalkChat {
  final AssistantRepository _assistantRepository;

  GrammarTalkChat({required AssistantRepository assistantRepository})
      : _assistantRepository = assistantRepository;

  Future<ResultState<ElaraResponse>> call(
      {required String chatRoomId, required String messageText}) async {
    return await _assistantRepository.grammarTalkChat(
        chatRoomId: chatRoomId, messageText: messageText);
  }
}