import 'package:elarise/core/global/global_state.dart';
import 'package:elarise/feature_assistant/presentation/grammar_talk_chatroom/grammar_talk_chat_state_notifier.dart';
import 'package:elarise/feature_assistant/presentation/home/home_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/repositories/user_datastore_repository/user_datastore_repository_provider.dart';
import '../../router/router_provider.dart';
import '../utils/network_util.dart';

class GlobalStateNotifier extends StateNotifier<GlobalState> {
  final Ref ref;
  String? _routeName;
  String? _chatRoomId;

  GlobalStateNotifier(this.ref) : super(GlobalState()) {
    _loadUserPreferences();
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

  Future<void> checkInternetConnection() async {
    final isOnline = await NetworkUtil().isInternetAvailable();
    if (!isOnline) {
      // Set a state indicating no internet connection
      state = state.copyWith(hasInternetConnection: false);
    } else {
      state = state.copyWith(hasInternetConnection: true);
    }
  }

  Future<void> setInternetConnection(bool hasInternetConnection) async {
    state = state.copyWith(hasInternetConnection: hasInternetConnection);
  }

  set routeName(String routeName) {
    _routeName = routeName;
  }

  set chatRoomId(String chatRoomId) {
    _chatRoomId = chatRoomId;
  }

  // method go to the previous route
  void goBack() {
    if (_routeName != null) {
      if (_routeName == 'home') {
        ref.read(homeStateNotifierProvider.notifier).getAllFreelyTalkRooms();
        ref.read(routerProvider).goNamed(_routeName!);
      } else if (_routeName == 'grammar-talk-detail' && _chatRoomId != null) {
        ref
            .read(grammarTalkChatStateNotifierProvider.notifier)
            .fetchChatHistory();
        ref.read(routerProvider).goNamed(_routeName!, extra: _chatRoomId);
      } else if (_routeName == 'talk-freely-detail' && _chatRoomId != null) {
        ref
            .read(grammarTalkChatStateNotifierProvider.notifier)
            .fetchChatHistory();
        ref.read(routerProvider).goNamed(_routeName!, extra: _chatRoomId);
      }
    }
  }
}

final globalStateNotifierProvider =
    StateNotifierProvider<GlobalStateNotifier, GlobalState>((ref) {
  return GlobalStateNotifier(ref);
});
