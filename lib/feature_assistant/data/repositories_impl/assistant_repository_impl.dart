import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/feature_assistant/data/remote/openai_service.dart';
import 'package:elarise/feature_assistant/data/repositories/assistant_repository.dart';
import 'package:elarise/feature_assistant/domain/entities/chatroom_response.dart';
import 'package:elarise/feature_assistant/domain/entities/get_all_chatroom_response.dart';
import 'package:elarise/feature_assistant/domain/entities/elara_response.dart';

import '../../../core/data/repositories/user_datastore_repository.dart';
import '../remote/assistant_api.dart';

class AssistantRepositoryImpl implements AssistantRepository {
  final AssistantApi _assistantApi;
  final OpenAIService _openAIService;
  final UserDatastoreRepository _userDatastoreRepository;

  AssistantRepositoryImpl(
      {required AssistantApi assistantApi,
      required UserDatastoreRepository userDatastoreRepository,
      required OpenAIService openAIService})
      : _assistantApi = assistantApi,
        _userDatastoreRepository = userDatastoreRepository,
        _openAIService = openAIService;

  @override
  Future<ResultState<ChatRoomResponse>> createFreelyTalkRoom() async {
    try {
      final userPreferences = await _userDatastoreRepository.getUser();
      final token = userPreferences.token ?? '';

      if (token.isEmpty) {
        return const ResultState.error('Token is empty');
      }

      final response = await _assistantApi.createFreelyTalkRoom();
      return ResultState.success(response);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }

  @override
  Future<ResultState<ElaraResponse>> freelyTalkChat(
      {required String chatRoomId, required String messageText}) async {
    try {
      final userPreferences = await _userDatastoreRepository.getUser();
      final token = userPreferences.token ?? '';

      if (token.isEmpty) {
        return const ResultState.error('Token is empty');
      }

      final response =
          await _assistantApi.freelyTalkChat(chatRoomId, messageText);
      final message = response.message;

      // Call text-to-speech service with the chat response
      await _openAIService.fetchAndPlaySpeechAudio(message);

      return ResultState.success(response);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }

  @override
  Future<ResultState<List<ChatRoom>>> getAllFreelyTalkRooms() async {
    try {
      final userPreferences = await _userDatastoreRepository.getUser();
      final token = userPreferences.token ?? '';

      if (token.isEmpty) {
        return const ResultState.error('Token is empty');
      }

      final response = await _assistantApi.getAllFreelyTalkRooms();
      return ResultState.success(response);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }

  @override
  Future<ResultState<ChatRoomResponse>> createGrammarTalkRoom() async {
    try {
      final userPreferences = await _userDatastoreRepository.getUser();
      final token = userPreferences.token ?? '';

      if (token.isEmpty) {
        return const ResultState.error('Token is empty');
      }

      final response = await _assistantApi.createGrammarTalkRoom();
      return ResultState.success(response);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }

  @override
  Future<ResultState<ElaraResponse>> grammarTalkChat(
      {required String chatRoomId, required String messageText}) async {
    try {
      final userPreferences = await _userDatastoreRepository.getUser();
      final token = userPreferences.token ?? '';

      if (token.isEmpty) {
        return const ResultState.error('Token is empty');
      }

      final response =
          await _assistantApi.grammarTalkChat(chatRoomId, messageText);
      // final message = response.message;

      // Call text-to-speech service with the chat response
      // await _openAIService.fetchAndPlaySpeechAudio(message);

      return ResultState.success(response);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }

  @override
  Future<ResultState<List<ChatRoom>>> getAllGrammarTalkRooms() async {
    try {
      final userPreferences = await _userDatastoreRepository.getUser();
      final token = userPreferences.token ?? '';

      if (token.isEmpty) {
        return const ResultState.error('Token is empty');
      }

      final response = await _assistantApi.getAllGrammarTalkRooms();
      return ResultState.success(response);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }

  @override
  Future<ResultState<ChatRoomResponse>> editChatRoom(
      {required String chatRoomId, required String chatRoomName}) async {
    try {
      final userPreferences = await _userDatastoreRepository.getUser();
      final token = userPreferences.token ?? '';

      if (token.isEmpty) {
        return const ResultState.error('Token is empty');
      }

      final response =
          await _assistantApi.editChatRoomName(chatRoomId, chatRoomName);
      return ResultState.success(response);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }

  @override
  Future<ResultState<void>> deleteChatRoom({required String chatRoomId}) async {
    try {
      final userPreferences = await _userDatastoreRepository.getUser();
      final token = userPreferences.token ?? '';

      if (token.isEmpty) {
        return const ResultState.error('Token is empty');
      }

      final response = await _assistantApi.deleteChatRoom(chatRoomId);
      return ResultState.success(response);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }

  @override
  Future<ResultState<void>> deleteChat(
      {required String chatRoomId, required String idMessage}) async {
    try {
      final userPreferences = await _userDatastoreRepository.getUser();
      final token = userPreferences.token ?? '';

      if (token.isEmpty) {
        return const ResultState.error('Token is empty');
      }

      final response = await _assistantApi.deleteChat(chatRoomId, idMessage);
      return ResultState.success(response);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }

  @override
  Future<ResultState<ElaraResponse>> editChat(
      {required String chatRoomId,
      required String idMessage,
      required String messageText}) async {
    try {
      final userPreferences = await _userDatastoreRepository.getUser();
      final token = userPreferences.token ?? '';

      if (token.isEmpty) {
        return const ResultState.error('Token is empty');
      }

      final response =
          await _assistantApi.editChat(chatRoomId, idMessage, messageText);
      return ResultState.success(response);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }

  @override
  Future<ResultState<List<ElaraResponse>>> getDetailChatRoom(
      {required String chatRoomId}) async {
    try {
      final userPreferences = await _userDatastoreRepository.getUser();
      final token = userPreferences.token ?? '';

      if (token.isEmpty) {
        return const ResultState.error('Token is empty');
      }

      final response = await _assistantApi.getDetailChatRoom(chatRoomId);
      return ResultState.success(response);
    } catch (e) {
      return ResultState.error(e.toString());
    }
  }
}
