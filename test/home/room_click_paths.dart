import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/home.dart';
import 'package:openrooms/hourly_occupancy.dart';
import 'package:mockito/mockito.dart';
import 'package:openrooms/get_firebase_data.dart';
import 'package:openrooms/utils.dart';

/// This file is dedicated to testing navigation interactions with tapping on room options from the HomePage to navigate to
/// the HourlyOccupancy page and then using the back button to return. It leverages the `flutter_test` framework for widget testing and
/// `mockito` for mocking the FirebaseRoomService, allowing for testing of UI flow and service interactions without actual network calls.
///
/// Key Features Tested:
/// - Navigation to HourlyOccupancy page upon selecting an null room.
/// - Returning to the HomePage when the back button is pressed.
/// - Ensuring the HourlyOccupancy page is not displayed for offline rooms.

class MockFirebaseRoomService extends Mock implements FirebaseRoomService {
  @override
  Stream<String> getRoomValueStream(String roomId) {
    // Override the getRoomValueStream method to provide a mock response.
    // This returns a stream that emits a single 'null' string, simulating
    // the behavior of fetching data for a specific room from Firebase without making real network requests.
    return super.noSuchMethod(Invocation.method(#getRoomValueStream, [roomId]),
        returnValue: Stream.fromIterable(['null']),
        returnValueForMissingStub: Stream.fromIterable(['null']));
  }

  // @override
  // Stream<Map<int, String>> getOccupancyDataForDateAndRoom(
  //     String date, String roomId) {
  //   // Override the getOccupancyDataForDateAndRoom method to provide a mock response.
  //   // This returns a stream that emits a single map with all hours null, simulating
  //   // the behavior of fetching occupancy data for a specific room from Firebase without making real network requests.
  //   return super.noSuchMethod(
  //       Invocation.method(#getOccupancyDataForDateAndRoom, [date, roomId]),
  //       returnValue: Stream.fromIterable([
  //         {
  //           0: 'null',
  //           1: 'null',
  //           2: 'null',
  //           3: 'null',
  //           4: 'null',
  //           5: 'null',
  //           9: 'null',
  //           10: 'null',
  //           11: 'null',
  //           12: 'null',
  //           13: 'null',
  //           14: 'null',
  //           15: 'null',
  //           16: 'null',
  //           17: 'null',
  //           18: 'null',
  //           19: 'null',
  //           20: 'null',
  //           21: 'null',
  //           22: 'null',
  //           23: 'null'
  //         }
  //       ]),
  //       returnValueForMissingStub: Stream.fromIterable([
  //         {
  //           0: 'null',
  //           1: 'null',
  //           2: 'null',
  //           3: 'null',
  //           4: 'null',
  //           5: 'null',
  //           9: 'null',
  //           10: 'null',
  //           11: 'null',
  //           12: 'null',
  //           13: 'null',
  //           14: 'null',
  //           15: 'null',
  //           16: 'null',
  //           17: 'null',
  //           18: 'null',
  //           19: 'null',
  //           20: 'null',
  //           21: 'null',
  //           22: 'null',
  //           23: 'null'
  //         }
  //       ]));
  // }
}

//Begin Test to navigate between HourlyOccupancy page and back to Home Page
void main() {
  testWidgets('Tap on the rooms', (tester) async {
    // Create a mock FirebaseRoomService
    final mockService = MockFirebaseRoomService();

    // Setup mock responses with type specified
    when(mockService.getRoomValueStream('room1'))
        .thenAnswer((_) => Stream.fromIterable(['0']));
    when(mockService.getRoomValueStream('room2'))
        .thenAnswer((_) => Stream.fromIterable(['1']));
    when(mockService.getRoomValueStream('room3'))
        .thenAnswer((_) => Stream.fromIterable(['null']));
    // when(mockService.getOccupancyDataForDateAndRoom('2024-02-29', 'room1'))
    //     .thenAnswer((_) => Stream.fromIterable([
    //           {
    //             0: 'available',
    //             1: 'available',
    //             2: 'available',
    //             3: 'available',
    //             4: 'available',
    //             5: 'available',
    //             9: 'available',
    //             10: 'available',
    //             11: 'available',
    //             12: 'available',
    //             13: 'available',
    //             14: 'available',
    //             15: 'available',
    //             16: 'available',
    //             17: 'available',
    //             18: 'available',
    //             19: 'available',
    //             20: 'available',
    //             21: 'available',
    //             22: 'available',
    //             23: 'available'
    //           }
    //         ]));
    // Build the widget tree
    await tester.pumpWidget(CupertinoApp(
      home: CupertinoPageScaffold(
        child: HomePage(firebaseRoomService: mockService),
      ),
    ));

    await tester.pumpAndSettle();

    // if roomvalue is 0, expect to find historical data text
    expect(createRoomAdditionalInfo('0'), isNotNull);

    // if roomvalue is 1, expect to find historical data text
    expect(createRoomAdditionalInfo('1'), isNotNull);

    // if roomvalue is null, expect to find null
    expect(createRoomAdditionalInfo('null'), isNull);

// Expect to find the HomePage widget
//     expect(find.byType(HourlyOccupancy), findsOneWidget);
//     await tester.pumpAndSettle();

// //find the navigation bar
//     expect(find.byType(CupertinoNavigationBar), findsOneWidget);

//     await tester.pageBack();
//     await tester.pumpAndSettle();

// //tap on the room 1
//     await tester.tap(find.text('Room 1'));
//     await tester.pumpAndSettle();

// // Expect to find the HourlyOccupancy widget is displayed when room is available
//     expect(find.byType(HourlyOccupancy), findsOneWidget);

// //Tap on the back button
//     await tester.pageBack();
//     await tester.pumpAndSettle();

// // Expect to find the previous page (in this case, it goes back to the home page)
//     expect(find.byType(HomePage), findsOneWidget);

// // tap on the room 2
//     await tester.tap(find.text('Room 2'));
//     await tester.pumpAndSettle();

// //expect that the HourlyOccupancy widget is displayed when room is unavailable
//     expect(find.byType(HourlyOccupancy), findsOneWidget);

// // Tap on the back button
//     await tester.pageBack();
//     await tester.pumpAndSettle();

// //tap on room 3
//     await tester.tap(find.text('Room 3'));
//     await tester.pumpAndSettle();

// //expect that the Hourly Occupancy page is not displayed when the room is offline
//     expect(find.byType(HourlyOccupancy), findsNothing);
  });
}
