import 'package:elarise/feature_assistant/data/repositories/assistant_repository.dart';

import '../../../core/common/result_state.dart';
import '../entities/chatroom_voice_response.dart';

class CreateFreelyTalkRoom {
  final AssistantRepository _assistantRepository;

  CreateFreelyTalkRoom({required AssistantRepository assistantRepository}) : _assistantRepository = assistantRepository;

  Future<ResultState<ChatRoomVoiceResponse>> call() async {
    return await _assistantRepository.createFreelyTalkRoom();
  }
}