import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/feature_assistant/data/repositories/assistant_repository.dart';
import 'package:elarise/feature_assistant/domain/entities/chatroom_voice_response.dart';

import '../../../core/data/repositories/user_datastore_repository.dart';
import '../remote/assistant_api.dart';

class AssistantRepositoryImpl implements AssistantRepository {
  final AssistantApi _assistantApi;
  final UserDatastoreRepository _userDatastoreRepository;

  AssistantRepositoryImpl(
      {required AssistantApi assistantApi,
      required UserDatastoreRepository userDatastoreRepository})
      : _assistantApi = assistantApi,
        _userDatastoreRepository = userDatastoreRepository;

  @override
  Future<ResultState<ChatRoomVoiceResponse>> createFreelyTalkRoom() async {
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
}
