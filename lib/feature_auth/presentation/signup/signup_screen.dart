import 'dart:developer';

import 'package:elarise/feature_auth/presentation/signup/signup_state.dart';
import 'package:elarise/feature_auth/presentation/signup/signup_state_notifier.dart';
import 'package:elarise/feature_auth/presentation/widget/elaris_auth_button.dart';
import 'package:elarise/feature_auth/presentation/widget/elarise_auth_textfield.dart';
import 'package:elarise/feature_auth/presentation/widget/google_auth_button.dart';
import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/global/global_state_notifier.dart';
import '../../../router/router_provider.dart';

class SignUpScreen extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignUpState>(signUpStateNotifierProvider, (_, state) {
      if (state.user != null) {
        ref.read(routerProvider).goNamed('home');
      } else if (state.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error.toString()),
          duration: const Duration(seconds: 2),
        ));
      }
    });

    final signUpState = ref.watch(signUpStateNotifierProvider);

    Widget buildHeader() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/images/elarise_logo.png", width: 64, height: 64),
          const SizedBox(height: 24),
          Text(
            "Create your account",
            style: getGrotesqueSemiBoldStyle40(color: neutralFour),
          ),
          Row(
            children: [
              Text(
                "Already have an account?",
                style: getSansFranciscoRegular16(color: darkSilver),
              ),
              TextButton(
                  onPressed: () {
                    ref.read(signUpStateNotifierProvider.notifier).clearState();
                    ref.read(routerProvider).goNamed('login');
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: primary,
                  ),
                  child: Text(
                    "Login",
                    style: getSansFranciscoSemiBold16(color: primary),
                  )),
            ],
          )
        ],
      );
    }

    Widget buildDividerSignUpAlternate() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Divider(
              color: neutralThree30,
              height: 1,
              thickness: 1,
              indent: 16,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            "Or",
            style: getSansFranciscoRegular14(color: neutralThree),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Divider(
              color: neutralThree30,
              height: 1,
              thickness: 1,
              endIndent: 16,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: neutralOneAlt,
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildHeader(),
              const SizedBox(height: 40),
              ElariseAuthTextfield(
                  labelText: 'Name', controller: nameController),
              const SizedBox(height: 24),
              ElariseAuthTextfield(
                labelText: 'Email',
                controller: emailController,
                isEmail: true,
              ),
              const SizedBox(height: 24),
              ElariseAuthTextfield(
                  labelText: 'Password',
                  controller: passwordController,
                  obsecureText: true),
              const SizedBox(height: 48),
              ElariseAuthButton(
                labelText: signUpState.isLoading ? "." : "Sign Up",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Check connectivity before attempting to log in
                    ref
                        .read(globalStateNotifierProvider.notifier)
                        .checkInternetConnection()
                        .then((_) {
                      final globalState = ref.read(globalStateNotifierProvider);
                      if (globalState.hasInternetConnection == false) {
                        // If not connected, show snackbar
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              'Are you offline? Check your internet connection, then try again.'),
                          duration: Duration(seconds: 1),
                        ));
                      } else {
                        // If connected, proceed with login
                        ref.read(signUpStateNotifierProvider.notifier).signup(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text);
                      }
                    }).catchError((error) {
                      // Handle any errors that occur during the connectivity check
                      log('Error checking internet connection: $error');
                    });
                  }
                },
                isLoading: signUpState.isLoading,
              ),
              const SizedBox(height: 32),
              buildDividerSignUpAlternate(),
              const SizedBox(height: 32),
              GoogleAuthButton(
                onPressed: () {
                  ref
                      .read(signUpStateNotifierProvider.notifier)
                      .continueWithGoogle();
                },
                continueWithGoogleLoading:
                    signUpState.continueWithGoogleLoading,
              )
            ],
          ),
        ),
      )),
    );
  }
}
