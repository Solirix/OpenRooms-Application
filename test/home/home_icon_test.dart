import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/main.dart';
import 'package:openrooms/home.dart';

void main() {
  testWidgets('Find home icon and click it to go to home page', (tester) async {
    // navigate to the tab widget
    await tester.pumpWidget(const CupertinoApp(
      home: CupertinoTabBarBottom(),
    ));

    // find the home icon and tap it
    await tester.tap(find.byIcon(CupertinoIcons.house_fill));
    await tester.pump();

    // expect to find the home page, with some text that is on it (Home, Room 1)
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Room 1'), findsOneWidget);
  });
}
