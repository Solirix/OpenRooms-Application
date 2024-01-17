import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/themeProvider.dart';
import 'package:flutter/material.dart';

void main() {
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
}