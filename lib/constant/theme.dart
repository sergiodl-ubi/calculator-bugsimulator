import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    buttonTheme: const ButtonThemeData(),
    scaffoldBackgroundColor: const Color(0xFF3C2E1F),
  );

  static ThemeData lightTheme = ThemeData.light().copyWith(
    buttonTheme: const ButtonThemeData(),
    iconButtonTheme: const IconButtonThemeData(),
    scaffoldBackgroundColor: const Color(0xFFFAF6F0),
  );
}
