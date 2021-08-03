import 'dart:ui';
import 'package:get/get.dart';

class LocalizationController extends GetxController{
  
  void changeLanguage(var language, var region){
    var locale = Locale(language, region);
    Get.updateLocale(locale);
  }

}