import '../../../../theme/colors.dart';
import '../../../../theme/style.dart';
import 'package:flutter/material.dart';

class ElariseAuthTextfield extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obsecureText;
  final Widget? icon;
  final bool isEmail;

  const ElariseAuthTextfield(
      {super.key,
      required this.labelText,
      required this.controller,
      this.obsecureText = false,
      this.isEmail = false,
      this.icon});

  @override
  State<ElariseAuthTextfield> createState() => _ElariseAuthTextfieldState();
}

class _ElariseAuthTextfieldState extends State<ElariseAuthTextfield> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obsecureText;
  }

  String? _emailValidator(String? value) {
    // Regular expression for validating email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value == null || value.isEmpty) {
      return '${widget.labelText} cannot be empty';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null; // Returning null indicates that the input is valid.
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscure,
      style: getSansFranciscoRegular16(color: neutralFour),
      validator: widget.isEmail ? _emailValidator : (value) {
        if (value == null || value.isEmpty) {
          return '${widget.labelText} cannot be empty'; // This is your error message.
        }
        return null; // Returning null indicates that the input is valid.
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: getSansFranciscoRegular16(color: neutralThree),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: neutralThree30),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: neutralThree),
            borderRadius: BorderRadius.circular(16),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: red),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: red),
            borderRadius: BorderRadius.circular(16),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          errorStyle: getSansFranciscoRegular14(color: red),
          suffixIcon: widget.obsecureText
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: neutralThree,
                  ),
                )
              : widget.icon),
    );
  }
}
