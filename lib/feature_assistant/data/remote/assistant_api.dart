import 'package:elarise/core/data/remote/api_config.dart';
import 'package:elarise/feature_assistant/domain/entities/chatroom_response.dart';
import 'package:elarise/feature_assistant/domain/entities/elara_response.dart';
import 'package:elarise/feature_assistant/domain/entities/get_all_chatroom_response.dart';
import 'package:elarise/feature_assistant/domain/entities/get_detail_chatroom_response.dart';

class AssistantApi {
  final ApiConfig apiConfig;

  AssistantApi({required this.apiConfig});

  Future<ChatRoomResponse> createFreelyTalkRoom(String token) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await apiConfig.postApiService<ChatRoomResponse>(
          'chatroom-voice',
          headers: headers,
          body: {},
          decoder: (json) => ChatRoomResponse.fromJson(json));

      return response;
    } catch (e) {
      throw Exception('Failed to create freely talk room: $e');
    }
  }

  Future<ChatRoomResponse> createGrammarTalkRoom(String token) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await apiConfig.postApiService<ChatRoomResponse>(
          'chatroom-grammar',
          headers: headers,
          body: {},
          decoder: (json) => ChatRoomResponse.fromJson(json));

      return response;
    } catch (e) {
      throw Exception('Failed to create grammar talk room: $e');
    }
  }

  Future<ElaraResponse> freelyTalkChat(
      String chatRoomId, String messageText, String token) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var body = {
        'messageText': messageText,
      };

      final response = await apiConfig.postApiService<ElaraResponse>(
          'chatroom/$chatRoomId/talk-freely',
          headers: headers,
          body: body,
          decoder: (json) => ElaraResponse.fromJson(json));

      return response;
    } catch (e) {
      throw Exception('Failed to freely talk chat: $e');
    }
  }

  Future<ElaraResponse> grammarTalkChat(
      String chatRoomId, String messageText, String token) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var body = {
        'messageText': messageText,
      };

      final response = await apiConfig.postApiService<ElaraResponse>(
          'chatroom/$chatRoomId/grammar',
          headers: headers,
          body: body,
          decoder: (json) => ElaraResponse.fromJson(json));

      return response;
    } catch (e) {
      throw Exception('Failed to grammar chat: $e');
    }
  }

  Future<List<ChatRoom>> getAllFreelyTalkRooms(String token) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await apiConfig.getApiService<GetAllChatroomResponse>(
          'get-all-chatroom-voice',
          headers: headers,
          decoder: (json) => GetAllChatroomResponse.fromJson(json));

      // Create a new modifiable list from the response data
      List<ChatRoom> newResponse = List<ChatRoom>.from(response.data);

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

  Future<List<ChatRoom>> getAllGrammarTalkRooms(String token) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await apiConfig.getApiService<GetAllChatroomResponse>(
          'get-all-chatroom-grammar',
          headers: headers,
          decoder: (json) => GetAllChatroomResponse.fromJson(json));

      // Create a new modifiable list from the response data
      List<ChatRoom> newResponse = List<ChatRoom>.from(response.data);

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

  Future<ChatRoomResponse> editChatRoomName(
      String chatRoomId, String chatRoomName, String token) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var body = {'chatRoomName': chatRoomName};

      final response = await apiConfig.putApiService<ChatRoomResponse>(
          'chatroom/$chatRoomId',
          headers: headers,
          body: body,
          decoder: (json) => ChatRoomResponse.fromJson(json));

      return response;
    } catch (e) {
      throw Exception('Failed to edit chat room name: $e');
    }
  }

  Future<void> deleteChatRoom(String chatRoomId, String token) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await apiConfig.deleteApiService('chatroom/$chatRoomId',
          headers: headers, decoder: (json) => null);

      return response;
    } catch (e) {
      throw Exception('Failed to delete chat room: $e');
    }
  }

  Future<ElaraResponse> editChat(String chatRoomId, String idMessage,
      String messageText, String token) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var body = {
        'messageText': messageText,
      };

      final response = await apiConfig.putApiService<ElaraResponse>(
          'chatroom/$chatRoomId/edit-text/$idMessage',
          headers: headers,
          body: body,
          decoder: (json) => ElaraResponse.fromJson(json));

      return response;
    } catch (e) {
      throw Exception('Failed to edit chat: $e');
    }
  }

  Future<void> deleteChat(
      String chatRoomId, String idMessage, String token) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await apiConfig.deleteApiService(
          'chatroom/$chatRoomId/chat/$idMessage',
          headers: headers,
          decoder: (json) => null);
      return response;
    } catch (e) {
      throw Exception('Failed to delete chat: $e');
    }
  }

  Future<List<ElaraResponse>> getDetailChatRoom(String chatRoomId, String token) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await apiConfig.getApiService<GetDetailChatroomResponse>(
          'chatroom/$chatRoomId',
          headers: headers,
          decoder: (json) => GetDetailChatroomResponse.fromJson(json));

      return response.data;
    } catch (e) {
      throw Exception('Failed to get detail chat room: $e');
    }
  }
}
