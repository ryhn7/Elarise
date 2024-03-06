import 'package:elarise/feature_assistant/domain/usecases/create_freely_talk_room.dart';
import 'package:elarise/feature_assistant/domain/usecases/freely_talk_chat.dart';

class UseCaseAssistant {
  final CreateFreelyTalkRoom createFreelyTalkRoom;
  final FreelyTalkChat freelyTalkChat;

  UseCaseAssistant({required this.createFreelyTalkRoom, required this.freelyTalkChat});
}