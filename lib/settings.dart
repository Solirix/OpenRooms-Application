// Import necessary packages and files
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openrooms/themeProvider.dart'; // Assuming this file contains the ThemeProvider class
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          'Settings',
          style: TextStyle(fontSize: 30),
        ),
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
// class LegalDisclaimerPage extends StatelessWidget {
//   const LegalDisclaimerPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: const CupertinoNavigationBar(
//         middle: Text('Legal Disclaimer'),
//       ),
//       child: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'This is the Legal Disclaimer page.',
//                 style: TextStyle(fontSize: 20),
//               ),
//               CupertinoButton(
//                 child: const Text('Ok'),
//                 onPressed: () {
//                   // Navigate back to the previous page
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
