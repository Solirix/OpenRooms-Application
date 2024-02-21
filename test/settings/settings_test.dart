import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/settings.dart';
import 'package:provider/provider.dart';
import 'package:openrooms/themeProvider.dart';
import 'package:openrooms/main.dart';
import 'package:mockito/mockito.dart';
import 'package:openrooms/get_firebase_data.dart';

/// This test file focuses on verifying the functionality and UI of the SettingsPage,
/// as well as the accessibility of the SettingsPage through the settings icon from the main navigation. It employs
/// `flutter_test` for widget testing and `provider` for state management, along with `mockito` for mocking external
/// dependencies. These tests ensure that the user can interact with the theme selection options (System, Light, Dark)
/// on the SettingsPage and that the settings icon correctly navigates to the SettingsPage.


// Create a mock class for FirebaseRoomService that returns predefined values since the values are not important for this test
class MockFirebaseRoomService extends Mock implements FirebaseRoomService {
  @override
  Stream<String> getRoomValueStream(String roomId) {
    return super.noSuchMethod(Invocation.method(#getRoomValueStream, [roomId]),
        returnValue: Stream.fromIterable(['null']),
        returnValueForMissingStub: Stream.fromIterable(['null']));
  }
}

// Main function that contains all tests
void main() {
  testWidgets('SettingsPage UI test', (WidgetTester tester) async {
    // Wrap the SettingsPage with the necessary Provider
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(), // Provide the necessary provider
        child: const CupertinoApp(
          home: SettingsPage(),
        ),
      ),
    );

    // Perform a tap on the System button (value 0).
    await tester.tap(find.text('System'));
    await tester.pump();

    // Perform a tap on the Light button (value 1).
    await tester.tap(find.text('Light'));
    await tester.pump();

    // Perform a tap on the Dark button (value 2).
    await tester.tap(find.text('Dark'));
    await tester.pump();
  });
  testWidgets('Settings Icon UI Test', (WidgetTester tester) async {
    // Create a mock FirebaseRoomService
    final  mockService = MockFirebaseRoomService();

    // Setup mock responses with type specified
    when(mockService.getRoomValueStream('room1'))
        .thenAnswer((_) => Stream.fromIterable(['null']));
    when(mockService.getRoomValueStream('room2'))
        .thenAnswer((_) => Stream.fromIterable(['null']));
    when(mockService.getRoomValueStream('room3'))
        .thenAnswer((_) => Stream.fromIterable(['null']));

    //Test Settings Icon
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(), // Provide the necessary provider
        child:  CupertinoApp(
          home: CupertinoTabBarBottom(firebaseRoomService: mockService),
        ),
      ),
    );
    //Expect to be able to find and tap settings icon
    final settingsGear = find.byIcon(CupertinoIcons.gear_alt_fill);
    expect(settingsGear, findsOneWidget);
    await tester.tap(settingsGear);
    await tester.pumpAndSettle();
    expect(find.byType(SettingsPage), findsOneWidget);

  });
}
