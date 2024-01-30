import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ThemeProvider class manages the app's theme and provides methods to toggle between light and dark modes.
class ThemeProvider extends ChangeNotifier {
  // Flag to track whether the app is in dark mode or not.
  bool _isDarkMode = false;
  ThemeMode _currentThemeMode = ThemeMode.system;
  ThemeMode getThemeMode() {
    return _currentThemeMode;
  }

  // Getter to check if the app is currently in dark mode.
  bool get isDarkMode => _isDarkMode;

  // Method to toggle between light and dark modes based on the provided ThemeMode.
  void toggleTheme(ThemeMode mode) async {
    switch (mode) {
      case ThemeMode.light:
        _isDarkMode = false; // Set to light mode.
        _currentThemeMode = ThemeMode.light;
        break;
      case ThemeMode.dark:
        _isDarkMode = true; // Set to dark mode.
        _currentThemeMode = ThemeMode.dark;
        break;
      case ThemeMode.system:
        // Introduce a new method to handle the system default theme
        _isDarkMode = _getSystemBrightness() == Brightness.dark;
        _currentThemeMode = ThemeMode.system;
        break;
      default:
        break;
    }
    //save the theme
    await saveTheme(mode);
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
  static const CupertinoThemeData lightCupertinoTheme = CupertinoThemeData(
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
  static const CupertinoThemeData darkCupertinoTheme = CupertinoThemeData(
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

  // Helper method to get the system brightness
  Brightness _getSystemBrightness() {
    return WidgetsBinding.instance.window.platformBrightness;
  }
  // Method to save the selected theme mode to SharedPreferences
Future<void> saveTheme(ThemeMode mode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('themeMode', mode.index); // Save the index of the selected ThemeMode
}

// Method to load the saved theme mode from SharedPreferences
Future<void> loadSavedTheme() async {
  final prefs = await SharedPreferences.getInstance();
  final themeIndex = prefs.getInt('themeMode'); // Retrieve the saved theme index
  if (themeIndex != null) {
    toggleTheme(ThemeMode.values[themeIndex]); // Toggle the theme based on the saved index
  }
}

  // Future method to get the saved theme mode from SharedPreferences
Future<ThemeMode> getSavedTheme() async {
  final prefs = await SharedPreferences.getInstance();
  final themeIndex = prefs.getInt('themeMode'); // Retrieve the saved theme index
  if (themeIndex != null) {
    return ThemeMode.values[themeIndex]; // Return the ThemeMode based on the saved index
  } else {
    return ThemeMode.system; // If no saved index, return system default as the default theme
  }
}

}
