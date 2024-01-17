import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ThemeProvider class manages the app's theme and provides methods to toggle between light and dark modes.
class ThemeProvider extends ChangeNotifier {
  // Flag to track whether the app is in dark mode or not.
  bool _isDarkMode = false;

  // Getter to check if the app is currently in dark mode.
  bool get isDarkMode => _isDarkMode;

  // Method to toggle between light and dark modes based on the provided ThemeMode.
  void toggleTheme(ThemeMode mode) {
    // Switch statement to handle different ThemeModes.
    switch (mode) {
      case ThemeMode.light:
        _isDarkMode = false; // Set to light mode.
        break;
      case ThemeMode.dark:
        _isDarkMode = true; // Set to dark mode.
        break;
      default:
        break;
    }
    // Notify listeners about the theme change.
    notifyListeners();
  }

  // Getter to retrieve the current ThemeData based on the dark mode status.
  ThemeData getTheme() {
    return _isDarkMode ? darkTheme : lightTheme;
  }

  // Getter to retrieve the current CupertinoThemeData based on the dark mode status.
  CupertinoThemeData getCupertinoTheme() {
    return _isDarkMode ? darkCupertinoTheme : lightCupertinoTheme;
  }

  // Light theme for ThemeData.
  final ThemeData lightTheme = ThemeData.light();

  // Dark theme for ThemeData.
  final ThemeData darkTheme = ThemeData.dark();

  // Light theme for CupertinoThemeData.
  final CupertinoThemeData lightCupertinoTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.systemBlue,
    primaryContrastingColor: CupertinoColors.white,
    barBackgroundColor: CupertinoColors.systemBackground,
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(
        fontFamily: '.SF Pro Text', // iOS font
        fontSize: 16.0,
        color: CupertinoColors.black,
      ),
    ),
  );

  // Dark theme for CupertinoThemeData.
  final CupertinoThemeData darkCupertinoTheme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: CupertinoColors.systemBlue,
    primaryContrastingColor: CupertinoColors.white,
    barBackgroundColor: CupertinoColors.black,
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(
        fontFamily: '.SF Pro Text', // iOS font
        fontSize: 16.0,
        color: CupertinoColors.white,
      ),
    ),
  );
}