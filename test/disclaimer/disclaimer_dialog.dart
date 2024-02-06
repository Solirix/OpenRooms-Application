import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/disclaimer.dart';

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
