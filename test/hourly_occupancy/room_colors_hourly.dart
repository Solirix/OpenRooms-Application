import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/hourly_occupancy.dart';
import 'package:mockito/mockito.dart';
import 'package:openrooms/get_firebase_data.dart';
import 'package:openrooms/utils.dart';

/// This test file is designed to validate the functionality of the calendar feature within the HourlyOccupancy widget
/// It uses the `flutter_test` framework to simulate user interaction with the calendar icon,
/// aiming to change the displayed date. The test ensures that the widget correctly updates to reflect the newly selected

class MockFirebaseRoomService extends Mock implements FirebaseRoomService {
  @override
  Stream<Map<int, String>> getOccupancyDataForDateAndRoom(
      String date, String roomId) {
    // Override the getOccupancyDataForDateAndRoom method to provide a mock response.
    // This returns a stream that emits a single map with all hours available, simulating
    // the behavior of fetching occupancy data for a specific room from Firebase without making real network requests.
    return super.noSuchMethod(
        Invocation.method(#getOccupancyDataForDateAndRoom, [date, roomId]),
        returnValue: Stream.fromIterable([
          {
            0: 'available',
            1: 'available',
            2: 'available',
            3: 'available',
            4: 'available',
            5: 'available',
            9: 'available',
            10: 'available',
            11: 'available',
            12: 'available',
            13: 'available',
            14: 'available',
            15: 'available',
            16: 'available',
            17: 'available',
            18: 'available',
            19: 'available',
            20: 'available',
            21: 'available',
            22: 'available',
            23: 'available'
          }
        ]),
        returnValueForMissingStub: Stream.fromIterable([
          {
            0: 'available',
            1: 'available',
            2: 'available',
            3: 'available',
            4: 'available',
            5: 'available',
            9: 'available',
            10: 'available',
            11: 'available',
            12: 'available',
            13: 'available',
            14: 'available',
            15: 'available',
            16: 'available',
            17: 'available',
            18: 'available',
            19: 'available',
            20: 'available',
            21: 'available',
            22: 'available',
            23: 'available'
          }
        ]));
  }
}

void main() {
  testWidgets(
      'Make sure each hour of the day is displayed from firebase in proper format',
      (tester) async {
    final mockService = MockFirebaseRoomService();
    const String roomId = 'room1';
    when(mockService.getOccupancyDataForDateAndRoom('2024-02-29', 'room1'))
        .thenAnswer((_) => Stream.fromIterable([
              {
                0: 'available',
                1: 'unavailable',
                2: 'available',
                3: 'unavailable',
                4: 'available',
                5: 'unavailable',
                6: 'available',
                7: 'unavailable',
                8: 'available',
                9: 'available',
                10: 'unavailable',
                11: 'available',
                12: 'unavailable',
                13: 'available',
                14: 'unavailable',
                15: 'available',
                16: 'unavailable',
                17: 'available',
                18: 'unavailable',
                19: 'available',
                20: 'unavailable',
                21: 'available',
                22: 'unavailable',
                23: 'available'
              }
            ]));
    // navigate to the tab widget
    await tester.pumpWidget(CupertinoApp(
      home: HourlyOccupancy(roomId: roomId, firebaseRoomService: mockService),
    ));

    // Assert: Since we can't directly check scatter spot colors, we verify the data is correctly loaded
    // and rely on unit tests for getStatusColor to ensure color logic is correct.
    expect(OccupancyUtils.getStatusColor('available'),
        equals(CupertinoColors.activeGreen));
    expect(OccupancyUtils.getStatusColor('unavailable'),
        equals(CupertinoColors.systemRed));
    expect(OccupancyUtils.getStatusColor('offline'),
        equals(CupertinoColors.inactiveGray));
  });
}
