import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openrooms/settings.dart';
import 'package:provider/provider.dart';
import 'package:openrooms/themeProvider.dart';

void main() {
  testWidgets('Find home icon and click it to go to home page', (tester) async {
    // navigate to the tab widget
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(), // Provide the necessary provider
        child: const CupertinoApp(
          home: SettingsPage(),
        ),
      ),
    );

    //find the dislcaimer text and tap it
    await tester.tap(find.text('Legal Disclaimer'));
    await tester.pumpAndSettle();

    expect(find.byType(LegalDisclaimerPage), findsOneWidget);

    //tap the ok button
    await tester.tap(find.text('Ok'));
    await tester.pumpAndSettle();

    // expect to find the settings page
    expect(find.byType(SettingsPage), findsOneWidget);
  });
}
