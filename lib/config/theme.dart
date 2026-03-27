import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  colorScheme: .fromSeed(seedColor: Colors.blue),
  fontFamily: 'Arimo',

  appBarTheme: AppBarThemeData(
    backgroundColor: Colors.blueAccent,
    foregroundColor: Colors.white
  ),

  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: Colors.blue
    ),
  ),
  
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white
  ),
);