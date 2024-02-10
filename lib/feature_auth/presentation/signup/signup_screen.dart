import 'package:elarise/feature_auth/presentation/signup/signup_state.dart';
import 'package:elarise/feature_auth/presentation/signup/signup_state_notifier.dart';
import 'package:elarise/feature_auth/presentation/widget/elaris_auth_button.dart';
import 'package:elarise/feature_auth/presentation/widget/elarise_auth_textfield.dart';
import 'package:elarise/feature_auth/presentation/widget/google_auth_button.dart';
import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../router/router_provider.dart';

class SignUpScreen extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignUpState>(signUpStateNotifierProvider, (previous, next) {
      if (next.user != null) {
        ref.read(routerProvider).goNamed('home');
      } else if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.error.toString()),
        ));
      }
    });

    final signUpState = ref.watch(signUpStateNotifierProvider);

    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/images/dummy_logo_header.png",
              width: 64, height: 64),
          const SizedBox(height: 8),
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

    Widget dividerSignUpAlternate() {
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
            "Or sign up with",
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
        child: Column(
          children: [
            header(),
            const SizedBox(height: 12),
            ElariseAuthTextfield(labelText: 'Name', controller: nameController),
            const SizedBox(height: 24),
            ElariseAuthTextfield(
                labelText: 'Email', controller: emailController),
            const SizedBox(height: 20),
            ElariseAuthTextfield(
                labelText: 'Password',
                controller: passwordController,
                obsecureText: true),
            const SizedBox(height: 24),
            ElariseAuthButton(
              labelText: signUpState.isLoading ? "." : "Sign Up",
              onPressed: () {
                ref.read(signUpStateNotifierProvider.notifier).signup(
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text);
              },
              isLoading: signUpState.isLoading,
            ),
            const SizedBox(height: 24),
            dividerSignUpAlternate(),
            const SizedBox(height: 24),
            const GoogleAuthButton(labelText: "Sign Up with Google")
          ],
        ),
      )),
    );
  }
}
