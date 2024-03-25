import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/hourly_occupancy.dart';
import 'package:mockito/mockito.dart';
import 'package:openrooms/get_firebase_data.dart';

// This test case verifies that the hourly occupancy data is displayed with the correct times
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

//test that will mock the firebase data for room1 and make hours are displayed
void main() {
  testWidgets(
      'Make sure each hour of the day is displayed from firebase in proper format',
      (tester) async {
    final mockService = MockFirebaseRoomService();
    const String roomId = 'room1';

    // navigate to the tab widget
    await tester.pumpWidget(CupertinoApp(
      home: HourlyOccupancy(roomId: roomId, firebaseRoomService: mockService),
    ));

    //make sure the times are displayed from firebase
    expect(find.text('12 AM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('1 AM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('2 AM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('3 AM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('4 AM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('5 AM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('6 AM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('7 AM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('8 AM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('9 AM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('10 AM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('11 AM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('12 PM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('1 PM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('2 PM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('3 PM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('4 PM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('5 PM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('6 PM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('7 PM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('8 PM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('9 PM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('10 PM'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('11 PM'), findsOneWidget);
    await tester.pumpAndSettle();
  });
}
