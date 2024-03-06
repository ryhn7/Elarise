import 'package:elarise/feature_assistant/domain/entities/chatroom_voice_response.dart';

import '../../../core/domain/entities/user_preferences.dart';

class HomeState {
  final bool isLoading;
  final String? error;

  final UserPreferences? userPreferences;

  final ChatRoomVoiceResponse? chatRoomVoiceResponse;

  HomeState({this.isLoading = false, this.error, this.userPreferences, this.chatRoomVoiceResponse});

  HomeState copyWith({
    bool? isLoading,
    UserPreferences? userPreferences,
    ChatRoomVoiceResponse? chatRoomVoiceResponse,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      userPreferences: userPreferences ?? this.userPreferences,
      chatRoomVoiceResponse: chatRoomVoiceResponse ?? this.chatRoomVoiceResponse,
      error: error ?? this.error,
    );
  }
}
