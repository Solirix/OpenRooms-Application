import 'package:flutter/cupertino.dart';

class SettingsPage extends StatelessWidget {
  final String title;

  const SettingsPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
          child: SafeArea(
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 48),
          ),
        ),
      ));
}
