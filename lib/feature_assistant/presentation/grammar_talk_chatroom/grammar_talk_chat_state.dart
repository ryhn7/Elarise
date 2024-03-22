import 'package:elarise/feature_assistant/domain/entities/elara_response.dart';

import '../../../core/domain/entities/user_preferences.dart';

class GrammarTalkChatState {
  final bool isLoading;
  final String? error;
  final bool isListening;
  final bool isSpeaking;
  final bool isTyping;
  final bool isResponding;
  final String currentSpokenWord;

  final List<ElaraResponse> messageResponse;
  final UserPreferences? userPreferences;
  final Map<String, String> userMessageIds;

  GrammarTalkChatState({
    this.isLoading = false,
    this.error,
    this.messageResponse = const [],
    this.userMessageIds = const {},
    this.userPreferences,
    this.isListening = false,
    this.isSpeaking = false,
    this.isTyping = false,
    this.isResponding = false,
    this.currentSpokenWord = '',
  });

  GrammarTalkChatState copyWith({
    bool? isLoading,
    List<ElaraResponse>? messageResponse,
    Map<String, String>? userMessageIds,
    UserPreferences? userPreferences,
    String? error,
    bool? isListening,
    bool? isSpeaking,
    bool? isTyping,
    bool? isResponding,
    String? currentSpokenWord,
  }) {
    return GrammarTalkChatState(
      isLoading: isLoading ?? this.isLoading,
      messageResponse: messageResponse ?? this.messageResponse,
      userPreferences: userPreferences ?? this.userPreferences,
      userMessageIds: userMessageIds ?? this.userMessageIds,
      isListening: isListening ?? this.isListening,
      isSpeaking: isSpeaking ?? this.isSpeaking,
      isTyping: isTyping ?? this.isTyping,
      isResponding: isResponding ?? this.isResponding,
      currentSpokenWord: currentSpokenWord ?? this.currentSpokenWord,
      error: error ?? error,
    );
  }
}
