import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/hourly_occupancy.dart';
import 'package:intl/intl.dart';

void main() {
  testWidgets('Find calendar icon and click it to change the date',
      (tester) async {
    // navigate to the tab widget
    await tester.pumpWidget(const CupertinoApp(
      home: HourlyOccupancy(),
    ));
    // Verify that the initial date is today's date.
    expect(
        find.text(DateFormat.yMMMd().format(DateTime.now())), findsOneWidget);

    // Tap on the calendar icon to open the calendar popup.
    await tester.tap(find.byIcon(CupertinoIcons.calendar));
    await tester.pumpAndSettle();

    // Select a new date (update with the desired date).
    await tester.tap(find.text('26')); // Example: Tapping on 16th day.
    await tester.pumpAndSettle();

    // Verify that the new date is the 26th
    expect(find.text('Jan 26, 2024'), findsOneWidget);
  });
}
