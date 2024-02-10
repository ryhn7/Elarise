import 'package:elarise/feature_account_setting/presentation/account_setting/setting_state.dart';
import 'package:elarise/feature_account_setting/presentation/account_setting/setting_state_notifier.dart';
import 'package:elarise/feature_account_setting/presentation/account_setting/widget/option.dart';
import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../router/router_provider.dart';

class ManageAccountScreen extends ConsumerWidget {
  const ManageAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SettingState>(settingStateProvider, (previous, next) {
      if (previous != null &&
          previous.firebaseUser != null &&
          next.isLogout &&
          next.firebaseUser == null) {
        ref.read(routerProvider).goNamed('login');
      }
    });

    Widget appBar() {
      return AppBar(
        backgroundColor: neutralOneAlt,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: neutralFour),
          onPressed: () {
            ref.read(routerProvider).goNamed('setting');
          },
        ),
        title: Text("Manage account",
            style: getSansFranciscoSemiBold20(color: neutralFour)),
      );
    }

    Widget options() {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                ref.read(settingStateProvider.notifier).logout();
              },
              child: const Option(
                title: "Log out",
                subtitle:
                    "Are you sure? You'll have to log in again once you're back.",
              ),
            ),
            const SizedBox(height: 24),
            const Option(
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
