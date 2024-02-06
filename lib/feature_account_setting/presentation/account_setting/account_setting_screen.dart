import 'package:elarise/feature_account_setting/presentation/account_setting/widget/option.dart';
import 'package:elarise/router/router_provider.dart';
import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountSettingScreen extends ConsumerWidget {
  const AccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            Image.asset("assets/images/dummy_avatar.png",
                width: 80, height: 80),
            const SizedBox(height: 16),
            Text("Anthony Adams",
                style: getSansFranciscoBold24(color: neutralFour)),
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
          const SizedBox(height: 24),
          InkWell(
              onTap: () {
                ref.read(routerProvider).goNamed('manage-account');
              },
              child: const Option(title: "Manage account")),
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
