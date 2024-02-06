import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/cupertino.dart';
import 'package:openrooms/home.dart';
import 'package:openrooms/main.dart';
import 'package:openrooms/get_firebase_data.dart';

// Create a mock class for FirebaseRoomService that returns predefined values since the values are not important for this test
class MockFirebaseRoomService extends Mock implements FirebaseRoomService {
  @override
  Stream<String> getRoomValueStream(String roomId) {
    return super.noSuchMethod(Invocation.method(#getRoomValueStream, [roomId]),
        returnValue: Stream.fromIterable(['null']),
        returnValueForMissingStub: Stream.fromIterable(['null']));
  }
}

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

    // Perform your test actions
    final homeIcon = find.byIcon(CupertinoIcons.house_fill);
    expect(homeIcon, findsOneWidget);
    await widgetTester.tap(homeIcon);
    await widgetTester.pumpAndSettle();

    //expect to find the home widget
    expect(find.byType(HomePage), findsOneWidget);
  });
}
