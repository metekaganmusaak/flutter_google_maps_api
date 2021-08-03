import 'package:flutter/material.dart';

class Themes{
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.orange,
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.orange
    ),
    buttonColor: Colors.orange,
  );

  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.blueGrey[800],
    dialogBackgroundColor: Colors.blueGrey[200],
    accentColor: Colors.grey,
    fixTextFieldOutlineLabel: true,
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.white,

        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blueGrey[800],
    ),
    buttonColor: Colors.orange,
  );

  
}