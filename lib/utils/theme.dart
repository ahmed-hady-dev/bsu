import 'package:flutter/material.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData.light().copyWith(
    textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Montserrat'),
    primaryTextTheme: ThemeData.light().textTheme.apply(fontFamily: 'Montserrat'),
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    splashColor: Colors.black,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
    brightness: Brightness.light,
    dividerColor: Colors.black,
    colorScheme: Theme.of(context).colorScheme.copyWith(primary: Colors.black, secondary: Colors.black),
    inputDecorationTheme: InputDecorationTheme(
      focusColor: Colors.cyan,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.all(8),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(18),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(18),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(18),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(18),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.grey,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(Colors.black),
    ),
  );
}
