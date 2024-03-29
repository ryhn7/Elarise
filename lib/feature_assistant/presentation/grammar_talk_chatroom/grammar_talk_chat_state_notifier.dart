import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/di/usecases/assistant_usecases/usecase_assistant_provider.dart';
import 'package:elarise/feature_assistant/presentation/grammar_talk_chatroom/grammar_talk_chat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../di/repositories/user_datastore_repository/user_datastore_repository_provider.dart';
import '../../domain/entities/elara_response.dart';

class GrammarTalkChatStateNotifier extends StateNotifier<GrammarTalkChatState> {
  final Ref ref;
  String? _chatRoomId; // Hold the chatRoomId internally
  final SpeechToText speechToText = SpeechToText();

  Function(String)? onSpeechResult;

  GrammarTalkChatStateNotifier(this.ref, {this.onSpeechResult})
      : super(GrammarTalkChatState()) {
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
          state = state.copyWith(
              isTyping: false, currentSpokenWord: result.recognizedWords);

          // Use the callback to update the UI
          onSpeechResult?.call(result.recognizedWords);

          if (result.finalResult) {
            sendMessage(result.recognizedWords);
            state = state.copyWith(isTyping: false);
            stopListening();
          }
        },
        listenFor: const Duration(seconds: 60),
        pauseFor: const Duration(seconds: 3),
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

