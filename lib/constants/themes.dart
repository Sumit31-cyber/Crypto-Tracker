import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
  ),
  brightness: Brightness.light,
);

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF15161a),
    appBarTheme:
        const AppBarTheme(elevation: 0, backgroundColor: Color(0xFF15161a)));
