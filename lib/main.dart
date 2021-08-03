import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:morgen_gold/services/theme_services.dart';
import 'package:morgen_gold/utils/themes.dart';
import 'package:morgen_gold/views/home_screen.dart';
import 'package:morgen_gold/views/splash_screen.dart';
import 'utils/messages.dart';

void main() async {
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarIconBrightness: Brightness.dark, // status bar icons' color
    systemNavigationBarIconBrightness:
        Brightness.dark, //navigation bar icons' color
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(),
      locale: Get.deviceLocale,
      fallbackLocale: Locale('en', 'US'),
      debugShowCheckedModeBanner: false, // sağ üstteki banner'ı kaldırır.
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      themeMode: ThemeServices().getThemeMode(),
      home: SplashScreen(),
    );
  }
}
