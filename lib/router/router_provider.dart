import 'package:elarise/feature_account_setting/presentation/account_setting/account_setting_screen.dart';
import 'package:elarise/feature_account_setting/presentation/account_setting/manage_account_screen.dart';
import 'package:elarise/feature_assistant/presentation/home/home_screen.dart';
import 'package:elarise/feature_auth/presentation/login/login_screen.dart';
import 'package:elarise/feature_auth/presentation/signup/signup_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) => GoRouter(routes: [
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
    ], initialLocation: '/login', debugLogDiagnostics: false);