import '../../../core/common/result_state.dart';
import '../../data/repositories/assistant_repository.dart';
import '../entities/elara_response.dart';

class GetDetailChatRoom {
  final AssistantRepository _assistantRepository;

  GetDetailChatRoom({required AssistantRepository assistantRepository})
      : _assistantRepository = assistantRepository;

  Future<ResultState<List<ElaraResponse>>> call(
      {required String chatRoomId}) async {
    return await _assistantRepository.getDetailChatRoom(chatRoomId: chatRoomId);
  }
}
