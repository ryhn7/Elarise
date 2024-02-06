import 'package:elarise/feature_assistant/presentation/home/home_state.dart';
import 'package:elarise/feature_assistant/presentation/home/home_state_notifier.dart';
import 'package:elarise/feature_assistant/presentation/home/widget/chatroom_card.dart';
import 'package:elarise/router/router_provider.dart';
import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen<HomeState>(homeStateNotifierProvider, (previous, next) {
      if (next.user == null && next.error == null) {
        ref.read(routerProvider).goNamed('login');
      }
    });

    final homeState = ref.watch(homeStateNotifierProvider);

    if (homeState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (homeState.error != null) {
      return Center(
        child: Text(homeState.error.toString()),
      );
    } else {
      Widget header() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello, ${homeState.user?.username ?? "User"}",
                      style: getGrotesqueSemiBoldStyle24(color: neutralFour)),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    "Let's see what can i do for you",
                    style: getSansFranciscoRegular14(color: neutralThree),
                  )
                ],
              ),
              InkWell(
                  onTap: () {
                    ref.read(routerProvider).goNamed('setting');
                  },
                  child: Image.asset("assets/images/dummy_avatar.png",
                      width: 50, height: 50)),
            ]),
            const SizedBox(
              height: 24.0,
            ),
            Text(
              "Start a new chat with",
              style: getGrotesqueSemiBoldStyle40(color: neutralFour),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: <Color>[
                        Color(0xFFffcf00), // primary color
                        Color(0xFFE8A089), // tumbleweed color
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode
                      .srcIn, // This blend mode applies the gradient only to the text
                  child: Text(
                    "Elara AI",
                    style: getGrotesqueSemiBoldStyle40(
                        color: Colors.white), // Temporarily set to white
                  ),
                ),
                SizedBox(
                  width: 156,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(36),
                            bottomLeft: Radius.circular(36),
                            topRight: Radius.circular(36),
                            bottomRight: Radius.circular(8),
                          ))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.add,
                            size: 24,
                            color: neutralFour,
                          ),
                          Text(
                            "New Topic",
                            style: getSansFranciscoBold16(color: neutralFour),
                          ),
                        ],
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 32.0,
            ),
            Row(
              children: [
                Flexible(
                  child: Divider(
                    color: neutralThree30,
                    height: 1,
                    thickness: 1,
                  ),
                ),
              ],
            ),
          ],
        );
      }

      Widget history() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24.0,
            ),
            Text("History",
                style: getSansFranciscoSemiBold24(color: neutralFour)),
            const SizedBox(
              height: 24.0,
            ),
            const Row(
              children: [
                ChatRoomCard(),
                SizedBox(
                  width: 8.0,
                ),
                ChatRoomCard(),
              ],
            )
          ],
        );
      }

      return Scaffold(
          backgroundColor: neutralOneAlt,
          body: SafeArea(
              child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [header(), history()],
            ),
          )));
    }
  }
}
