import 'package:flutter/cupertino.dart';
//import 'package:firebase_database/firebase_database.dart';

class MapPage extends StatelessWidget {
  final String title;

  const MapPage({super.key, required this.title});

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
