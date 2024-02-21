import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/cupertino.dart';
import 'package:openrooms/map.dart';
import 'package:openrooms/main.dart';
import 'package:openrooms/get_firebase_data.dart';

/// This file contains a widget test focused on the navigation within the OpenRooms app,
/// particularly testing the functionality of tapping the map icon and navigating to the MapPage.
/// It utilizes the `flutter_test` framework for defining and running the widget test, and `mockito`
/// for mocking the FirebaseRoomService, allowing for isolated testing of navigation behavior without
/// real data dependencies.


// Create a mock class for FirebaseRoomService that returns predefined values since the values are not important for this test
class MockFirebaseRoomService extends Mock implements FirebaseRoomService {
  @override
  Stream<String> getRoomValueStream(String roomId) {
    return super.noSuchMethod(Invocation.method(#getRoomValueStream, [roomId]),
        returnValue: Stream.fromIterable(['null']),
        returnValueForMissingStub: Stream.fromIterable(['null']));
  }
}

// Run test to make sure map icon can be found
void main() {
  testWidgets('find home icon and click it', (widgetTester) async {
    // Create a mock FirebaseRoomService
    final mockService = MockFirebaseRoomService();

    // Setup mock responses with type specified
    when(mockService.getRoomValueStream('room1'))
        .thenAnswer((_) => Stream.fromIterable(['null']));
    when(mockService.getRoomValueStream('room2'))
        .thenAnswer((_) => Stream.fromIterable(['null']));
    when(mockService.getRoomValueStream('room3'))
        .thenAnswer((_) => Stream.fromIterable(['null']));

    // Pump the widget with the mock service
    await widgetTester.pumpWidget(CupertinoApp(
      home: CupertinoTabBarBottom(firebaseRoomService: mockService),
    ));

    // Expect that map icon is found and able to be clicked
    final mapIcon = find.byIcon(CupertinoIcons.map_fill);
    expect(mapIcon, findsOneWidget);
    await widgetTester.tap(mapIcon);
    await widgetTester.pumpAndSettle();

    //expect to find the home widget
    expect(find.byType(MapPage), findsOneWidget);
  });
}
