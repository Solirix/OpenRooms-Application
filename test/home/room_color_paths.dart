import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/home.dart';
import 'package:mockito/mockito.dart';
import 'package:openrooms/get_firebase_data.dart';
import 'package:openrooms/utils.dart';

class MockFirebaseRoomService extends Mock implements FirebaseRoomService {
  @override
  Stream<String> getRoomValueStream(String roomId) {
    return super.noSuchMethod(Invocation.method(#getRoomValueStream, [roomId]),
        returnValue: Stream.fromIterable(['null']),
        returnValueForMissingStub: Stream.fromIterable(['null']));
  }
}

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

    expect(HomeUtils.getRoomColor('0'), equals(CupertinoColors.activeGreen));
    expect(HomeUtils.getRoomColor('1'), equals(CupertinoColors.systemRed));
    expect(
        HomeUtils.getRoomColor('null'), equals(CupertinoColors.inactiveGray));
  });

  //expect room1 color to be green
  // expect(
  //   tester.widget<Container>(find.byKey(const Key('room1'))).color,
  //   equals(CupertinoColors.activeGreen),
  // );

  // //expect room2 color to be red
  // expect(
  //   tester.widget<Container>(find.byKey(const Key('room2'))).color,
  //   CupertinoColors.systemRed,
  // );

  // //expect room3 color to be grey
  // expect(
  //   tester.widget<Container>(find.byKey(const Key('room3'))).color,
  //   CupertinoColors.inactiveGray,
  // );
}
