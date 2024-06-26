import 'package:cached_network_image/cached_network_image.dart';
import 'package:elarise/feature_account_setting/presentation/account_setting/settings/setting_state_notifier.dart';
import 'package:elarise/feature_account_setting/presentation/account_setting/widget/option.dart';
import 'package:elarise/router/router_provider.dart';
import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/domain/entities/user_preferences.dart';
import '../manage_account/account_state_notifier.dart';

class AccountSettingScreen extends ConsumerWidget {
  const AccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Triggering user preferences load or refresh
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(settingStateNotifierProvider.notifier).refreshUserPreferences();
    });

    final settingState = ref.watch(settingStateNotifierProvider);

    if (settingState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (settingState.userPreferences != null &&
        settingState.userPreferences!.token != null) {
      // User is logged in, continue showing AccountSettingScreen
      return accountSettingContent(context, ref, settingState.userPreferences!);
    } else {
      // No valid session, redirect to SignInScreen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(accountStateNotifierProvider.notifier).logout();

        ref.read(routerProvider).goNamed('login');
      });
      return const SizedBox
          .shrink(); // Return an empty widget or a loading indicator as needed
    }
  }

  Widget accountSettingContent(
      BuildContext context, WidgetRef ref, UserPreferences userPreferences) {
    final userName = userPreferences.name ?? "User";
    final photoUrl = userPreferences.photoProfile ??
        "https://firebasestorage.googleapis.com/v0/b/elarise-1d057.appspot.com/o/profileImage%2Fuser_placeholder.png?alt=media&token=edfb4a25-2f56-479c-9ed3-f58e90ca8ce5";

    PreferredSizeWidget appBar() {
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
            CachedNetworkImage(
              imageUrl: photoUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 10),
            Text(userName, style: getSansFranciscoBold24(color: neutralFour)),
            const SizedBox(height: 10),
            SizedBox(
              width: 160,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(routerProvider).goNamed('edit-profile');
                },
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
          InkWell(
              onTap: () {
                ref.read(routerProvider).goNamed('change-password');
              },
              child: const Column(
                children: [
                  SizedBox(height: 24),
                  Option(title: "Change password"),
                ],
              )),
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
      appBar: appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    userInformation(),
                    const SizedBox(height: 24),
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
