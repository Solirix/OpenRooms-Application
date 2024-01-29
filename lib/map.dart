import 'package:flutter/cupertino.dart';
//import 'package:firebase_database/firebase_database.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
          child: SafeArea(
        child: Center(
          child: Text(
            'Map',
            style: const TextStyle(fontSize: 48),
          ),
        ),
      ));
}
