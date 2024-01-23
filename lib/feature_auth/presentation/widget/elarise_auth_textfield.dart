import 'package:elarise/theme/colors.dart';
import 'package:elarise/theme/style.dart';
import 'package:flutter/material.dart';

class ElariseAuthTextfield extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obsecureText;


  const ElariseAuthTextfield({
    super.key, 
    required this.labelText, 
    required this.controller,
    this.obsecureText = false
    });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsecureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: getSansFranciscoRegular16(color: neutralThree),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: neutralThree30),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: neutralThree),
          borderRadius: BorderRadius.circular(16),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never
      ),
    );
  }
}
