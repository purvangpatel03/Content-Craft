import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
  colorSchemeSeed: Colors.amberAccent,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Colors.amberAccent,
      minimumSize: const Size(130, 50),
      maximumSize: const Size(230, 50),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
  scaffoldBackgroundColor: const Color.fromRGBO(255, 253, 245, 1.0),
  appBarTheme: const AppBarTheme(
    color: Color.fromRGBO(253, 221, 128, 1.0),
    elevation: 4,
    surfaceTintColor: Colors.transparent,
  ),
);
