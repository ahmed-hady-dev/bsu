import 'package:flutter/material.dart';

import '../constants/constants.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData.light().copyWith(
    textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Montserrat'),
    primaryTextTheme: ThemeData.light().textTheme.apply(fontFamily: 'Montserrat'),
    appBarTheme: Theme.of(context).appBarTheme.copyWith(
          centerTitle: true,
          elevation: 0,
          color: AppColors.scaffoldColor,
        ),
    // primaryColor: Colors.black,
    scaffoldBackgroundColor: AppColors.scaffoldColor,
    // splashColor: Colors.black,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
    brightness: Brightness.light,
    colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: AppColors.indigo,
          secondary: AppColors.indigo,
        ),
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
