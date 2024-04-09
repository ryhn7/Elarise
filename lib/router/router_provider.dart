import 'package:elarise/core/data/remote/api_config.dart';
import 'package:elarise/core/presentation/error/error_screen.dart';
import 'package:elarise/core/presentation/error/network_error_screen.dart';
import 'package:elarise/feature_account_setting/presentation/account_setting/change_password/change_password_screen.dart';
import 'package:elarise/feature_account_setting/presentation/account_setting/edit_profile/edit_profile_screen.dart';
import 'package:elarise/feature_account_setting/presentation/account_setting/manage_account/manage_account_screen.dart';
import 'package:elarise/feature_account_setting/presentation/account_setting/settings/account_setting_screen.dart';
import 'package:elarise/feature_assistant/presentation/freely_talk_chatroom/freely_talk_chatroom_screen.dart';
import 'package:elarise/feature_assistant/presentation/grammar_talk_chatroom/grammar_talk_chatroom_screen.dart';
import 'package:elarise/feature_assistant/presentation/home/home_screen.dart';
import 'package:elarise/feature_auth/presentation/login/login_screen.dart';
import 'package:elarise/feature_auth/presentation/signup/signup_screen.dart';
import 'package:elarise/feature_auth/presentation/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) => GoRouter(
        routes: [
          GoRoute(
              path: '/',
              name: 'splash',
              builder: (context, state) => const SplashScreen()),
          GoRoute(
              path: '/home',
              name: 'home',
              builder: (context, state) => const HomeScreen()),
          GoRoute(
              path: '/login',
              name: 'login',
              builder: (context, state) => LoginScreen()),
          GoRoute(
              path: '/signup',
              name: 'signup',
              builder: (context, state) => SignUpScreen()),
          GoRoute(
              path: '/setting',
              name: 'setting',
              builder: (context, state) => const AccountSettingScreen()),
          GoRoute(
              path: '/manage-account',
              name: 'manage-account',
              builder: (context, state) => const ManageAccountScreen()),
          GoRoute(
              path: '/edit-profile',
              name: 'edit-profile',
              builder: (context, state) => const EditProfileScreen()),
          GoRoute(
              path: '/talk-freely',
              name: 'talk-freely',
              builder: (context, state) {
                final chatRoomId = state.extra as String;
                return FreelyTalkChatroomScreen(chatRoomId,
                    isNewChatRoom: true);
              }),
          GoRoute(
              path: '/grammar-talk',
              name: 'grammar-talk',
              builder: (context, state) {
                final chatRoomId = state.extra as String;
                return GrammarTalkChatroomScreen(chatRoomId,
                    isNewChatRoom: true);
              }),
          GoRoute(
              path: '/talk-freely-detail',
              name: 'talk-freely-detail',
              builder: (context, state) {
                final chatRoomId = state.extra as String;
                return FreelyTalkChatroomScreen(chatRoomId);
              }),
          GoRoute(
              path: '/grammar-talk-detail',
              name: 'grammar-talk-detail',
              builder: (context, state) {
                final chatRoomId = state.extra as String;
                return GrammarTalkChatroomScreen(chatRoomId);
              }),
          GoRoute(
              path: '/change-password',
              name: 'change-password',
              builder: (context, state) => const ChangePasswordScreen()),
          GoRoute(
              path: '/network-error',
              name: 'network-error',
              builder: (context, state) {
                // Extracting the routeName and chatRoomId from extras
                final extras = state.extra as Map<String, dynamic>? ?? {};
                final routeName = extras['routeName'] as String? ??
                    'defaultRouteName'; // Use a default or handle null
                final chatRoomId = extras['chatRoomId'] as String?;

                return NetworkErrorScreen(
                    routeName: routeName, chatRoomId: chatRoomId);
              }),
          GoRoute(
              path: '/common-error',
              name: 'common-error',
              builder: (context, state) => const ErrorScreen()),
        ],
        initialLocation: '/',
        debugLogDiagnostics: false,
        navigatorKey: navigatorKey);
