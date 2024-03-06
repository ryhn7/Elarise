import 'package:elarise/core/common/result_state.dart';
import 'package:elarise/di/usecases/assistant_usecases/usecase_assistant_provider.dart';
import 'package:elarise/feature_assistant/presentation/assistant_chatroom/freely_talk_chat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/talk_freely_response.dart';

class FreelyTalkChatStateNotifier extends StateNotifier<FreelyTalkChatState> {
  final Ref ref;

  FreelyTalkChatStateNotifier(this.ref) : super(FreelyTalkChatState());

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
}

final freelyTalkChatStateNotifierProvider =
    StateNotifierProvider<FreelyTalkChatStateNotifier, FreelyTalkChatState>(
        (ref) => FreelyTalkChatStateNotifier(ref));
