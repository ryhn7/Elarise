import 'package:elarise/feature_assistant/domain/usecases/create_freely_talk_room.dart';
import 'package:elarise/feature_assistant/domain/usecases/create_grammar_talk_room.dart';
import 'package:elarise/feature_assistant/domain/usecases/freely_talk_chat.dart';
import 'package:elarise/feature_assistant/domain/usecases/get_all_freely_talk_rooms.dart';
import 'package:elarise/feature_assistant/domain/usecases/get_all_grammar_talk_room.dart';
import 'package:elarise/feature_assistant/domain/usecases/grammar_talk_chat.dart';

class UseCaseAssistant {
  final CreateFreelyTalkRoom createFreelyTalkRoom;
  final FreelyTalkChat freelyTalkChat;
  final GetAllFreelyTalkRooms getAllFreelyTalkRooms;
  final CreateGrammarTalkRoom createGrammarTalkRoom;
  final GrammarTalkChat grammarTalkChat;
  final GetAllGrammarTalkRooms getAllGrammarTalkRooms;

  UseCaseAssistant({required this.createFreelyTalkRoom, required this.freelyTalkChat, required this.getAllFreelyTalkRooms, required this.createGrammarTalkRoom, required this.grammarTalkChat, required this.getAllGrammarTalkRooms});
}