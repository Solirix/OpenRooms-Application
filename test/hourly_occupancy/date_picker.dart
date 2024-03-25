import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/hourly_occupancy.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:openrooms/get_firebase_data.dart';

/// This test file is designed to validate the functionality of the calendar feature within the HourlyOccupancy widget
/// It uses the `flutter_test` framework to simulate user interaction with the calendar icon,
/// aiming to change the displayed date. The test ensures that the widget correctly updates to reflect the newly selected

class MockFirebaseRoomService extends Mock implements FirebaseRoomService {
  @override
  Stream<Map<int, String>> getOccupancyDataForDateAndRoom(
      String date, String roomId) {
    // Override the getOccupancyDataForDateAndRoom method to provide a mock response.
    // This returns a stream that emits a single map with all hours available, simulating
    // the behavior of fetching occupancy data for a specific room from Firebase without making real network requests.
    return super.noSuchMethod(
        Invocation.method(#getOccupancyDataForDateAndRoom, [date, roomId]),
        returnValue: Stream.fromIterable([
          {
            0: 'available',
            1: 'available',
            2: 'available',
            3: 'available',
            4: 'available',
            5: 'available',
            9: 'available',
            10: 'available',
            11: 'available',
            12: 'available',
            13: 'available',
            14: 'available',
            15: 'available',
            16: 'available',
            17: 'available',
            18: 'available',
            19: 'available',
            20: 'available',
            21: 'available',
            22: 'available',
            23: 'available'
          }
        ]),
        returnValueForMissingStub: Stream.fromIterable([
          {
            0: 'available',
            1: 'available',
            2: 'available',
            3: 'available',
            4: 'available',
            5: 'available',
            9: 'available',
            10: 'available',
            11: 'available',
            12: 'available',
            13: 'available',
            14: 'available',
            15: 'available',
            16: 'available',
            17: 'available',
            18: 'available',
            19: 'available',
            20: 'available',
            21: 'available',
            22: 'available',
            23: 'available'
          }
        ]));
  }
}

// Begin test to make sure that calendar updates calendar to correct day.
void main() {
  testWidgets('Find calendar icon and click it to change the date',
      (tester) async {
    final mockService = MockFirebaseRoomService();
    const String roomId = 'room1';

    // navigate to the tab widget
    await tester.pumpWidget(CupertinoApp(
      home: HourlyOccupancy(roomId: roomId, firebaseRoomService: mockService),
    ));
    // Verify that the initial date is yesterday's date.
    expect(
        find.text(
          DateFormat.yMMMd()
              .format(DateTime.now().subtract(const Duration(days: 1))),
        ),
        findsOneWidget);

    // Tap on the calendar icon to open the calendar popup.
    await tester.tap(find.byIcon(CupertinoIcons.calendar));
    await tester.pumpAndSettle();

    // Select a new date (update with the desired date).
    await tester.tap(find.text('26')); // Example: Tapping on 26th day.
    await tester.pumpAndSettle();

    // Verify that the new date is the 26th
    expect(find.text('26'), findsOneWidget);

    // Tap on the calendar icon to open the calendar popup.
    await tester.tap(find.byIcon(CupertinoIcons.calendar));
    await tester.pumpAndSettle();

    //prove we can't find June yet since it didn't happen yet
    expect(find.text('June'), findsNothing);
  });
}
