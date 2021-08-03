import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgen_gold/controllers/localization_controller.dart';
import 'login_screen.dart';

class SelectLanguageScreen extends StatelessWidget {
  
  LocalizationController localizationController =
      Get.put(LocalizationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.blueGrey[800] : Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                localizationController.changeLanguage("en", "US");
                Get.offAll(() => LoginScreen(),
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    transition: Transition.zoom);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image.asset(
                  "assets/uk.png",
                  height: 75,
                  width: 75,
                  ),
              ),
            ),
            InkWell(
              onTap: () {
                localizationController.changeLanguage("de", "DE");
                Get.offAll(() => LoginScreen(),
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    transition: Transition.zoom);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image.asset(
                  "assets/germany.png",
                  height: 75,
                  width: 75,
                  ),
              ),
            ),
            InkWell(
              onTap: () {
                localizationController.changeLanguage("tr", "TR");
                Get.offAll(() => LoginScreen(),
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    transition: Transition.zoom);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image.asset(
                  "assets/turkey.png",
                  height: 75,
                  width: 75,
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
