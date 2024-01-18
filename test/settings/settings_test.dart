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
        child: CupertinoApp(
          home: SettingsPage(title: 'Settings'),
        ),
      ),
    );

    // Verify that the light mode button is present.
    expect(find.text('Light Mode'), findsOneWidget);

    // Verify that the dark mode button is present.
    expect(find.text('Dark Mode'), findsOneWidget);

    // Perform a tap on the Light Mode button.
    await tester.tap(find.text('Light Mode'));
    await tester.pump();

    // Perform a tap on the Dark Mode button.
    await tester.tap(find.text('Dark Mode'));
    await tester.pump();
  });
}