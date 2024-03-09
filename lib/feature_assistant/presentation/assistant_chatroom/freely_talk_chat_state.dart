import 'package:elarise/feature_assistant/domain/entities/talk_freely_response.dart';

class FreelyTalkChatState {
  final bool isLoading;
  final String? error;

  final List<TalkFreelyResponse> messageResponse;
  final bool isListening;
  final bool isTyping;

  FreelyTalkChatState({
    this.isLoading = false,
    this.error,
    this.messageResponse = const [],
    this.isListening = false,
    this.isTyping = false,
  });

  FreelyTalkChatState copyWith({
    bool? isLoading,
    List<TalkFreelyResponse>? messageResponse,
    String? error,
    bool? isListening,
    bool? isTyping,
  }) {
    return FreelyTalkChatState(
      isLoading: isLoading ?? this.isLoading,
      messageResponse: messageResponse ?? this.messageResponse,
      isListening: isListening ?? this.isListening,
      isTyping: isTyping ?? this.isTyping,
      error: error ?? error,
    );
  }
}
