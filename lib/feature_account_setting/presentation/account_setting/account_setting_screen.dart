import 'package:elarise/feature_account_setting/presentation/account_setting/widget/option.dart';
import 'package:elarise/router/router_provider.dart';
import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/entities/user_preferences.dart';
import '../../../di/repositories/user_datastore_repository/user_datastore_repository_provider.dart';

class AccountSettingScreen extends ConsumerWidget {
  const AccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<UserPreferences?>(
      future: ref.read(userDatastoreRepositoryProvider).getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data?.token != null) {
          // User is logged in, continue showing AccountSettingScreen
          return accountSettingContent(context, ref, snapshot.data!);
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

  Widget accountSettingContent(
      BuildContext context, WidgetRef ref, UserPreferences userPreferences) {
    final userName = userPreferences.name ?? "User";
    final photoUrl = userPreferences.photoProfile;

    Widget appBar() {
      return AppBar(
        backgroundColor: neutralOneAlt,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: neutralFour),
          onPressed: () {
            ref.read(routerProvider).goNamed('home');
          },
        ),
        title: Text("Profile & Settings",
            style: getSansFranciscoSemiBold20(color: neutralFour)),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert, color: neutralFour)),
        ],
      );
    }

    Widget userInformation() {
      return Center(
        child: Column(
          children: [
            Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(photoUrl ??
                        "https://firebasestorage.googleapis.com/v0/b/conversation-app-e3566.appspot.com/o/profileImage%2Fuser_placeholder.png?alt=media&token=b59b54f9-84c0-47e0-a900-60bfa9b05ae9"),
                    fit: BoxFit.cover,
                  ),
                )),
            const SizedBox(height: 10),
            Text(userName, style: getSansFranciscoBold24(color: neutralFour)),
            const SizedBox(height: 8),
            SizedBox(
              width: 160,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit, color: neutralFour),
                    const SizedBox(width: 8),
                    Text("Edit Profile",
                        style: getSansFranciscoBold16(color: neutralFour)),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget options() {
      return Column(
        children: [
          const Option(title: "Change password"),
          InkWell(
              onTap: () {
                ref.read(routerProvider).goNamed('manage-account');
              },
              child: const Column(
                children: [
                  SizedBox(height: 24),
                  Option(title: "Manage account"),
                ],
              )),
          const SizedBox(height: 24),
          const Option(
            title: "Elarise app",
            information: "v 1.0.0",
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: neutralOneAlt,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    userInformation(),
                    const SizedBox(height: 48),
                    options()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
