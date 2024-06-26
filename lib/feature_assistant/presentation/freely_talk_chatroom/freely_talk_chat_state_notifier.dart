import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/di/usecases/assistant_usecases/usecase_assistant_provider.dart';
import 'package:elarise/feature_assistant/presentation/freely_talk_chatroom/freely_talk_chat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../di/repositories/user_datastore_repository/user_datastore_repository_provider.dart';
import '../../domain/entities/elara_response.dart';

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
      onError: (val) {
        // Log or handle the initialization error
        state =
            state.copyWith(error: "Error initializing speech to text: $val");
        // Ensure listening is stopped if there was an error during initialization
        stopListening();
      },
      onStatus: (status) => {},
      debugLogging: true,
    );
    if (!available) {
      state = state.copyWith(
          error: "The user has denied the use of speech recognition.");
      stopListening();
    }
  }

  void startListening() {
    if (!state.isListening) {
      speechToText.listen(
        onResult: (result) {
          state = state.copyWith(currentSpokenWord: result.recognizedWords);
          if (result.finalResult) {
            sendMessage(result.recognizedWords);
            stopListening();
          }
        },
        listenFor: const Duration(seconds: 60),
        pauseFor: const Duration(seconds: 5),
      );
      state = state.copyWith(isListening: true, isSpeaking: true);
    }
  }

  void stopListening() {
    if (state.isListening) {
      speechToText.stop();
      state = state.copyWith(isListening: false, isSpeaking: false);
    }
  }

  set chatRoomId(String value) {
    _chatRoomId = value;
  }

  void sendMessage(String text) async {
    if (text.trim().isEmpty) {
      return; // Prevent sending empty messages
    }
    // Introduce a delay
    await Future.delayed(const Duration(seconds: 1));
    // call method to send message to the server
    ref
        .read(freelyTalkChatStateNotifierProvider.notifier)
        .freelyTalkChat(chatRoomId: _chatRoomId!, messageText: text);

    // After sending the message, add a placeholder response
    _addPlaceholderForAIResponse();
    state = state.copyWith(isSpeaking: false);
    clearSpokenWord();
  }

  // Helper method to add a placeholder for the AI response
  void _addPlaceholderForAIResponse() {
    const placeholderResponse = ElaraResponse(
      message: '',
      isUserMessage: false,
      isPlaceholder: true,
    );

    state = state.copyWith(
      messageResponse: [...state.messageResponse, placeholderResponse],
      isResponding: true, // Set this to true since we're awaiting a response
    );
  }

  void clearChat() {
    state = state.copyWith(messageResponse: []);
  }

  void clearSpokenWord() {
    state = state.copyWith(currentSpokenWord: '');
  }

  Future<void> freelyTalkChat(
      {required String chatRoomId, required String messageText}) async {
    try {
      state = state.copyWith(isLoading: true, isResponding: true);

      // Assuming you send the messageText here and await a response
      final ElaraResponse userMessage =
          ElaraResponse(message: messageText, isUserMessage: true);

      // Add the user's message to state
      state = state
          .copyWith(messageResponse: [...state.messageResponse, userMessage]);

      final useCase = ref.read(useCaseAssistantProvider);

      var result = await useCase.freelyTalkChat(
        chatRoomId: chatRoomId,
        messageText: messageText,
      );

      if (result is Success) {
        // Remove the AI pending response placeholder
        var newMessages = List<ElaraResponse>.from(state.messageResponse)
          ..removeLast();
        // Add the actual AI response to the messages
        newMessages.add(result.resultData!);

        state = state.copyWith(
          isLoading: false,
          messageResponse: newMessages,
          isResponding: false,
        );
      } else {
        state = state.copyWith(
            isLoading: false,
            error: result.errorMessage ?? 'An error occurred',
            isResponding: false,
            messageResponse: null);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An error occurred',
        isResponding: false,
        messageResponse: null,
      );
    }
  }

  Future<void> fetchTalkHistory() async {
    try {
      state = state.copyWith(isLoading: true);

      final useCase = ref.read(useCaseAssistantProvider);

      var result = await useCase.getDetailChatRoom(chatRoomId: _chatRoomId!);

      if (result is Success) {
        state = state.copyWith(
          isLoading: false,
          messageResponse: result.resultData!,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result.errorMessage ?? 'An error occurred',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An error occurred',
      );
    }
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
