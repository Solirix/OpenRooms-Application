import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/home.dart';
import 'package:openrooms/hourly_occupancy.dart';
import 'package:mockito/mockito.dart';
import 'package:openrooms/get_firebase_data.dart';

/// This file is dedicated to testing navigation interactions with tapping on room options from the HomePage to navigate to 
/// the HourlyOccupancy page and then using the back button to return. It leverages the `flutter_test` framework for widget testing and 
/// `mockito` for mocking the FirebaseRoomService, allowing for testing of UI flow and service interactions without actual network calls.
///
/// Key Features Tested:
/// - Navigation to HourlyOccupancy page upon selecting an available room.
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
}

//Begin Test to navigate between HourlyOccupancy page and back to Home Page
void main() {
  testWidgets('Tap on the back button', (tester) async {
    // Create a mock FirebaseRoomService
    final mockService = MockFirebaseRoomService();

    // Setup mock responses with type specified
    when(mockService.getRoomValueStream('room1'))
        .thenAnswer((_) => Stream.fromIterable(['0']));
    when(mockService.getRoomValueStream('room2'))
        .thenAnswer((_) => Stream.fromIterable(['1']));
    when(mockService.getRoomValueStream('room3'))
        .thenAnswer((_) => Stream.fromIterable(['null']));
    // Build the widget tree
    await tester.pumpWidget(CupertinoApp(
      home: CupertinoPageScaffold(
        child: HomePage(firebaseRoomService: mockService),
      ),
    ));

    // Expect to find the HomePage widget
    expect(find.byType(HomePage), findsOneWidget);

    // tap on the room 1
    await tester.tap(find.text('Room 1'));
    await tester.pumpAndSettle();

    // Expect to find the HourlyOccupancy widget is displayed when room is available
    expect(find.byType(HourlyOccupancy), findsOneWidget);

    // Tap on the back button
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Expect to find the previous page (in this case, it goes back to the home page)
    expect(find.byType(HomePage), findsOneWidget);

    // tap on the room 2
    await tester.tap(find.text('Room 2'));
    await tester.pumpAndSettle();

    //expect that the HourlyOccupancy widget is displayed when room is unavailable
    expect(find.byType(HourlyOccupancy), findsOneWidget);

    // Tap on the back button
    await tester.pageBack();
    await tester.pumpAndSettle();

    //tap on room 3
    await tester.tap(find.text('Room 3'));
    await tester.pumpAndSettle();

    //expect that the Hourly Occupancy page is not displayed when the room is offline
    expect(find.byType(HourlyOccupancy), findsNothing);
  });
}
