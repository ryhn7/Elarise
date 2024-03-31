import 'package:elarise/feature_account_setting/presentation/account_setting/change_password/change_password_state.dart';
import 'package:elarise/feature_account_setting/presentation/account_setting/change_password/change_password_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/global/global_state_notifier.dart';
import '../../../../router/router_provider.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/style.dart';
import '../manage_account/account_state_notifier.dart';
import '../widget/elarise_password_edit_textfield.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isUpdateInProgress = false;

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Successful',
            style: getSansFranciscoSemiBold16(color: ufoGreen)),
        content: Text('Password updated successfully.',
            style: getSansFranciscoRegular14(color: neutralFour)),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                if (!mounted) return;
                ref.read(routerProvider).goNamed('setting');
              },
              child: Text('OKAY',
                  style: getSansFranciscoSemiBold14(color: neutralFour))),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Failed',
            style: getSansFranciscoSemiBold16(color: red)),
        content: Text(
            'The current password you entered is incorrect. Please try again.',
            style: getSansFranciscoRegular14(color: neutralFour)),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                if (!mounted) return;
                Navigator.pop(context);
              },
              child: Text('OKAY',
                  style: getSansFranciscoSemiBold14(color: neutralFour))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen to ChangePasswordState changes
    ref.listen<ChangePasswordState>(
      changePasswordStateNotifierProvider,
      (previous, next) { 
        setState(() {
          // Set isUpdateInProgress to true only when loading begins
          isUpdateInProgress = next.isLoading;
        });

        if (!next.isLoading) {
          if (next.isPasswordChanged) {
            _showSuccessDialog(context);
          } else if (next.error != null) {
            _showErrorDialog(context);
          }
        }
      },
    );

    final globalState = ref.watch(globalStateNotifierProvider);

    if (globalState.isLoading) {
      return changePasswordScreenContent(context, ref);
    } else if (globalState.userPreferences != null &&
        globalState.userPreferences!.token != null) {
      return changePasswordScreenContent(context, ref);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(accountStateNotifierProvider.notifier).logout();

        ref.read(routerProvider).goNamed('login');
      });
      return const SizedBox.shrink();
    }
  }

  Widget changePasswordScreenContent(
    BuildContext context,
    WidgetRef ref,
  ) {
    PreferredSizeWidget appBar() {
      return AppBar(
        backgroundColor: neutralOneAlt,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: neutralFour),
          onPressed: () {
            ref.read(changePasswordStateNotifierProvider.notifier).clearState();
            ref.read(routerProvider).goNamed('setting');
          },
        ),
        title: Text("Change Password",
            style: getSansFranciscoSemiBold20(color: neutralFour)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await ref
                      .read(changePasswordStateNotifierProvider.notifier)
                      .updatePassword(
                          currentPassword: currentPasswordController.text,
                          newPassword: newPasswordController.text);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary, // Your primary color
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Adjust for rounded corners
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6), // Adjust padding to control the button size
                minimumSize: const Size(0, 0), // Set minimum size to zero
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: isUpdateInProgress
                  ? SizedBox(
                      width: 28, // Adjust the size to fit your design
                      height: 28, // Adjust the size to fit your design
                      child: CircularProgressIndicator(
                        strokeWidth: 2, // Makes the spinner thinner
                        valueColor: AlwaysStoppedAnimation<Color>(neutralFour),
                      ),
                    )
                  : Text(
                      "Update",
                      style: getSansFranciscoBold16(
                          color: neutralFour), // Your text style
                    ),
            ),
          )
        ],
      );
    }

    Widget passwordField() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          ElarisPasswordTextField(
              labelText: "Current Password",
              controller: currentPasswordController,
              obsecureText: true),
          const SizedBox(height: 40),
          ElarisPasswordTextField(
              labelText: "New Password",
              controller: newPasswordController,
              obsecureText: true),
          const SizedBox(height: 40),
          ElarisPasswordTextField(
              labelText: "Confirm Password",
              controller: confirmPasswordController,
              comparisonController: newPasswordController,
              obsecureText: true),
          const SizedBox(height: 40),
        ],
      );
    }

    return Scaffold(
      backgroundColor: neutralOneAlt,
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(key: _formKey, child: passwordField()),
      ),
    );
  }
}
