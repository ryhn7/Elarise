import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../../theme/style.dart';

class ElariseEditTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isEnabled;

  const ElariseEditTextField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = isEnabled ? neutralFour : Colors.grey.shade400;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: getSansFranciscoRegular14(color: textColor)),
        TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$labelText cannot be empty'; // This is your error message.
              }
              return null; // Returning null indicates that the input is valid.
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: getSansFranciscoRegular16(color: textColor),
            enabled: isEnabled,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: neutralThree30),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: darkGray),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: red),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: red),
              ),
              errorStyle: getSansFranciscoRegular14(color: red),
            ))
      ],
    );
  }
}
