import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/main.dart';
import 'package:openrooms/home.dart';
import 'package:openrooms/hourly_occupancy.dart';

void main() {
  testWidgets('Tap on a room number and see the hourly occupancy page',
      (tester) async {
    // navigate to the tab widget
    await tester.pumpWidget(const CupertinoApp(
      home: CupertinoTabBarBottom(),
    ));

    // find the home icon and tap it
    await tester.tap(find.byIcon(CupertinoIcons.house_fill));
    await tester.pump();

    // expect to find the home page, with some text that is on it (Home, Room 1)
    expect(find.byType(HomePage), findsOneWidget);

    // tap on the room number
    await tester.tap(find.text('Room 3'));
    await tester.pumpAndSettle();

    // expect to find the hourly occupancy page
    expect(find.byType(HourlyOccupancy), findsOneWidget);
  });
}
