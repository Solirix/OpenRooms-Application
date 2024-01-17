import 'package:flutter/cupertino.dart';
import 'package:openrooms/themeProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final String title;

  // Constructor to receive the title for the SettingsPage
  const SettingsPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CupertinoPageScaffold provides a basic structure for a page
    return CupertinoPageScaffold(
      // CupertinoNavigationBar is the top navigation bar
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings'), // Display 'Settings' in the middle of the navigation bar
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

              // Row widget organizes children in a horizontal row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space buttons evenly
                children: [

                  CupertinoButton(
                    child: const Text('Light Mode'),
                    onPressed: () {
                      // Handle the action when Button 1 is pressed
                      // Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                          Provider.of<ThemeProvider>(context, listen: false).toggleTheme(ThemeMode.light);
                      print('Light Mode Pressed');
                    },
                  ),
                  CupertinoButton(
                    child: const Text('Dark Mode'),
                    onPressed: () {
                      // Handle the action when Button 2 is pressed
                      // Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                          Provider.of<ThemeProvider>(context, listen: false).toggleTheme(ThemeMode.dark);
                      print('Dark Mode Pressed');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}