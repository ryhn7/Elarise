import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../../theme/style.dart';

class ElarisPasswordTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obsecureText;
  final Widget? icon;
  final TextEditingController? comparisonController;

  const ElarisPasswordTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.obsecureText = false,
    this.comparisonController,
    this.icon,
  });

  @override
  State<ElarisPasswordTextField> createState() =>
      _ElarisPasswordTextFieldState();
}

class _ElarisPasswordTextFieldState extends State<ElarisPasswordTextField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obsecureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText,
            style: getSansFranciscoRegular14(color: neutralFour)),
        TextFormField(
            controller: widget.controller,
            obscureText: _isObscure,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '${widget.labelText} cannot be empty'; // This is your error message.
              }

              // Additional validation for confirming password match
              if (widget.comparisonController != null &&
                  widget.comparisonController!.text != value) {
                return 'Password does not match';
              }

              return null; // Returning null indicates that the input is valid.
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: getSansFranciscoRegular16(color: neutralFour),
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
                suffixIcon: widget.obsecureText
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: neutralThree,
                        ),
                      )
                    : widget.icon))
      ],
    );
  }
}
