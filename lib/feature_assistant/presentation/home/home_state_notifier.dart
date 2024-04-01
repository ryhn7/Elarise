import 'package:elarise/di/repositories/user_datastore_repository/user_datastore_repository_provider.dart';
import 'package:elarise/feature_assistant/presentation/home/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/result_state.dart';
import '../../../di/usecases/assistant_usecases/usecase_assistant_provider.dart';
import '../../../router/router_provider.dart';

class HomeStateNotifier extends StateNotifier<HomeState> {
  final Ref ref;

  HomeStateNotifier(this.ref) : super(HomeState()) {
    _loadUserPreferences();
    getAllFreelyTalkRooms();
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

  Future<void> createFreelyTalkRoom() async {
    try {
      state = state.copyWith(isLoading: true, isCreatingRoom: true);

      final useCase = ref.read(useCaseAssistantProvider);

      var result = await useCase.createFreelyTalkRoom();

      if (result is Success) {
        state = state.copyWith(
          isLoading: false,
          isCreatingRoom: false,
          chatRoomResponse: result.resultData,
        );
        // log("ChatRoom created successfully: ${result.resultData}");
        ref.read(routerProvider).goNamed(
              'talk-freely',
              extra: result.resultData?.chatRoomId,
            );
      } else {
        state = state.copyWith(
          isLoading: false,
          isCreatingRoom: false,
          error: result.errorMessage ?? 'An error occurred',
          chatRoomResponse: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false,
          isCreatingRoom: false,
          error: e.toString(),
          chatRoomResponse: null);
    }
  }

  Future<void> createGrammarTalkRoom() async {
    try {
      state = state.copyWith(isLoading: true, isCreatingRoom: true);

      final useCase = ref.read(useCaseAssistantProvider);

      var result = await useCase.createGrammarTalkRoom();

      if (result is Success) {
        state = state.copyWith(
          isLoading: false,
          isCreatingRoom: false,
          chatRoomResponse: result.resultData,
        );
        // log("ChatRoom created successfully: ${result.resultData}");
        ref.read(routerProvider).goNamed(
              'grammar-talk',
              extra: result.resultData?.chatRoomId,
            );
      } else {
        state = state.copyWith(
          isLoading: false,
          isCreatingRoom: false,
          error: result.errorMessage ?? 'An error occurred',
          chatRoomResponse: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false,
          isCreatingRoom: false,
          error: e.toString(),
          chatRoomResponse: null);
    }
  }

  Future<void> getAllFreelyTalkRooms() async {
    try {
      state = state.copyWith(isLoading: true, isChatRoomLoading: true);

      final useCase = ref.read(useCaseAssistantProvider);

      var result = await useCase.getAllFreelyTalkRooms();

      if (result is Success) {
        state = state.copyWith(
          isLoading: false,
          isChatRoomLoading: false,
          chatRooms: result.resultData,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          isChatRoomLoading: false,
          error: result.errorMessage ?? 'An error occurred',
          chatRooms: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false,
          error: e.toString(),
          chatRooms: null,
          isChatRoomLoading: false);
    }
  }

  Future<void> getAllGrammarTalkRooms() async {
    try {
      state = state.copyWith(isLoading: true, isChatRoomLoading: true);

      final useCase = ref.read(useCaseAssistantProvider);

      var result = await useCase.getAllGrammarTalkRooms();

      if (result is Success) {
        state = state.copyWith(
          isLoading: false,
          isChatRoomLoading: false,
          chatRooms: result.resultData,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          isChatRoomLoading: false,
          error: result.errorMessage ?? 'An error occurred',
          chatRooms: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false,
          error: e.toString(),
          chatRooms: null,
          isChatRoomLoading: false);
    }
  }

  Future<void> renameChatRoomName(
      String chatRoomId, String chatRoomName) async {
    try {
      state = state.copyWith(isLoading: true, isRenamingChatRoomName: true);

      final useCase = ref.read(useCaseAssistantProvider);

      var result = await useCase.editChatRoom(
          chatRoomId: chatRoomId, chatRoomName: chatRoomName);

      if (result is Success) {
        state = state.copyWith(
          isLoading: false,
          isRenamingChatRoomName: false,
          chatRoomResponse: result.resultData,
        );

        if (result.resultData?.type == 'voice') {
          await getAllFreelyTalkRooms();
        } else if (result.resultData?.type == 'Text') {
          await getAllGrammarTalkRooms();
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          isRenamingChatRoomName: false,
          error: result.errorMessage ?? 'An error occurred',
          chatRoomResponse: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false,
          error: e.toString(),
          chatRoomResponse: null,
          isRenamingChatRoomName: false);
    }
  }

  Future<void> deleteChatRoom(String chatRoomId) async {
    try {
      state = state.copyWith(isLoading: true, isDeletingChatRoom: true);

      final useCase = ref.read(useCaseAssistantProvider);

      var result = await useCase.deleteChatRoom(chatRoomId: chatRoomId);

      if (result is Success) {
        state = state.copyWith(
          isLoading: false,
          isDeletingChatRoom: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          isDeletingChatRoom: false,
          error: result.errorMessage ?? 'An error occurred',
        );
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false, error: e.toString(), isDeletingChatRoom: false);
    }
  }

  void clearChatRoomHistory() {
    state = state.copyWith(chatRooms: []);
  }
}

final homeStateNotifierProvider =
    StateNotifierProvider<HomeStateNotifier, HomeState>((ref) {
  return HomeStateNotifier(ref);
});