  void sendMessage(String text) {
    if (text.trim().isEmpty) {
      return; // Prevent sending empty messages
    }
    // call method to send message to the server
    ref
        .read(grammarTalkChatStateNotifierProvider.notifier)
        .grammarTalkChat(chatRoomId: _chatRoomId!, messageText: text);

    // After sending the message, add a placeholder response
    _addPlaceholderForAIResponse();
    state = state.copyWith(isTyping: false, isSpeaking: false);
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

  Future<void> grammarTalkChat(
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

      var result = await useCase.grammarTalkChat(
        chatRoomId: chatRoomId,
        messageText: messageText,
      );

      if (result is Success) {
        // Remove the AI pending response placeholder
        var newMessages = List<ElaraResponse>.from(state.messageResponse)
          ..removeLast();
        // Add the actual AI response to the messages
        newMessages.add(result.resultData!);

        // Update userMessageIds with the idMessage from the response
        final userMessageId = result.resultData!.idMessage;
        final newUserMessageIds = Map<String, String>.from(state.userMessageIds)
          ..[messageText] = userMessageId;

        state = state.copyWith(
          isLoading: false,
          messageResponse: newMessages,
          isResponding: false,
          userMessageIds: newUserMessageIds,
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

  void updateTypingState(bool isTyping) {
    state = state.copyWith(isTyping: isTyping);
  }

  Future<void> deleteChat(String idMessage) async {
    try {
      state = state.copyWith(isLoading: true, isDeleteChat: true);

      final usecase = ref.read(useCaseAssistantProvider);

      var result = await usecase.deleteChat(
          chatRoomId: _chatRoomId!, idMessage: idMessage);

      if (result is Success) {
        // Find the index of the message to be deleted
        final indexToDelete = state.messageResponse
            .indexWhere((element) => element.idMessage == idMessage);

        if (indexToDelete != -1) {
          // Remove the deleted message from the list
          var newMessages = List<ElaraResponse>.from(state.messageResponse);
          newMessages.removeAt(indexToDelete);

          // Check if the deleted message is a user message
          if (indexToDelete > 0 &&
              state.messageResponse[indexToDelete - 1].isUserMessage) {
            // If it's a user message, delete it
            newMessages.removeAt(indexToDelete - 1);
          } else if (indexToDelete < state.messageResponse.length - 1 &&
              !state.messageResponse[indexToDelete + 1].isUserMessage) {
            // If it's an AI response, and there's a user message after it, delete it
            newMessages.removeAt(indexToDelete + 1);
          }

          state = state.copyWith(
            isLoading: false,
            messageResponse: newMessages,
            isDeleteChat: false,
            isContextualAppBarEnabled: false,
          );
        } else {
          state = state.copyWith(
            isLoading: false,
            error: 'Message not found',
            isDeleteChat: false,
          );
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result.errorMessage ?? 'An error occurred',
          isDeleteChat: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An error occurred',
        isDeleteChat: false,
      );
    }
  }

  Future<void> editChat(String idMessage, String messageText) async {
    try {
      state = state.copyWith(isLoading: true);

      final usecase = ref.read(useCaseAssistantProvider);

      var result = await usecase.editChat(
          chatRoomId: _chatRoomId!,
          idMessage: idMessage,
          messageText: messageText);

      if (result is Success) {
        // Find the index of the message to be edited
        final indexToEdit = state.messageResponse.indexWhere((element) =>
            element.idMessage == idMessage && element.isUserMessage == false);

        if (indexToEdit != -1) {
          // Update the message with the new text
          var newMessages = List<ElaraResponse>.from(state.messageResponse);
          newMessages[indexToEdit] = newMessages[indexToEdit].copyWith(
              message: result.resultData!.message, isUserMessage: false);

          // i want to update the user message also
          if (indexToEdit > 0 &&
              state.messageResponse[indexToEdit - 1].isUserMessage) {
            final oldUserMessage =
                state.messageResponse[indexToEdit - 1].message;
            final newUserMessageIds = Map<String, String>.from(
                state.userMessageIds)
              ..remove(oldUserMessage) // Remove the old entry
              ..[messageText] =
                  idMessage; // Add the new entry with the updated message text

            newMessages[indexToEdit - 1] =
                newMessages[indexToEdit - 1].copyWith(
              message: messageText,
              isUserMessage: true,
            );
            state = state.copyWith(
              isLoading: false,
              messageResponse: newMessages,
              userMessageIds: newUserMessageIds,
              isContextualAppBarEnabled: false,
            );
          } else {
            state = state.copyWith(
              isLoading: false,
              messageResponse: newMessages,
              isContextualAppBarEnabled: false,
            );
          }
        } else {
          state = state.copyWith(
            isLoading: false,
            error: 'Message not found',
          );
        }
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

  Future<void> fetchChatHistory() async {
    try {
      state = state.copyWith(isLoading: true);

      final useCase = ref.read(useCaseAssistantProvider);

      var result = await useCase.getDetailChatRoom(chatRoomId: _chatRoomId!);

      if (result is Success) {
        List<ElaraResponse> chatHistory = result.resultData!;
        Map<String, String> newUserMessageIds = {};

        // Iterate through the chat history to populate newUserMessageIds
        for (var message in chatHistory) {
          if (message.isUserMessage) {
            // Assuming each message object has a 'text' and 'idMessage' property
            newUserMessageIds[message.message] = message.idMessage;
          }
        }

        state = state.copyWith(
          isLoading: false,
          messageResponse: chatHistory,
          userMessageIds: newUserMessageIds, // Update the userMessageIds state
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result.errorMessage ?? 'An error occurred',
          messageResponse: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An error occurred',
        messageResponse: null,
      );
    }
  }

  void enableContextualAppBar(String idMessage, String userMessage) {
    state = state.copyWith(
      isContextualAppBarEnabled: true,
      selectedMessageId: idMessage,
      selectedUserMessage: userMessage,
    );
  }

  void disableContextualAppBar() {
    state = state.copyWith(
      isContextualAppBarEnabled: false,
      selectedMessageId: '',
      selectedUserMessage: '',
    );
  }

  void highlightMessage(String idMessage) {
    state = state.copyWith(highlightedMessageId: idMessage);
  }

  void clearMessageHighlight() {
    state = state.copyWith(highlightedMessageId: '');
  }

  @override
  void dispose() {
    speechToText.stop();
    speechToText.cancel();
    super.dispose();
  }
}

final grammarTalkChatStateNotifierProvider =
    StateNotifierProvider<GrammarTalkChatStateNotifier, GrammarTalkChatState>(
        (ref) => GrammarTalkChatStateNotifier(ref));
