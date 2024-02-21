import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This test is designed to validate the functionality of the ThemeProvider class.
/// It focuses on ensuring that theme toggling, saving, and loading behave as expected. The tests cover various
/// scenarios including switching between light and dark themes, persisting theme preferences, and retrieving
/// these preferences upon subsequent loads. Shared preferences are mocked to isolate tests from actual device storage.


// Main function that contains all unit tests for ThemeProvider.dart
void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
  SharedPreferences.setMockInitialValues({});

  test('Toggle theme should switch between light and dark mode', () {
    final themeProvider = ThemeProvider();

    // Initial theme should be light mode
    expect(themeProvider.isDarkMode, false);

    // Toggle to dark mode
    themeProvider.toggleTheme(ThemeMode.dark);
    expect(themeProvider.isDarkMode, true);

    // Toggle back to light mode
    themeProvider.toggleTheme(ThemeMode.light);
    expect(themeProvider.isDarkMode, false);
  });

  test('Save and load theme should work correctly', () async {
    final themeProvider = ThemeProvider();

    // Save the theme
    await themeProvider.saveTheme(ThemeMode.dark);

    // Load the saved theme
    await themeProvider.loadSavedTheme();

    // Ensure that the loaded theme matches the saved theme
    expect(themeProvider.isDarkMode, true);
  });

  test('Get saved theme with no saved theme should return system', () async {
    final themeProvider = ThemeProvider();

    // Get the saved theme
    final savedTheme = await themeProvider.getSavedTheme();

    // Ensure that the default system theme is returned
    expect(savedTheme, ThemeMode.system);
  });

  test('Get saved theme with a saved theme should return the saved theme', () async {
    final themeProvider = ThemeProvider();

    // Save a theme
    await themeProvider.saveTheme(ThemeMode.light);

    // Get the saved theme
    final savedTheme = await themeProvider.getSavedTheme();

    // Ensure that the saved theme is returned
    expect(savedTheme, ThemeMode.light);
  });
}