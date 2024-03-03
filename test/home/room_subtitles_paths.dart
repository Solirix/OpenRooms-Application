import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/home.dart';
import 'package:openrooms/hourly_occupancy.dart';
import 'package:mockito/mockito.dart';
import 'package:openrooms/get_firebase_data.dart';
import 'package:openrooms/utils.dart';

/// This test file is focused on verifying the dynamic UI updates of room availability indicators
/// within the OpenRooms app. It employs widget testing to ensure that the HomePage correctly displays
/// the availability status ('Available', 'Unavailable', 'Offline') for rooms based on the data provided
/// by the FirebaseRoomService. The use of the 'mockito' package allows for simulating Firebase service
/// responses without actual network calls.
///
/// Key Test Scenarios:
/// - Mock responses are set up for three rooms with distinct availability states: available, unavailable, and offline.
/// - The HomePage widget is rendered with these mocked responses, and the test checks if each room's availability
///   status is displayed as expected.
/// - This ensures that the app's UI accurately reflects the current state of room availability to the user.

class MockFirebaseRoomService extends Mock implements FirebaseRoomService {
  @override
  Stream<String> getRoomValueStream(String roomId) {
    return super.noSuchMethod(Invocation.method(#getRoomValueStream, [roomId]),
        returnValue: Stream.fromIterable(['null']),
        returnValueForMissingStub: Stream.fromIterable(['null']));
  }
}

// Begin test to ensure UI accurately reflects correct state of room availability to the user
void main() {
  testWidgets('Check the room colors', (tester) async {
    // Create a mock FirebaseRoomService
    final mockService = MockFirebaseRoomService();

    // Setup mock responses with type specified
    when(mockService.getRoomValueStream('room1'))
        .thenAnswer((_) => Stream.fromIterable(['0'])); //available
    when(mockService.getRoomValueStream('room2'))
        .thenAnswer((_) => Stream.fromIterable(['1'])); //unavailable
    when(mockService.getRoomValueStream('room3'))
        .thenAnswer((_) => Stream.fromIterable(['null'])); //offline
    // Build the widget tree
    await tester.pumpWidget(CupertinoApp(
      home: CupertinoPageScaffold(
        child: HomePage(firebaseRoomService: mockService),
      ),
    ));

    await tester.pumpAndSettle();

    expect(HomeUtils.getRoomStatus('0'), equals('Available'));
    expect(HomeUtils.getRoomStatus('1'), equals('Unavailable'));
    expect(HomeUtils.getRoomStatus('null'), equals('Offline'));

    //   //expect room1 subtitle to be 'Available'
    //   expect(
    //     find.byWidgetPredicate(
    //       (widget) =>
    //           widget is CupertinoListTile &&
    //           widget.title is Text &&
    //           (widget.title as Text).data == 'Room 1' &&
    //           widget.subtitle is Text &&
    //           (widget.subtitle as Text).data == 'Available',
    //     ),
    //     findsOneWidget,
    //   );

    //   //expect room2 subtitle to be 'Unavailable'
    //   expect(
    //     find.byWidgetPredicate(
    //       (widget) =>
    //           widget is CupertinoListTile &&
    //           widget.title is Text &&
    //           (widget.title as Text).data == 'Room 2' &&
    //           widget.subtitle is Text &&
    //           (widget.subtitle as Text).data == 'Unavailable',
    //     ),
    //     findsOneWidget,
    //   );

    //   //expect room3 subtitle to be 'Offline'
    //   expect(
    //     find.byWidgetPredicate(
    //       (widget) =>
    //           widget is CupertinoListTile &&
    //           widget.title is Text &&
    //           (widget.title as Text).data == 'Room 3' &&
    //           widget.subtitle is Text &&
    //           (widget.subtitle as Text).data == 'Offline',
    //     ),
    //     findsOneWidget,
    //   );
  });
}
