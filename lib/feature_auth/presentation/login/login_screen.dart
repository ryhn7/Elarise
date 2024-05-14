import 'dart:developer';

import 'package:elarise/feature_auth/presentation/login/login_state.dart';
import 'package:elarise/feature_auth/presentation/login/login_state_notifier.dart';
import 'package:elarise/feature_auth/presentation/widget/elaris_auth_button.dart';
import 'package:elarise/feature_auth/presentation/widget/elarise_auth_textfield.dart';
import 'package:elarise/feature_auth/presentation/widget/google_auth_button.dart';
import 'package:elarise/router/router_provider.dart';
import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/global/global_state_notifier.dart';

class LoginScreen extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<LoginState>(loginStateNotifierProvider, (_, state) {
      if (state.user != null) {
        ref.read(routerProvider).goNamed('home');
      } else if (state.error != null) {
        if (ModalRoute.of(context)!.isCurrent) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Check your email and password, then try again."),
            duration: Duration(seconds: 2),
          ));
        }
      }
    });

    final loginState = ref.watch(loginStateNotifierProvider);

    Widget buildHeader() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/images/elarise_logo.png", width: 64, height: 64),
          const SizedBox(height: 24),
          Text(
            "Login to your account",
            style: getGrotesqueSemiBoldStyle40(color: neutralFour),
          ),
          Row(
            children: [
              Text(
                "Don't have an account?",
                style: getSansFranciscoRegular16(color: darkSilver),
              ),
              TextButton(
                  onPressed: () {
                    ref.read(loginStateNotifierProvider.notifier).clearState();
                    ref.read(routerProvider).goNamed('signup');
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: primary,
                  ),
                  child: Text(
                    "Sign Up",
                    style: getSansFranciscoSemiBold16(color: primary),
                  )),
            ],
          )
        ],
      );
    }

    // Widget buildForgotPasswordButton() {
    //   return Align(
    //     alignment: Alignment.centerRight,
    //     child: TextButton(
    //       onPressed: () {},
    //       style: TextButton.styleFrom(
    //         foregroundColor: primary,
    //       ),
    //       child: Text(
    //         "Forgot Password?",
    //         style: getSansFranciscoSemiBold16(color: primary),
    //       ),
    //     ),
    //   );
    // }

    Widget buildDividerLoginAlternate() {
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
                labelText: 'Email',
                controller: emailController,
                isEmail: true,
              ),
              const SizedBox(height: 24),
              ElariseAuthTextfield(
                  labelText: 'Password',
                  controller: passwordController,
                  obsecureText: true),
              // buildForgotPasswordButton(),
              const SizedBox(height: 52),
              ElariseAuthButton(
                labelText: loginState.isLoading ? "" : "Login",
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
                        ref.read(loginStateNotifierProvider.notifier).login(
                            email: emailController.text,
                            password: passwordController.text);
                      }
                    }).catchError((error) {
                      // Handle any errors that occur during the connectivity check
                      log('Error checking internet connection: $error');
                    });
                  }
                },
                isLoading: loginState.isLoading,
              ),
              const SizedBox(height: 32),
              buildDividerLoginAlternate(),
              const SizedBox(height: 32),
              GoogleAuthButton(
                onPressed: () {
                  ref
                      .read(loginStateNotifierProvider.notifier)
                      .continueWithGoogle();
                },
                continueWithGoogleLoading: loginState.continueWithGoogleLoading,
              )
            ],
          ),
        ),
      )),
    );
  }
}
