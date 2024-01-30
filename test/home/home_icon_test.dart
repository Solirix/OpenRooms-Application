import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/main.dart';
import 'package:openrooms/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:openrooms/firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    // initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  testWidgets('Find home icon and click it to go to home page', (tester) async {
    // Rest of your test code
    await tester.pumpWidget(const CupertinoApp(
      home: CupertinoTabBarBottom(),
    ));

    // Find the home icon and tap it
    await tester.tap(find.byIcon(CupertinoIcons.house_fill));
    await tester.pumpAndSettle();

    // expect to find the home page
    expect(find.byType(HomePage), findsOneWidget);
  });
}

