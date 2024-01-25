import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/home.dart';
import 'package:openrooms/hourly_occupancy.dart';

void main() {
  testWidgets('Tap on the back button', (tester) async {
    // Build the widget tree
    await tester.pumpWidget(const CupertinoApp(
      home: CupertinoPageScaffold(
        child: HomePage(title: 'Home'),
      ),
    ));

    // Expect to find the HomePage widget
    expect(find.byType(HomePage), findsOneWidget);

    // Navigate to HourlyOccupancy page
    await tester.tap(find.text('Room 1'));

    // Wait for the navigation to complete
    await tester.pumpAndSettle();

    // Expect to find the HourlyOccupancy widget
    expect(find.byType(HourlyOccupancy), findsOneWidget);

    // Tap on the back button
    await tester.pageBack();

    // Wait for animations to complete
    await tester.pumpAndSettle();

    // Expect to find the previous page (in this case, it goes back to the home page)
    expect(find.byType(HomePage), findsOneWidget);
  });
}
