// Import necessary packages and files
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openrooms/themeProvider.dart'; // Assuming this file contains the ThemeProvider class
import 'package:provider/provider.dart';

//Define a StatelessWidget for the SettingsPage
// class SettingsPage extends StatelessWidget {
//   // Constructor to receive the title for the SettingsPage
//   const SettingsPage({
//     super.key,
//   });

//   // Build method to construct the UI for the SettingsPage
//   @override
//   Widget build(BuildContext context) {
//     // CupertinoPageScaffold provides a basic structure for a page
//     return CupertinoPageScaffold(
//       // CupertinoNavigationBar is the top navigation bar
//       navigationBar: const CupertinoNavigationBar(
//         middle: Text(
//             'Settings'), //   'Settings' in the middle of the navigation bar
//       ),
//       // SafeArea ensures content is displayed within safe areas on the screen
//       child: SafeArea(
//         // Center widget centers its child vertically and horizontally
//         child: Center(
//           // Column widget organizes children in a vertical column
//           child: Column(
//             mainAxisAlignment:
//                 MainAxisAlignment.center, // Center content vertically
//             children: [
//               const SizedBox(
//                   height: 20), // Spacer between the title and buttons

//               // CupertinoSegmentedControl to display three clickable options
//               CupertinoSegmentedControl<int>(
//                 children: const {
//                   0: Text('System'),
//                   1: Text('Light'),
//                   2: Text('Dark'),
//                 },
//                 onValueChanged: (value) {
//                   // Switch statement to handle different button presses
//                   switch (value) {
//                     case 0:
//                       // Toggle to System mode
//                       Provider.of<ThemeProvider>(context, listen: false)
//                           .toggleTheme(ThemeMode.system);
//                       break;
//                     case 1:
//                       // Toggle to Light mode
//                       Provider.of<ThemeProvider>(context, listen: false)
//                           .toggleTheme(ThemeMode.light);
//                       break;
//                     case 2:
//                       // Toggle to Dark mode
//                       Provider.of<ThemeProvider>(context, listen: false)
//                           .toggleTheme(ThemeMode.dark);
//                       break;
//                   }
//                 },
//                 // Set the selected index based on the current theme mode
//                 groupValue: _getGroupValue(context),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Method to determine the selected index based on the current theme mode
//   int _getGroupValue(BuildContext context) {
//     final themeMode = Provider.of<ThemeProvider>(context).getThemeMode();

//     // Return the corresponding index based on the current theme mode
//     switch (themeMode) {
//       case ThemeMode.system:
//         return 0; // System mode index
//       case ThemeMode.light:
//         return 1; // Light mode index
//       case ThemeMode.dark:
//         return 2; // Dark mode index
//     }
//   }
// }

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CupertinoSegmentedControl<int>(
                children: const {
                  0: Text('System'),
                  1: Text('Light'),
                  2: Text('Dark'),
                },
                onValueChanged: (value) {
                  switch (value) {
                    case 0:
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(ThemeMode.system);
                      break;
                    case 1:
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(ThemeMode.light);
                      break;
                    case 2:
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(ThemeMode.dark);
                      break;
                  }
                },
                groupValue: _getGroupValue(context),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute<void>(
                      builder: (BuildContext context) {
                        return const LegalDisclaimerPage();
                      },
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.activeBlue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Legal Disclaimer',
                    style: TextStyle(
                      fontSize: 18,
                      color: CupertinoColors.activeBlue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getGroupValue(BuildContext context) {
    final themeMode = Provider.of<ThemeProvider>(context).getThemeMode();

    switch (themeMode) {
      case ThemeMode.system:
        return 0;
      case ThemeMode.light:
        return 1;
      case ThemeMode.dark:
        return 2;
    }
  }
}

// Additional page for Legal Disclaimer
class LegalDisclaimerPage extends StatelessWidget {
  const LegalDisclaimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Legal Disclaimer'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'This is the Legal Disclaimer page.',
                style: TextStyle(fontSize: 20),
              ),
              CupertinoButton(
                child: const Text('Ok'),
                onPressed: () {
                  // Navigate back to the previous page
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
