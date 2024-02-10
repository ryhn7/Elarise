import 'dart:developer';

import 'package:elarise/di/repositories/user_datastore_repository/user_datastore_repository_provider.dart';
import 'package:elarise/feature_assistant/presentation/home/widget/chatroom_card.dart';
import 'package:elarise/router/router_provider.dart';
import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/entities/user_preferences.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<UserPreferences?>(
      future: ref.read(userDatastoreRepositoryProvider).getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data?.token != null) {
          // User is logged in, continue showing HomeScreen
          return homeScreenContent(context, ref, snapshot.data!);
        } else {
          // No valid session, redirect to SignInScreen
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(routerProvider).goNamed('login');
          });
          return const SizedBox
              .shrink(); // Return an empty widget or a loading indicator as needed
        }
      },
    );
  }

  Widget homeScreenContent(
      BuildContext context, WidgetRef ref, UserPreferences userPreferences) {
    final userName = userPreferences.name ?? "User";
    final photoUrl = userPreferences.photoProfile;
    // final token = userPreferences.token;
    // log("Token: $token");

    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello, $userName",
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
                    child: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(photoUrl ??
                                "https://firebasestorage.googleapis.com/v0/b/conversation-app-e3566.appspot.com/o/profileImage%2Fuser_placeholder.png?alt=media&token=b59b54f9-84c0-47e0-a900-60bfa9b05ae9"),
                            fit: BoxFit.cover,
                          ),
                        ))),
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
