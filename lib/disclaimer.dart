/// This Dart file provides utilities and UI components for building the Legal Disclaimer Dialog Box within the App
/// 
/// Classes:
/// - `AppUtils`: Contains static methods to check and update app launch status.
///   - `isFirstLaunch`: Checks if the app is being launched for the first time by consulting
///     the `SharedPreferences`. It updates the launch status accordingly.
/// 
/// - `DisclaimerDialog`: A stateless widget that displays a legal disclaimer in a `CupertinoAlertDialog`.
///   This dialog is intended to inform users about legal information regarding the app.
///
library;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

class AppUtils {
  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    bool hasLaunched = prefs.getBool('hasLaunched') ?? false;

    if (!hasLaunched) {
      await prefs.setBool('hasLaunched', true);
      return true; // It's the first launch
    }
    return false; // Not the first launch
  }
}

class DisclaimerDialog extends StatelessWidget {
  const DisclaimerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Legal Disclaimer'),
      content: Column(
        mainAxisSize: MainAxisSize.min, // Use min to wrap content size
        children: <Widget>[
          // Scrollable text content with padding
          Container(
            constraints: const BoxConstraints(
                maxHeight: 200), // Limit height for scrollability
            child: const CupertinoScrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                padding:
                    EdgeInsets.only(right: 8.0), // Add padding on the right
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Please read and accept our terms and conditions. '
                      'This disclaimer text can be very long. '
                      'Include all necessary information here that the user needs to accept. '
                      'Please read and accept our terms and conditions. '
                      'This disclaimer text can be very long. '
                      'Include all necessary information here that the user needs to accept. '
                      'Please read and accept our terms and conditions. '
                      'This disclaimer text can be very long. '
                      'Include all necessary information here that the user needs to accept. '
                      'Please read and accept our terms and conditions. '
                      'This disclaimer text can be very long. '
                      'Include all necessary information here that the user needs to accept. '
                      'Please read and accept our terms and conditions. '
                      'This disclaimer text can be very long. '
                      'Include all necessary information here that the user needs to accept.',
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Centered Accept button
          Align(
            alignment: Alignment.center,
            child: CupertinoButton(
              child: const Text('Accept'),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('hasSeenDisclaimer', true);
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
