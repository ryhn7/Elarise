import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';

class ElariseAuthButton extends StatelessWidget {
  final String labelText;
  const ElariseAuthButton({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36))),
        child: Text(
          labelText,
          style: getSansFranciscoBold16(color: neutralFour),
        ),
      ),
    );
  }
}
