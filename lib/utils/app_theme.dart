import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_project_first/utils/colors.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggle(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    log(themeMode.toString());
    log("changed theme");
    notifyListeners();
  }
}

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    listTileTheme: const ListTileThemeData(textColor: blackColor),
    iconTheme: const IconThemeData(color: blackColor),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: whiteColor,
    colorScheme: const ColorScheme.light(),
    backgroundColor: whiteColor,
    cardColor: blackColor,
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xff232428),
    ), //Color(0xff232428),
  );
  static final darkTheme = ThemeData(
    useMaterial3: true,
    listTileTheme: ListTileThemeData(textColor: whiteColor),
    scaffoldBackgroundColor: const Color(0xff232428),
    iconTheme: IconThemeData(color: whiteColor),
    colorScheme: const ColorScheme.dark(),
    primaryColor: const Color(0xff232428),
    backgroundColor: whiteColor,
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xff232428),
    ), //Color(0xff232428),
  );
}
