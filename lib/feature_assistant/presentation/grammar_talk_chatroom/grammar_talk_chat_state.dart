import 'package:elarise/feature_assistant/domain/entities/elara_response.dart';

import '../../../core/domain/entities/user_preferences.dart';

class GrammarTalkChatState {
  final bool isLoading;
  final String? error;
  final bool isListening;
  final bool isTyping;
  final bool isResponding;

  final List<ElaraResponse> messageResponse;
  final UserPreferences? userPreferences;

  GrammarTalkChatState({
    this.isLoading = false,
    this.error,
    this.messageResponse = const [],
    this.userPreferences,
    this.isListening = false,
    this.isTyping = false,
    this.isResponding = false,
  });

  GrammarTalkChatState copyWith({
    bool? isLoading,
    List<ElaraResponse>? messageResponse,
    UserPreferences? userPreferences,
    String? error,
    bool? isListening,
    bool? isTyping,
    bool? isResponding,
  }) {
    return GrammarTalkChatState(
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
