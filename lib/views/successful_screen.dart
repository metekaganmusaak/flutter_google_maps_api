import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgen_gold/views/home_screen.dart';

class SuccessfulScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Get.isDarkMode ? Colors.blueGrey[900] : Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.offAll(() => HomeScreen()),
        label: Text("goToHomePage_button_text".tr, style: TextStyle(color: Colors.white),),
        icon: Icon(Icons.arrow_forward_ios_outlined, color: Colors.white,),
        backgroundColor:  Get.isDarkMode ? Colors.blueGrey[700] : Colors.orange
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
           Icon(Icons.check_circle_rounded, color: Colors.green, size: 100),
           SizedBox(height: 7,),
           Text(
             "successful_message".tr, 
           style: TextStyle(fontSize: 16, color:  Get.isDarkMode ? Colors.blueGrey[100] : Colors.grey[800])),
          ]
        ),
      ),
    );
  }
}