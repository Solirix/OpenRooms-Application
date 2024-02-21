import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/disclaimer.dart';

/// This file contains widget tests for the `DisclaimerDialog` widget in the OpenRooms app.
/// It verifies that the `DisclaimerDialog` is displayed correctly when directly pumped into the widget tree
/// and interacts with it to ensure the expected functionality works as intended.

// The function for the test
void main() {
  testWidgets('DisclaimerDialog is shown directly',
      (WidgetTester tester) async {
    // Directly pump the DisclaimerDialog widget
    await tester.pumpWidget(
      const CupertinoApp(
        home: DisclaimerDialog(),
      ),
    );

    // Wait for any animations to settle
    await tester.pumpAndSettle();

    // Expect to find the DisclaimerDialog widget
    expect(find.text('Legal Disclaimer'), findsOneWidget);

    // Click on the Accept button
    await tester.tap(find.text('Accept'));
  });
}
