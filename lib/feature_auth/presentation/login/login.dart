import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  Widget header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset("assets/images/dummy_logo_header.png",
            width: 64, height: 64),
        const SizedBox(height: 24),
        Text(
          "Login to your account",
          style: getGrotesqueSemiBoldStyle40(color: Colors.black),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              "Don't have an account?",
              style: getSansFranciscoRegular16(color: darkSilver),
            ),
            Text(
              " Sign Up",
              style: getSansFranciscoSemiBold16(color: primary),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutralOneAlt,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 64.0, 16.0, 24.0),
        child: Column(
          children: [
            header(),
          ],
        ),
      )),
    );
  }
}
