import 'package:elarise/feature_assistant/domain/usecases/create_freely_talk_room.dart';
import 'package:elarise/feature_assistant/domain/usecases/freely_talk_chat.dart';
import 'package:elarise/feature_assistant/domain/usecases/get_all_freely_talk_rooms.dart';

class UseCaseAssistant {
  final CreateFreelyTalkRoom createFreelyTalkRoom;
  final FreelyTalkChat freelyTalkChat;
  final GetAllFreelyTalkRooms getAllFreelyTalkRooms;

  UseCaseAssistant({required this.createFreelyTalkRoom, required this.freelyTalkChat, required this.getAllFreelyTalkRooms});
}