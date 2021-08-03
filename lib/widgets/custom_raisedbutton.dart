import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomRaisedbutton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;

  CustomRaisedbutton({this.onPressed, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: this.onPressed,
      child: Text(
        this.buttonText,
        style: TextStyle(color: Colors.white),
      ),
      color: Get.isDarkMode ? Colors.blueGrey[500] : Colors.orange,
    );
  }
}
