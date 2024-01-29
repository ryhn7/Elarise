import 'package:elarise/feature_account_setting/presentation/account_setting/widget/option.dart';
import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';

class ManageAccountScreen extends StatelessWidget {
  const ManageAccountScreen({super.key});

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
        title: Text("Manage account",
            style: getSansFranciscoSemiBold20(color: neutralFour)),
      );
    }

    Widget options() {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Option(
              title: "Log out",
              subtitle:
                  "Are you sure? You'll have to log in again once you're back.",
            ),
            SizedBox(height: 24),
            Option(
              title: "Delete account",
              subtitle:
                  "Your account will be deleted permanently. This action cannot be undone.",
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: neutralOneAlt,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [appBar(), const SizedBox(height: 16), options()],
        ),
      ),
    );
  }
}
