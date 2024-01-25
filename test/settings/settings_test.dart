import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/settings.dart';
import 'package:provider/provider.dart';
import 'package:openrooms/themeProvider.dart';

void main() {
  testWidgets('SettingsPage UI test', (WidgetTester tester) async {
    // Wrap the SettingsPage with the necessary Provider
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(), // Provide the necessary provider
        child: const CupertinoApp(
          home: SettingsPage(title: 'Settings'),
        ),
      ),
    );

    // Perform a tap on the System button (value 0).
    await tester.tap(find.text('System'));
    await tester.pump();

    // Perform a tap on the Light button (value 1).
    await tester.tap(find.text('Light'));
    await tester.pump();

    // Perform a tap on the Dark button (value 2).
    await tester.tap(find.text('Dark'));
    await tester.pump();
  });
}