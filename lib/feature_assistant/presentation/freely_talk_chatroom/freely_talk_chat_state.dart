import 'package:elarise/feature_assistant/domain/entities/talk_freely_response.dart';

import '../../../core/domain/entities/user_preferences.dart';

class FreelyTalkChatState {
  final bool isLoading;
  final String? error;
  final bool isListening;
  final bool isTyping;
  final bool isResponding;

  final List<TalkFreelyResponse> messageResponse;
  final UserPreferences? userPreferences;

  FreelyTalkChatState({
    this.isLoading = false,
    this.error,
    this.messageResponse = const [],
    this.userPreferences,
    this.isListening = false,
    this.isTyping = false,
    this.isResponding = false,
  });

  FreelyTalkChatState copyWith({
    bool? isLoading,
    List<TalkFreelyResponse>? messageResponse,
    UserPreferences? userPreferences,
    String? error,
    bool? isListening,
    bool? isTyping,
    bool? isResponding,
  }) {
    return FreelyTalkChatState(
      isLoading: isLoading ?? this.isLoading,
      messageResponse: messageResponse ?? this.messageResponse,
      userPreferences: userPreferences ?? this.userPreferences,
      isListening: isListening ?? this.isListening,
      isTyping: isTyping ?? this.isTyping,
      isResponding: isResponding ?? this.isResponding,
      error: error ?? error,
    );
  }
}
