import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final TextInputType inputType;
  final bool isPassword;

  CustomTextformfield({this.hintText, this.icon, this.inputType, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: this.inputType,
      obscureText: this.isPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(color: Colors.blue[100]),
        ),
        hintText: this.hintText,
        prefixIcon: this.icon,
      ),
    );
  }
}
