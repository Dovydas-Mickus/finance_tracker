import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: Color.fromARGB(250,253,255,248),
    secondary: Color.fromARGB(232,235,255, 231)
  ),
  iconTheme: IconThemeData(color: Colors.grey[200]),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.grey[800],
  ),
  
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.grey[700],
      backgroundColor: Color.fromARGB(255, 231, 232, 235)
    )
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 85, 85, 85))
    ),
    labelStyle: TextStyle(
      color: Colors.grey[900]
    )
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.grey[900],
    selectionHandleColor: Colors.grey[300]
  )
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Color.fromARGB(255, 19,19,20),
    primary: Color.fromARGB(255, 27,27,27),
    secondary: Color.fromARGB(55,57,59,255)
    
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.grey[200],
  ),
  
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.grey[200],
      backgroundColor: Color.fromARGB(255, 55, 57, 59)
    )
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 190, 190, 190))
    ),
    labelStyle: TextStyle(
      color: Colors.grey[100]
    )
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.grey[200],
    selectionHandleColor: Colors.grey[300]
  )
);