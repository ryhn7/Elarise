import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/feature_assistant/data/repositories/assistant_repository.dart';

import '../entities/get_all_talk_freely_response.dart';

class GetAllFreelyTalkRooms {
  final AssistantRepository _assistantRepository;

  GetAllFreelyTalkRooms({required AssistantRepository assistantRepository})
      : _assistantRepository = assistantRepository;

  Future<ResultState<List<TalkFreelyChatRoom>>> call() async {
    return await _assistantRepository.getAllFreelyTalkRooms();
  }
}
