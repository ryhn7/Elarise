import 'package:elarise/feature_assistant/domain/entities/elara_response.dart';

import '../../../core/domain/entities/user_preferences.dart';

class FreelyTalkChatState {
  final bool isLoading;
  final String? error;
  final bool isListening;
  final bool isSpeaking;
  final bool isResponding;
  final String currentSpokenWord;

  final List<ElaraResponse> messageResponse;
  final UserPreferences? userPreferences;

  FreelyTalkChatState({
    this.isLoading = false,
    this.error,
    this.messageResponse = const [],
    this.userPreferences,
    this.isListening = false,
    this.isSpeaking = false,
    this.isResponding = false,
    this.currentSpokenWord = '',
  });

  FreelyTalkChatState copyWith({
    bool? isLoading,
    List<ElaraResponse>? messageResponse,
    UserPreferences? userPreferences,
    String? error,
    bool? isListening,
    bool? isSpeaking,
    bool? isResponding,
    String? currentSpokenWord,
  }) {
    return FreelyTalkChatState(
      isLoading: isLoading ?? this.isLoading,
      messageResponse: messageResponse ?? this.messageResponse,
      userPreferences: userPreferences ?? this.userPreferences,
      isListening: isListening ?? this.isListening,
      isSpeaking: isSpeaking ?? this.isSpeaking,
      currentSpokenWord: currentSpokenWord ?? this.currentSpokenWord,
      isResponding: isResponding ?? this.isResponding,
      error: error ?? error,
    );
  }
}
