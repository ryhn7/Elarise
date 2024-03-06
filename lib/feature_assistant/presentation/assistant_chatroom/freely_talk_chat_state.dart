import 'package:elarise/feature_assistant/domain/entities/talk_freely_response.dart';

class FreelyTalkChatState {
  final bool isLoading;
  final String? error;

  final List<TalkFreelyResponse> messageResponse;

  FreelyTalkChatState(
      {this.isLoading = false, this.error, this.messageResponse = const []});

  FreelyTalkChatState copyWith({
    bool? isLoading,
    List<TalkFreelyResponse>? messageResponse,
    String? error,
  }) {
    return FreelyTalkChatState(
      isLoading: isLoading ?? this.isLoading,
      messageResponse: messageResponse ?? this.messageResponse,
      error: error ?? error,
    );
  }
}
