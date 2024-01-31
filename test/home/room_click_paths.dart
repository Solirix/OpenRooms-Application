import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/home.dart';
import 'package:openrooms/hourly_occupancy.dart';
import 'package:mockito/mockito.dart';
import 'package:openrooms/get_firebase_data.dart';

class MockFirebaseRoomService extends Mock implements FirebaseRoomService {
  @override
  Stream<String> getRoomValueStream(String roomId) {
    return super.noSuchMethod(Invocation.method(#getRoomValueStream, [roomId]),
        returnValue: Stream.fromIterable(['null']),
        returnValueForMissingStub: Stream.fromIterable(['null']));
  }
}

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
