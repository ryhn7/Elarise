import 'package:elarise/feature_assistant/domain/entities/chatroom_response.dart';
import 'package:elarise/feature_assistant/domain/entities/get_all_talk_freely_response.dart';

import '../../../core/domain/entities/user_preferences.dart';

class HomeState {
  final bool isLoading;
  final String? error;
  final bool isChatRoomLoading;
  final bool isCreatingRoom;

  final UserPreferences? userPreferences;
  final ChatRoomResponse? chatRoomResponse;
  final List<TalkFreelyChatRoom>? freelyTalkRooms;

  HomeState(
      {this.isLoading = false,
      this.isChatRoomLoading = false,
      this.isCreatingRoom = false,
      this.error,
      this.userPreferences,
      this.chatRoomResponse,
      this.freelyTalkRooms});

  HomeState copyWith({
    bool? isLoading,
    bool? isChatRoomLoading,
    bool? isCreatingRoom,
    UserPreferences? userPreferences,
    ChatRoomResponse? chatRoomResponse,
    List<TalkFreelyChatRoom>? freelyTalkRooms,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isChatRoomLoading: isChatRoomLoading ?? this.isChatRoomLoading,
      isCreatingRoom: isCreatingRoom ?? this.isCreatingRoom,
      userPreferences: userPreferences ?? this.userPreferences,
      chatRoomResponse: chatRoomResponse ?? this.chatRoomResponse,
      freelyTalkRooms: freelyTalkRooms ?? this.freelyTalkRooms,
      error: error ?? this.error,
    );
  }
}
