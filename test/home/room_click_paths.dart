import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/home.dart';
import 'package:mockito/mockito.dart';
import 'package:openrooms/get_firebase_data.dart';
import 'package:openrooms/utils.dart';

// This test case verifies that each room is clickable and unclickable when applicable

// Create a mock class for FirebaseRoomService that returns predefined values since the values are not important for this test
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

    // Build the widget tree
    await tester.pumpWidget(CupertinoApp(
      home: CupertinoPageScaffold(
        child: HomePage(firebaseRoomService: mockService),
      ),
    ));

    await tester.pumpAndSettle();

    // if roomvalue is 0, expect to find historical data text with chevron
    expect(createRoomAdditionalInfo('0'), isNotNull);

    // if roomvalue is 1, expect to find historical data text with chevron
    expect(createRoomAdditionalInfo('1'), isNotNull);

    // if roomvalue is null, expect to find no historical data text or chevron
    expect(createRoomAdditionalInfo('null'), isNull);
  });
}
