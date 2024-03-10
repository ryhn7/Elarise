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
          chatRoomVoiceResponse: result.resultData,
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
          chatRoomVoiceResponse: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false,
          isCreatingRoom: false,
          error: e.toString(),
          chatRoomVoiceResponse: null);
    }
  }

  Future<void> getAllFreelyTalkRooms() async {
    try {
      state = state.copyWith(isLoading: true, isChatRoomLoading: true);

      // await Future.delayed(const Duration(seconds: 5));

      final useCase = ref.read(useCaseAssistantProvider);

      var result = await useCase.getAllFreelyTalkRooms();

      if (result is Success) {
        state = state.copyWith(
          isLoading: false,
          isChatRoomLoading: false,
          freelyTalkRooms: result.resultData,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          isChatRoomLoading: false,
          error: result.errorMessage ?? 'An error occurred',
          freelyTalkRooms: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false,
          error: e.toString(),
          freelyTalkRooms: null,
          isChatRoomLoading: false);
    }
  }
}

final homeStateNotifierProvider =
    StateNotifierProvider<HomeStateNotifier, HomeState>((ref) {
  return HomeStateNotifier(ref);
});
