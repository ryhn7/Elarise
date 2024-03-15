import '../../../core/common/result_state.dart';
import '../../data/repositories/assistant_repository.dart';
import '../entities/chatroom_response.dart';

class CreateGrammarTalkRoom {
  final AssistantRepository _assistantRepository;

  CreateGrammarTalkRoom({required AssistantRepository assistantRepository})
      : _assistantRepository = assistantRepository;

  Future<ResultState<ChatRoomResponse>> call() async {
    return await _assistantRepository.createFreelyTalkRoom();
  }
}