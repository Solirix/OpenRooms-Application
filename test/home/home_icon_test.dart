import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/main.dart'; // Replace with the correct import for your main file
import 'package:openrooms/home.dart'; // Replace with the correct import for your home file
import 'package:openrooms/firebase_options.dart';
import 'package:openrooms/tab_bar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database_mocks/firebase_database_mocks.dart';

void main() {
  FirebaseDatabase firebaseDatabase;

  // initialize firebase
  setUpAll(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  MockFirebaseDatabase.instance.reference().child('room1').set('null');
    setUp(() {
    firebaseDatabase = MockFirebaseDatabase.instance;
  });

testWidgets('Click home page icon', (tester) async {
    // Create a test widget
    await tester.pumpWidget(
      CupertinoApp(
        home: CupertinoTabBarBottom(),
      ),
    );

    // Tap the home icon
    await tester.tap(find.byIcon(CupertinoIcons.house_fill));
    await tester.pumpAndSettle();

    // Expect to find the home page
    expect(find.byType(HomePage), findsOneWidget);
    
  });
}