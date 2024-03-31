import 'package:elarise/feature_account_setting/presentation/account_setting/manage_account/account_state.dart';
import 'package:elarise/feature_account_setting/presentation/account_setting/manage_account/account_state_notifier.dart';
import 'package:elarise/feature_account_setting/presentation/account_setting/widget/option.dart';
import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../router/router_provider.dart';

class ManageAccountScreen extends ConsumerStatefulWidget {
  const ManageAccountScreen({super.key});

  @override
  ConsumerState<ManageAccountScreen> createState() =>
      _ManageAccountScreenState();
}

class _ManageAccountScreenState extends ConsumerState<ManageAccountScreen> {
  void _showDeleteAccountConfirmation(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: neutralOneAlt,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              // Dialog box radius
            ),
            title: Text(
              "Delete account",
              style: getSansFranciscoBold20(color: earieBlack),
            ),
            content: Text(
                "Your account will be deleted permanently. This action cannot be undone.",
                style: getSansFranciscoMedium16(
                    color: earieBlack.withOpacity(0.7))),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel",
                    style: getSansFranciscoMedium16(color: earieBlack)),
              ),
              TextButton(
                onPressed: () {
                  ref
                      .read(accountStateNotifierProvider.notifier)
                      .deleteAccount();
                  ref.read(routerProvider).goNamed('login');
                },
                child:
                    Text("Delete", style: getSansFranciscoMedium16(color: red)),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AccountState>(accountStateNotifierProvider, (previous, next) {
      if (previous != null &&
          previous.firebaseUser != null &&
          next.isLogout &&
          next.firebaseUser == null) {
        ref.read(routerProvider).goNamed('login');
      }
    });

    PreferredSizeWidget appBar() {
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
                ref.read(accountStateNotifierProvider.notifier).logout();
              },
              child: const Option(
                title: "Log out",
                subtitle:
                    "Are you sure? You'll have to log in again once you're back.",
              ),
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: () => _showDeleteAccountConfirmation(context),
              child: const Option(
                title: "Delete account",
                subtitle:
                    "Your account will be deleted permanently. This action cannot be undone.",
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: neutralOneAlt,
      appBar: appBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const SizedBox(height: 16), options()],
        ),
      ),
    );
  }
}
