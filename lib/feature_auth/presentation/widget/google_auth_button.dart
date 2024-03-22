import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';

class GoogleAuthButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool continueWithGoogleLoading;

  const GoogleAuthButton(
      {super.key, this.onPressed, this.continueWithGoogleLoading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: tan,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36))),
        child: continueWithGoogleLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(neutralFour),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/google_logo.png",
                      width: 24, height: 24),
                  const SizedBox(width: 12),
                  Text(
                    "Continue with Google",
                    style: getSansFranciscoBold16(color: neutralFour),
                  ),
                ],
              ),
      ),
    );
  }
}
