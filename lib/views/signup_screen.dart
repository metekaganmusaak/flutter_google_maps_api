import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgen_gold/views/successful_screen.dart';
import 'package:morgen_gold/widgets/custom_raisedbutton.dart';
import 'package:morgen_gold/widgets/custom_textformfield.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.blueGrey[800] : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                        style: TextStyle(fontSize: 28),
                        children: [
                          TextSpan(
                            text: "sign".tr,
                            style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
                          ),
                          TextSpan(
                            text: "up".tr,
                            style: TextStyle(color:Get.isDarkMode ? Colors.blueGrey[200] : Colors.orange),
                          ),
                        ]),
                  ),
                  Text(
                    "signup_description".tr,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 35),
                  CustomTextformfield(
                    hintText: "tff_username".tr,
                    icon: Icon(Icons.person),
                  ),
                  SizedBox(height: 7),
                  CustomTextformfield(
                    hintText: "tff_email".tr,
                    icon: Icon(Icons.mail),
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 7),
                  CustomTextformfield(
                    hintText: "tff_street".tr,
                    icon: Icon(Icons.location_on_rounded),
                    inputType: TextInputType.streetAddress,
                  ),
                  SizedBox(height: 7),
                  CustomTextformfield(
                    hintText: "tff_no".tr,
                    icon: Icon(Icons.location_on_rounded),
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 7),
                  CustomTextformfield(
                    hintText: "tff_postcode".tr,
                    icon: Icon(Icons.location_on_rounded),
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 7),
                  CustomTextformfield(
                    hintText: "tff_city".tr,
                    icon: Icon(Icons.location_on_rounded),
                    inputType: TextInputType.streetAddress,
                  ),
                  SizedBox(height: 7),
                  CustomTextformfield(
                    hintText: "tff_password".tr,
                    icon: Icon(Icons.lock),
                    isPassword: true,
                  ),
                  SizedBox(height: 7),
                  SizedBox(height: 14),
                  CustomRaisedbutton(
                    buttonText: "signup_button_text".tr,
                    onPressed: () =>
                        Get.offAll(() => SuccessfulScreen()),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        "already_have_an_account".tr,
                        style: TextStyle(
                            color: Get.isDarkMode ? Colors.blueGrey[100] : Colors.orange, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
