import 'package:elarise/core/common/result_state.dart';

import '../../domain/entities/chatroom_voice_response.dart';

abstract interface class AssistantRepository {
  Future<ResultState<ChatRoomVoiceResponse>> createFreelyTalkRoom();
}