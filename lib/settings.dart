import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openrooms/themeProvider.dart';
import 'package:provider/provider.dart';

/// This file contains the implementation of the `SettingsPage` widget, which is part of the OpenRooms app.
/// The page is designed using Cupertino widgets to provide the user with theme selection options (System, Light, Dark)
///  for the app. It utilizes the `ThemeProvider` to manage and apply the selected theme across the app.
///
/// Features:
/// - Theme Selection: Allows users to select their preferred theme through a `CupertinoSegmentedControl`.
///   The options available are System (default), Light, and Dark themes.
/// - Dynamic Theme Application: Utilizes the `Provider` package to manage theme state and dynamically apply
///   the user's selection without the need for a restart.
/// - User Preference Persistence: The `ThemeProvider` is designed to remember the user's last theme choice
///   and apply it on subsequent app launches.


class SettingsPage extends StatelessWidget {
  // Constructor with an optional key parameter for widget identification.
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Builds the settings page UI with Cupertino design system.
    return CupertinoPageScaffold(
      // Sets up a navigation bar with the title 'Settings'.
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          'Settings',
          style: TextStyle(fontSize: 30),
        ),
      ),
      // SafeArea widget to avoid overlaps with the system status bar or notch.
      child: SafeArea(
        // Centers the settings content vertically and horizontally.
        child: Center(
          // Column for laying out the settings options vertically.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center alignment for children.
            children: [
              const SizedBox(height: 20), // Adds spacing above the settings options.
              // Segmented control to allow theme selection between System, Light, and Dark modes.
              CupertinoSegmentedControl<int>(
                children: const {
                  0: Text('System'),
                  1: Text('Light'),
                  2: Text('Dark'),
                },
                onValueChanged: (value) {
                  // Handles theme change based on user selection.
                  switch (value) {
                    case 0: // System theme selected.
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(ThemeMode.system);
                      break;
                    case 1: // Light theme selected
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(ThemeMode.light);
                      break;
                    case 2: // Dark theme selected
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(ThemeMode.dark);
                      break;
                  }
                },
                groupValue: _getGroupValue(context), // Sets the current selection based on the active theme.
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Determines the currently selected theme mode and returns the corresponding group value for the segmented control.
  int _getGroupValue(BuildContext context) {
    // Retrieves the current theme mode from ThemeProvider.
    final themeMode = Provider.of<ThemeProvider>(context).getThemeMode();

    // Maps the ThemeMode to the segmented control group value.
    switch (themeMode) {
      case ThemeMode.system: // System theme is selected.
        return 0;
      case ThemeMode.light: // Light theme is selected.
        return 1;
      case ThemeMode.dark: // Dark theme is selected.
        return 2;
    }
  }
}