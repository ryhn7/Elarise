import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/di/usecases/assistant_usecases/usecase_assistant_provider.dart';
import 'package:elarise/feature_assistant/presentation/freely_talk_chatroom/freely_talk_chat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../di/repositories/user_datastore_repository/user_datastore_repository_provider.dart';
import '../../domain/entities/talk_freely_response.dart';

class FreelyTalkChatStateNotifier extends StateNotifier<FreelyTalkChatState> {
  final Ref ref;
  String? _chatRoomId; // Hold the chatRoomId internally
  final SpeechToText speechToText = SpeechToText();

  FreelyTalkChatStateNotifier(this.ref) : super(FreelyTalkChatState()) {
    checkMicrophoneAvailability();
    _loadUserPreferences();
  }

  Future<void> refreshUserPreferences() async {
    _loadUserPreferences(); // This method should fetch the latest user data
  }

  Future<void> _loadUserPreferences() async {
    state = state.copyWith(isLoading: true);

    try {
      final userPreferences =
          await ref.read(userDatastoreRepositoryProvider).getUser();
      state =
          state.copyWith(userPreferences: userPreferences, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  void checkMicrophoneAvailability() async {
    bool available = await speechToText.initialize(
      onError: (val) => state =
          state.copyWith(error: "Error initializing speech to text: $val"),
      onStatus: (status) => {},
      debugLogging: true,
    );
    if (!available) {
      state = state.copyWith(
          error: "The user has denied the use of speech recognition.");
    }
  }

  void startListening() {
    if (!state.isListening) {
      speechToText.listen(
        onResult: (result) {
          state = state.copyWith(isTyping: true);
          if (result.finalResult) {
            sendMessage(result.recognizedWords);
            state = state.copyWith(isTyping: false);
            stopListening();
          }
        },
        listenFor: const Duration(seconds: 60),
        pauseFor: const Duration(seconds: 3),
      );
      state = state.copyWith(isListening: true);
    }
  }

  void stopListening() {
    if (state.isListening) {
      speechToText.stop();
      state = state.copyWith(isListening: false);
    }
  }

  set chatRoomId(String value) {
    _chatRoomId = value;
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) {
      return; // Prevent sending empty messages
    }
    // call method to send message to the server
    ref
        .read(freelyTalkChatStateNotifierProvider.notifier)
        .freelyTalkChat(chatRoomId: _chatRoomId!, messageText: text);
  }

  void clearChat() {
    state = state.copyWith(messageResponse: []);
  }

  Future<void> freelyTalkChat(
      {required String chatRoomId, required String messageText}) async {
    try {
      state = state.copyWith(isLoading: true);

      // Assuming you send the messageText here and await a response
      final TalkFreelyResponse userMessage =
          TalkFreelyResponse(message: messageText, isUserMessage: true);

      // Add the user's message to state
      state = state
          .copyWith(messageResponse: [...state.messageResponse, userMessage]);

      final useCase = ref.read(useCaseAssistantProvider);

      var result = await useCase.freelyTalkChat(
        chatRoomId: chatRoomId,
        messageText: messageText,
      );

      if (result is Success) {
        state = state.copyWith(
          isLoading: false,
          messageResponse: [...state.messageResponse, result.resultData!],
        );
      } else {
        state = state.copyWith(
            isLoading: false,
            error: result.errorMessage ?? 'An error occurred',
            messageResponse: null);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An error occurred',
        messageResponse: null,
      );
    }
  }

  void updateTypingState(bool isTyping) {
    state = state.copyWith(isTyping: isTyping);
  }

  @override
  void dispose() {
    speechToText.stop();
    speechToText.cancel();
    super.dispose();
  }
}

final freelyTalkChatStateNotifierProvider =
    StateNotifierProvider<FreelyTalkChatStateNotifier, FreelyTalkChatState>(
        (ref) => FreelyTalkChatStateNotifier(ref));
