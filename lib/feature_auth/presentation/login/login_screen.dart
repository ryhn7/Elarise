import 'package:elarise/feature_auth/presentation/widget/elaris_auth_button.dart';
import 'package:elarise/feature_auth/presentation/widget/elarise_auth_textfield.dart';
import 'package:elarise/feature_auth/presentation/widget/google_auth_button.dart';
import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginScreen({super.key});

  Widget header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset("assets/images/dummy_logo_header.png",
            width: 64, height: 64),
        const SizedBox(height: 8),
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
                onPressed: () {},
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

  Widget dividerLoginAlternate() {
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
          "Or login with",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutralOneAlt,
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 24.0),
        child: Column(
          children: [
            header(),
            const SizedBox(height: 12),
            ElariseAuthTextfield(
                labelText: 'Email', controller: emailController),
            const SizedBox(height: 20),
            ElariseAuthTextfield(
                labelText: 'Password',
                controller: passwordController,
                obsecureText: true),
            Align(
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
            ),
            const SizedBox(height: 16),
            const ElariseAuthButton(labelText: "Login"),
            const SizedBox(height: 24),
            dividerLoginAlternate(),
            const SizedBox(height: 24),
            const GoogleAuthButton(labelText: "Login with Google")
          ],
        ),
      )),
    );
  }
}