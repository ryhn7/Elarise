import 'package:elarise/feature_assistant/domain/entities/chatroom_response.dart';
import 'package:elarise/feature_assistant/domain/entities/get_all_chatroom_response.dart';

import '../../../core/domain/entities/user_preferences.dart';

class HomeState {
  final bool isLoading;
  final String? error;
  final bool isChatRoomLoading;
  final bool isCreatingRoom;
  final bool isRenamingChatRoomName;
  final bool isDeletingChatRoom;
  final String dropdownSelection;

  final UserPreferences? userPreferences;
  final ChatRoomResponse? chatRoomResponse;
  final List<ChatRoom>? chatRooms;

  HomeState(
      {this.isLoading = false,
      this.isChatRoomLoading = false,
      this.isCreatingRoom = false,
      this.isRenamingChatRoomName = false,
      this.isDeletingChatRoom = false,
      this.dropdownSelection = 'Talking',
      this.error,
      this.userPreferences,
      this.chatRoomResponse,
      this.chatRooms});

  HomeState copyWith({
    bool? isLoading,
    bool? isChatRoomLoading,
    bool? isCreatingRoom,
    bool? isRenamingChatRoomName,
    bool? isDeletingChatRoom,
    String? dropdownSelection,
    UserPreferences? userPreferences,
    ChatRoomResponse? chatRoomResponse,
    List<ChatRoom>? chatRooms,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isChatRoomLoading: isChatRoomLoading ?? this.isChatRoomLoading,
      isCreatingRoom: isCreatingRoom ?? this.isCreatingRoom,
      isRenamingChatRoomName:
          isRenamingChatRoomName ?? this.isRenamingChatRoomName,
      isDeletingChatRoom: isDeletingChatRoom ?? this.isDeletingChatRoom,
      dropdownSelection: dropdownSelection ?? this.dropdownSelection,
      userPreferences: userPreferences ?? this.userPreferences,
      chatRoomResponse: chatRoomResponse ?? this.chatRoomResponse,
      chatRooms: chatRooms ?? this.chatRooms,
      error: error ?? this.error,
    );
  }
}
