import '../../../../theme/colors.dart';
import '../../../../theme/style.dart';
import 'package:flutter/material.dart';

class ElariseAuthTextfield extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obsecureText;
  final Widget? icon;

  const ElariseAuthTextfield(
      {super.key,
      required this.labelText,
      required this.controller,
      this.obsecureText = false,
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

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _isObscure,
      style: getSansFranciscoRegular16(color: neutralFour),
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
          floatingLabelBehavior: FloatingLabelBehavior.never,
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
