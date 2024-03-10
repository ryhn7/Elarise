import 'package:elarise/feature_assistant/domain/entities/chatroom_voice_response.dart';
import 'package:elarise/feature_assistant/domain/entities/get_all_talk_freely_response.dart';

import '../../../core/domain/entities/user_preferences.dart';

class HomeState {
  final bool isLoading;
  final String? error;
  final bool isChatRoomLoading;

  final UserPreferences? userPreferences;
  final ChatRoomVoiceResponse? chatRoomVoiceResponse;
  final List<TalkFreelyChatRoom>? freelyTalkRooms;

  HomeState(
      {this.isLoading = false,
      this.isChatRoomLoading = false,
      this.error,
      this.userPreferences,
      this.chatRoomVoiceResponse,
      this.freelyTalkRooms});

  HomeState copyWith({
    bool? isLoading,
    bool? isChatRoomLoading,
    UserPreferences? userPreferences,
    ChatRoomVoiceResponse? chatRoomVoiceResponse,
    List<TalkFreelyChatRoom>? freelyTalkRooms,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isChatRoomLoading: isChatRoomLoading ?? this.isChatRoomLoading,
      userPreferences: userPreferences ?? this.userPreferences,
      chatRoomVoiceResponse:
          chatRoomVoiceResponse ?? this.chatRoomVoiceResponse,
      freelyTalkRooms: freelyTalkRooms ?? this.freelyTalkRooms,
      error: error ?? this.error,
    );
  }
}
