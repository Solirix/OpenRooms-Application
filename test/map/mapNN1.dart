import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/cupertino.dart';
import 'package:openrooms/map.dart';
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
  testWidgets('find home icon and click it', (tester) async {
    final mockService = MockFirebaseRoomService();

    when(mockService.getRoomValueStream('room1'))
        .thenAnswer((_) => Stream.fromIterable(['null']));
    when(mockService.getRoomValueStream('room2'))
        .thenAnswer((_) => Stream.fromIterable(['null']));
    when(mockService.getRoomValueStream('room3'))
        .thenAnswer((_) => Stream.fromIterable(['1']));

    await tester.pumpWidget(CupertinoApp(
      home: MapPage(firebaseRoomService: mockService),
    ));

    await tester.pumpAndSettle();

    // Check if the correct PNG is displayed
    final imageFinder = find.byType(Image);
    final Image image = tester.widget(imageFinder) as Image;
    expect(imageFinder, findsOneWidget);
    expect(
        (image.image as AssetImage).assetName, 'lib/assets/images/map000.png');
  });
}
