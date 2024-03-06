import 'package:elarise/core/data/remote/api_config.dart';
import 'package:elarise/feature_assistant/domain/entities/chatroom_voice_response.dart';

class AssistantApi {
  final ApiConfig apiConfig;

  AssistantApi({required this.apiConfig});

  Future<ChatRoomVoiceResponse> createFreelyTalkRoom() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      final response = await apiConfig.postApiService<ChatRoomVoiceResponse>(
          'chatroom-voice',
          headers: headers,
          body: {},
          decoder: (json) => ChatRoomVoiceResponse.fromJson(json));

      return response;
    } catch (e) {
      throw Exception('Failed to create freely talk room: $e');
    }
  }
}
