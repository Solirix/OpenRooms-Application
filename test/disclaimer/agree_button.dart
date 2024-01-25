import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/disclaimer.dart';
import 'package:openrooms/home.dart';
import 'package:openrooms/main.dart';

void main() {
  testWidgets('Agree button navigates to home page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: OpenRooms(),
    ));

    // Navigate to the DisclaimerPage.
    await tester.tap(find.text('I Agree'));
    await tester.pumpAndSettle();

    // Verify that we are on the DisclaimerPage.
    expect(find.byType(DisclaimerPage), findsOneWidget);

    // Tap on the Agree button.
    await tester.tap(find.text('Agree'));
    await tester.pumpAndSettle();

    // Verify that we are on the home page.
    expect(find.byType(CupertinoTabBarBottom), findsOneWidget);
  });
}
