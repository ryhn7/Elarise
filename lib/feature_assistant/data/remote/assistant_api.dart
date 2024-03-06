import 'package:elarise/core/data/remote/api_config.dart';
import 'package:elarise/feature_assistant/domain/entities/chatroom_voice_response.dart';
import 'package:elarise/feature_assistant/domain/entities/talk_freely_response.dart';

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

  Future<TalkFreelyResponse> freelyTalkChat(
      String chatRoomId, String messageText) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        'messageText': messageText,
      };

      final response = await apiConfig.postApiService<TalkFreelyResponse>(
          'chatroom/$chatRoomId/talk-freely',
          headers: headers,
          body: body,
          decoder: (json) => TalkFreelyResponse.fromJson(json));

      return response;
    } catch (e) {
      throw Exception('Failed to freely talk chat: $e');
    }
  }
}
