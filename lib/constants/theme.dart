import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: const Color(0xffffffe0),
  appBarTheme:  AppBarTheme(
    backgroundColor: const Color(0xffe8b923).withOpacity(0.7),
    elevation: 0,
    titleTextStyle: const TextStyle(
      color: Colors.black
    ),
    iconTheme: const IconThemeData(
      color: Colors.black
    )
  ),
  primaryColor:const Color(0xffc94810),
  canvasColor: const Color(0xff90EE90),
  primarySwatch: Colors.lightBlue,
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        foregroundColor: Colors.purpleAccent,
        side: const BorderSide(
          color: Colors.green,
          width: 2,
        ),
        disabledForegroundColor: Colors.red.withOpacity(0.4)
    )
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    prefixIconColor: Colors.grey,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff1191d1),
      textStyle: const TextStyle(
        fontSize: 18
      ),
      disabledBackgroundColor: Colors.grey
    )
  ),

);