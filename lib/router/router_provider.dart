import 'package:elarise/feature_assistant/presentation/home/home_screen.dart';
import 'package:elarise/feature_auth/presentation/login/login_screen.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

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
    ], initialLocation: '/login', debugLogDiagnostics: false);
