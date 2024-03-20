import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:openrooms/get_firebase_data.dart';

/// This file defines the `MapPage` StatefulWidget, which is responsible for displaying
/// a dynamic map image indicating the status of various rooms managed by the `FirebaseRoomService`.
/// The map updates in real-time to reflect the availability status (available, unavailable, or offline)
/// of each room based on data streamed from Firebase.
///
/// Features:
/// - Real-time room status updates: Listens to changes in room availability and updates the UI accordingly.
/// - Dynamic map rendering: Adjusts the displayed map image based on the current room statuses.
/// - Resource management: Properly subscribes to and unsubscribes from Firebase streams to manage app resources efficiently.

class MapPage extends StatefulWidget {
  final FirebaseRoomService firebaseRoomService;

  const MapPage({super.key, required this.firebaseRoomService});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String room1Value = 'null';
  String room2Value = 'null';
  String room3Value = 'null';
  late String mapImageName;

  late StreamSubscription<String> _subscriptionRoom1;
  late StreamSubscription<String> _subscriptionRoom2;
  late StreamSubscription<String> _subscriptionRoom3;

  @override
  // Get Room statuses
  void initState() {
    super.initState();

    _subscriptionRoom1 =
        widget.firebaseRoomService.getRoomValueStream('room1').listen((value) {
      setState(() => room1Value = value);
      _updateMapImageName();
    });

    _subscriptionRoom2 =
        widget.firebaseRoomService.getRoomValueStream('room2').listen((value) {
      setState(() => room2Value = value);
      _updateMapImageName();
    });

    _subscriptionRoom3 =
        widget.firebaseRoomService.getRoomValueStream('room3').listen((value) {
      setState(() => room3Value = value);
      _updateMapImageName();
    });
  }

  @override
  void dispose() {
    _subscriptionRoom1.cancel();
    _subscriptionRoom2.cancel();
    _subscriptionRoom3.cancel();
    super.dispose();
  }

  // Make file name for correct map PNG
  void _updateMapImageName() {
    mapImageName =
        'map${_mapRoomValue(room1Value)}${_mapRoomValue(room2Value)}${_mapRoomValue(room3Value)}.png';
  }

  // Convert Room values to Map values
  String _mapRoomValue(String? roomValue) {
    if (roomValue == 'null') {
      return 'N'; // Null -> Offline
    } else if (roomValue == '0') {
      return '0'; // 0 -> Available
    } else {
      return '1'; // Occupied for all other values
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Map', style: TextStyle(fontSize: 30)),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            // Map image
            Positioned.fill(
              child: Image.asset(
                'lib/assets/images/$mapImageName',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
