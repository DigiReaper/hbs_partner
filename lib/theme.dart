import 'package:flutter/material.dart';

Color primaryColor = const Color(0xFFFCAD1F);

Color blueColor = const Color(0xFF032678);

final ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  useMaterial3: true,
  fontFamily: 'Figtree', // Set the global font family to Figtree

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor, // Set the primary color for buttons
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    prefixIconColor: Colors.black, // Set the primary color for prefix icons
  ),
);