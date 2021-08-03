import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgen_gold/views/home_screen.dart';
import 'package:morgen_gold/views/signup_screen.dart';
import 'package:morgen_gold/widgets/custom_raisedbutton.dart';
import 'package:morgen_gold/widgets/custom_textformfield.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.blueGrey[800] : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                          style: TextStyle(fontSize: 28),
                          children: [
                            TextSpan(
                              text: 'log'.tr,
                              style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black,),
                            ),
                            TextSpan(
                              text: 'in'.tr,
                              style: TextStyle(color:Get.isDarkMode ? Colors.blueGrey[200] : Colors.orange,),
                            ),
                          ]),
                    ),
                    Text(
                      "login_description".tr,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 35),
                    CustomTextformfield(
                      hintText: "tff_username".tr,
                      icon: Icon(Icons.person),
                    ),
                    SizedBox(height: 7),
                    CustomTextformfield(
                      isPassword: true,
                      hintText: "tff_password".tr,
                      icon: Icon(Icons.lock),
                    ),
                    SizedBox(height: 14),
                    CustomRaisedbutton(
                      onPressed: () => Get.offAll(() => HomeScreen(),
                          transition: Transition.rightToLeft),
                      buttonText: "login_button_text".tr,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => SignupScreen(),
                        duration: Duration(milliseconds: 500),
                        transition: Transition.downToUp);
                  },
                  child: Text(
                    "havent_got_account".tr,
                    style:
                        TextStyle(color: Get.isDarkMode ? Colors.blueGrey[100] : Colors.orange, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
