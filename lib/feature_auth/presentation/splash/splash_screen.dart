import 'package:cached_network_image/cached_network_image.dart';
import 'package:elarise/feature_auth/presentation/splash/splash_state.dart';
import 'package:elarise/feature_auth/presentation/splash/splash_state_notifier.dart';
import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../router/router_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<SplashState>(splashStateNotifierProvider, (previous, next) {
      if (next.userPreferences != null && !next.isLoading) {
        if (next.userPreferences?.photoProfile != null) {
          precacheImage(
              CachedNetworkImageProvider(
                next.userPreferences!.photoProfile!,
              ),
              context);
        }
        ref.read(routerProvider).goNamed('home');
      } else if (next.error != null && next.error != "User not found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.error.toString()),
        ));
      }
    });

    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_splash.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Adjusted to min to wrap content
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/elarise_logo.png',
                    width: 186,
                    height: 186,
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  Text(
                    'Elarise',
                    style: getGrotesqueSemiBoldStyle72(color: neutralFour),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 106.0),
                child: Text(
                  'Shine Brightly in Your Speech \nLike The Stars',
                  style: getSansFranciscoMedium20(color: silverFoil),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ])),
    );
  }
}
