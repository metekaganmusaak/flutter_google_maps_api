import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgen_gold/controllers/localization_controller.dart';
import 'package:morgen_gold/services/theme_services.dart';
import 'package:morgen_gold/views/home_screen.dart';

class OptionsScreen extends StatelessWidget {
  LocalizationController _localizationController =
      Get.put(LocalizationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("drawer_options".tr),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          /*
          ListTile(
            title: Text("drawer_change_language".tr),
            onTap: () async => changeLanguage(),
          ),
          */
          ListTile(
            title: Text("drawer_change_theme".tr),
            onTap: () async => changeTheme(),
          ),
        ],
      ),
    );
  }

  Future<Object> changeLanguage() {
    return Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(vertical: 21, horizontal: 14),
        color: Get.isDarkMode ? Colors.blueGrey[800] : Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("English"),
              trailing: Text("🇺🇸"),
              onTap: (){
                _localizationController.changeLanguage("en","US");
                Get.back();
              },
            ),
            ListTile(
              title: Text("Deutsch"),
              trailing: Text("🇩🇪"),
              onTap: (){
                _localizationController.changeLanguage("de","DE");
                Get.back();
              },
            ),
            ListTile(
              title: Text("Türkçe"),
              trailing: Text("🇹🇷"),
              onTap: (){
                _localizationController.changeLanguage("tr","TR");
                Get.back();
              },
            ),
          ],
        ),
      ),
      isDismissible: true,
      elevation: 7,
      enterBottomSheetDuration: Duration(seconds: 1),
      exitBottomSheetDuration: Duration(seconds: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }

  Future<Object> changeTheme() {
    return Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(vertical: 21, horizontal: 14),
        color: Get.isDarkMode ? Colors.blueGrey[800] : Colors.white,
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.wb_sunny),
              title: Text("theme_light".tr),
              onTap: () {
                if (Get.isDarkMode == false) {
                } else {
                  ThemeServices().changeThemeMode();
                }
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.nights_stay),
              title: Text("theme_dark".tr),
              onTap: () {
                if (Get.isDarkMode == true) {
                } else {
                  ThemeServices().changeThemeMode();
                }
                Get.back();
              },
            ),
          ],
        ),
      ),
      isDismissible: true,
      elevation: 7,
      enterBottomSheetDuration: Duration(seconds: 1),
      exitBottomSheetDuration: Duration(seconds: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}
