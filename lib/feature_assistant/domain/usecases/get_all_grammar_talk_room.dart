import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/feature_assistant/data/repositories/assistant_repository.dart';

import '../entities/get_all_chatroom_response.dart';

class GetAllGrammarTalkRooms {
  final AssistantRepository _assistantRepository;

  GetAllGrammarTalkRooms({required AssistantRepository assistantRepository})
      : _assistantRepository = assistantRepository;

      Future<ResultState<List<ChatRoom>>> call() async {
        return await _assistantRepository.getAllGrammarTalkRooms();
      }
}
