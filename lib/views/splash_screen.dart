import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'package:morgen_gold/views/login_screen.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomSplash(
        home: LoginScreen(),
        duration: 2500,
        type: CustomSplashType.StaticDuration,
        animationEffect: 'fade-in',
        imagePath: 'assets/morgengold_logo.png',
      ),
    );
  }
}