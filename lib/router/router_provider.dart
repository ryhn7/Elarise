import 'package:elarise/core/data/remote/api_config.dart';
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
                return FreelyTalkChatroomScreen(chatRoomId);
              }),
          GoRoute(
              path: '/grammar-talk',
              name: 'grammar-talk',
              builder: (context, state) {
                final chatRoomId = state.extra as String;
                return GrammarTalkChatroomScreen(chatRoomId);
              }),
        ],
        initialLocation: '/',
        debugLogDiagnostics: false,
        navigatorKey: navigatorKey);
