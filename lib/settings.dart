// Import necessary packages and files
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openrooms/themeProvider.dart'; // Assuming this file contains the ThemeProvider class
import 'package:provider/provider.dart';

// Define a StatelessWidget for the SettingsPage
class SettingsPage extends StatelessWidget {
  final String title;

  // Constructor to receive the title for the SettingsPage
  const SettingsPage({Key? key, required this.title}) : super(key: key);

  // Build method to construct the UI for the SettingsPage
  @override
  Widget build(BuildContext context) {
    // CupertinoPageScaffold provides a basic structure for a page
    return CupertinoPageScaffold(
      // CupertinoNavigationBar is the top navigation bar
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings'), //   'Settings' in the middle of the navigation bar
      ),
      // SafeArea ensures content is displayed within safe areas on the screen
      child: SafeArea(
        // Center widget centers its child vertically and horizontally
        child: Center(
          // Column widget organizes children in a vertical column
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            children: [
              // Display the title received from the constructor
              Text(
                title,
                style: const TextStyle(fontSize: 48),
              ),
              const SizedBox(height: 20), // Spacer between the title and buttons

              // CupertinoSegmentedControl to display three clickable options
              CupertinoSegmentedControl<int>(
                children: {
                  0: Text('System'),
                  1: Text('Light'),
                  2: Text('Dark'),
                },
                onValueChanged: (value) {
                  // Switch statement to handle different button presses
                  switch (value) {
                    case 0:
                      // Toggle to System mode
                      Provider.of<ThemeProvider>(context, listen: false).toggleTheme(ThemeMode.system);
                      print('System Pressed');
                      break;
                    case 1:
                      // Toggle to Light mode
                      Provider.of<ThemeProvider>(context, listen: false).toggleTheme(ThemeMode.light);
                      print('Light Pressed');
                      break;
                    case 2:
                      // Toggle to Dark mode
                      Provider.of<ThemeProvider>(context, listen: false).toggleTheme(ThemeMode.dark);
                      print('Dark Pressed');
                      break;
                  }
                },
                // Set the selected index based on the current theme mode
                groupValue: _getGroupValue(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to determine the selected index based on the current theme mode
  int _getGroupValue(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    
    // If in Dark mode, return 2 (Dark mode index), else, use platformBrightness to determine Light (1) or System (0)
    if (isDarkMode) {
      return 2; // Dark mode index
    } else {
      return MediaQuery.of(context).platformBrightness == Brightness.light ? 1 : 0;
      // Use 1 for light mode if the platformBrightness is light, otherwise, use 0 for system mode
    }
  }
}