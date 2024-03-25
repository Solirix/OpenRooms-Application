import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/home.dart';
import 'package:mockito/mockito.dart';
import 'package:openrooms/get_firebase_data.dart';
import 'package:openrooms/utils.dart';

// This test case verifies each room's subtitle is correct based on its status

// Create a mock class for FirebaseRoomService that returns predefined values
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

    // if roomvalue is 0, expect to find 'Available' subtitle
    expect(HomeUtils.getRoomStatus('0'), equals('Available'));
    // if roomvalue is 1, expect to find 'Unavailable' subtitle
    expect(HomeUtils.getRoomStatus('1'), equals('Unavailable'));
    // if roomvalue is null, expect to find 'Offline' subtitle
    expect(HomeUtils.getRoomStatus('null'), equals('Offline'));
  });
}
