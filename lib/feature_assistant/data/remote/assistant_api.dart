import 'package:elarise/core/data/remote/api_config.dart';
import 'package:elarise/feature_assistant/domain/entities/chatroom_voice_response.dart';
import 'package:elarise/feature_assistant/domain/entities/get_all_talk_freely_response.dart';
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

  Future<List<TalkFreelyChatRoom>> getAllFreelyTalkRooms() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      final response = await apiConfig.getApiService<GetAllTalkFreelyResponse>(
          'get-all-chatroom-voice',
          headers: headers,
          decoder: (json) => GetAllTalkFreelyResponse.fromJson(json));

      // Create a new modifiable list from the response data
      List<TalkFreelyChatRoom> newResponse =
          List<TalkFreelyChatRoom>.from(response.data);

      // Sort the modifiable list by the createdAt field, newest first
      newResponse.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      // exclude lastAIMessageText that have null value
      newResponse = newResponse
          .where((chatroom) => chatroom.lastAIMessageText != null)
          .toList();

      return newResponse;
    } catch (e) {
      throw Exception('Failed to get all freely talk chat rooms: $e');
    }
  }
}
