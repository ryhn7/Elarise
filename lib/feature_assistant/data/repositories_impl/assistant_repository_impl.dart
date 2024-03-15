import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/feature_assistant/data/remote/openai_service.dart';
import 'package:elarise/feature_assistant/data/repositories/assistant_repository.dart';
import 'package:elarise/feature_assistant/domain/entities/chatroom_response.dart';
import 'package:elarise/feature_assistant/domain/entities/get_all_talk_freely_response.dart';
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
  Future<ResultState<List<TalkFreelyChatRoom>>> getAllFreelyTalkRooms() async {
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
}
