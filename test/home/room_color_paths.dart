import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database_mocks/firebase_database_mocks.dart';
import 'package:flutter/cupertino.dart';
import 'package:openrooms/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:openrooms/firebase_options.dart';

void main() {
  //initialize Firebase
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  testWidgets('Color changes based on room values',
      (WidgetTester tester) async {
    // Mock Firebase Database
    final mockDatabase = MockFirebaseDatabase();
    DatabaseReference refRoom1 = mockDatabase.reference().child('room1');
    DatabaseReference refRoom2 = mockDatabase.reference().child('room2');
    DatabaseReference refRoom3 = mockDatabase.reference().child('room3');

    // Set initial values for rooms
    await refRoom1.set('0'); // Available
    await refRoom2.set('1'); // Unavailable
    await refRoom3.set(null); // Offline

    // Pump the HomePage widget
    await tester.pumpWidget(const CupertinoApp(home: HomePage()));

    // Find ClipRRect widgets for each room
    final room1ClipRRect =
        tester.widget<ClipRRect>(find.byKey(Key('room1ClipRRect')));
    final room2ClipRRect =
        tester.widget<ClipRRect>(find.byKey(Key('room2ClipRRect')));
    final room3ClipRRect =
        tester.widget<ClipRRect>(find.byKey(Key('room3ClipRRect')));

    // Check the colors
    expect((room1ClipRRect.child as Container).color,
        equals(CupertinoColors.activeGreen));
    expect((room2ClipRRect.child as Container).color,
        equals(CupertinoColors.systemRed));
    expect((room3ClipRRect.child as Container).color,
        equals(CupertinoColors.inactiveGray));
  });
}
