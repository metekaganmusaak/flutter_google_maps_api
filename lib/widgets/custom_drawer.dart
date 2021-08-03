import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgen_gold/views/login_screen.dart';
import 'package:morgen_gold/views/options_screen.dart';

class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      elevation: 7,
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Image.asset("assets/morgengold_logo.png", color: Get.isDarkMode ? Colors.white : null),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/account_picture.jpeg",
                        height: 49,
                        width: 49,
                      ),
                    ),
                    Column(
                      children: [
                        Text("Mete Kağan MUSAAK"),
                        Text(
                          "metemusaak@gmail.com",
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: Text("First"),
            trailing: Icon(Icons.arrow_forward_ios_rounded,
                color: changeColors(),
                ),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            title: Text("Second"),
            trailing: Icon(Icons.arrow_forward_ios_rounded,
                color:changeColors(),
                ),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            title: Text("drawer_options".tr),
            trailing: Icon(Icons.arrow_forward_ios_rounded,
                color: changeColors(),
                ),
            onTap: () async {
              Get.back();
              await Get.to(() => OptionsScreen(),
                  transition: Transition.rightToLeft,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.linearToEaseOut,
                  arguments: "Options"
                  );
            },
          ),
          ListTile(
            title: Text("drawer_logout".tr),
            trailing: Icon(Icons.logout,color: changeColors()),
            onTap: () {
              _exitApp();
            },
          ),
        ],
      ),
    );
  }
  
  Color changeColors(){
    if(Get.isDarkMode)
      return Colors.blueGrey[200];
    else
      return Colors.orange;
  }


  Future<bool> _exitApp() async {
    return await Get.defaultDialog(
      title: "willpop_title".tr,
      titleStyle: TextStyle(color: Colors.grey[800], fontSize: 18),
      middleText: "drawer_logout_willpop_message".tr,
      middleTextStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
      actions: [
        RaisedButton(
          onPressed: () => Get.offAll(() => LoginScreen(),
              transition: Transition.leftToRight,
              duration: Duration(milliseconds: 500)),
          color: Colors.blue,
          child: Text(
            "drawer_logout".tr,
            style: TextStyle(color: Colors.white),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        RaisedButton(
          onPressed: () => exit(0),
          color: Colors.red,
          child: Text(
            "willpop_button_exit".tr,
            style: TextStyle(color: Colors.white),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        RaisedButton(
          onPressed: () => Get.back(),
          color: Colors.grey,
          child: Text(
            "willpop_button_cancel".tr,
            style: TextStyle(color: Colors.white),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ],
      radius: 7,
      barrierDismissible: true,
    );
  }
}
