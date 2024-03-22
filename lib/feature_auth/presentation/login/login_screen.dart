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

class LoginScreen extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<LoginState>(loginStateNotifierProvider, (previous, next) {
      if (next.user != null) {
        ref.read(routerProvider).goNamed('home');
      } else if (next.error != null && next.error != "User not found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.error.toString()),
        ));
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

    Widget buildForgotPasswordButton() {
      return Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: primary,
          ),
          child: Text(
            "Forgot Password?",
            style: getSansFranciscoSemiBold16(color: primary),
          ),
        ),
      );
    }

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
              const SizedBox(height: 16),
              buildForgotPasswordButton(),
              const SizedBox(height: 24),
              ElariseAuthButton(
                labelText: loginState.isLoading ? "" : "Login",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ref.read(loginStateNotifierProvider.notifier).login(
                        email: emailController.text,
                        password: passwordController.text);
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
