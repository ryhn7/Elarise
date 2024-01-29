import 'package:elarise/feature_account_setting/presentation/account_setting/widget/option.dart';
import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';

class AccountSettingScreen extends StatelessWidget {
  const AccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget appBar() {
      return AppBar(
        backgroundColor: neutralOneAlt,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: neutralFour),
          onPressed: () {
            Navigator.pop(context);
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
      return const Column(
        children: [
          Option(title: "Change password"),
          SizedBox(height: 24),
          Option(title: "Manage account"),
          SizedBox(height: 24),
          Option(
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
