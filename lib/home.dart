import 'package:flutter/cupertino.dart';
import 'package:openrooms/hourly_occupancy.dart';
import 'dart:async';
import 'package:openrooms/get_firebase_data.dart';
import 'package:openrooms/utils.dart';

/// The HomePage class is a StatefulWidget that serves as the main screen of the app.
/// It displays real-time information about various rooms' availability and allows navigation
/// to more detailed occupancy information. It integrates Firebase data fetching and user interaction
/// through a clean and intuitive Cupertino (iOS-style) UI.
///
/// Features:
/// - Displays real-time status (available, unavailable, offline) of multiple rooms.
/// - Allows users to navigate to detailed historical data information for each room.
/// - Automatically shows a disclaimer dialog on the first app launch.

class HomePage extends StatefulWidget {
  final FirebaseRoomService firebaseRoomService;

  const HomePage({super.key, required this.firebaseRoomService});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  String room1Value = 'null';
  String room2Value = 'null';
  String room3Value = 'null';
  String room4Value = 'null';
  String room5Value = 'null';

  // Subscriptions to listen for real-time updates from Firebase
  StreamSubscription<String>? _subscriptionRoom1;
  StreamSubscription<String>? _subscriptionRoom2;
  StreamSubscription<String>? _subscriptionRoom3;
  StreamSubscription<String>? _subscriptionRoom4;
  StreamSubscription<String>? _subscriptionRoom5;

  @override
  void initState() {
    super.initState();

    // Set up listeners to update room status in real-time
    _subscriptionRoom1 =
        widget.firebaseRoomService.getRoomValueStream('room1').listen((value) {
      setState(() => room1Value = value);
    });

    _subscriptionRoom2 =
        widget.firebaseRoomService.getRoomValueStream('room2').listen((value) {
      setState(() => room2Value = value);
    });

    _subscriptionRoom3 =
        widget.firebaseRoomService.getRoomValueStream('room3').listen((value) {
      setState(() => room3Value = value);
    });
    
    _subscriptionRoom4 =
        widget.firebaseRoomService.getRoomValueStream('room4').listen((value) {
      setState(() => room4Value = value);
    });

    _subscriptionRoom5 =
        widget.firebaseRoomService.getRoomValueStream('room5').listen((value) {
      setState(() => room5Value = value);
    });
  }

  // Stops listening to room updates to avoid unnecessary work and free up resources
  @override
  void dispose() {
    _subscriptionRoom1?.cancel();
    _subscriptionRoom2?.cancel();
    _subscriptionRoom3?.cancel();
    _subscriptionRoom4?.cancel();
    _subscriptionRoom5?.cancel();
    super.dispose();
  }

  //navigate to the hourly occupancy page if the room is not offline
  void navigateIfDataExists(
      String? roomValue, BuildContext context, String roomId) {
    if (roomValue != "null") {
      Navigator.of(context).push(
        CupertinoPageRoute<void>(
          builder: (BuildContext context) {
            return HourlyOccupancy(
                roomId: roomId,
                firebaseRoomService: widget.firebaseRoomService);
          },
        ),
      );
    }
  }

  // Creates a CupertinoListTile widget to display the rooms and their availability status.
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Home', style: TextStyle(fontSize: 30)),
        ),
        child: SafeArea(
          child: CupertinoListSection.insetGrouped(
            children: <CupertinoListTile>[
              CupertinoListTile.notched(
                key: const Key('tile1'),
                title: const Text('W210', style: TextStyle(fontSize: 23)),
                subtitle: Text(HomeUtils.getRoomStatus(room1Value),
                    style: const TextStyle(fontSize: 15)),
                leading: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      key: const Key('room1'),
                      width: 25.0,
                      height: 25.0,
                      color: HomeUtils.getRoomColor(
                          room1Value), //Sets color to appropriate value based on data pulled from firebase
                    ),
                  ),
                ),
                additionalInfo: createRoomAdditionalInfo(room1Value),
                onTap: () => navigateIfDataExists(room1Value, context, 'room1'),
              ),
              CupertinoListTile.notched(
                key: const Key('title2'),
                title: const Text('W211', style: TextStyle(fontSize: 23)),
                subtitle: Text(HomeUtils.getRoomStatus(room2Value),
                    style: const TextStyle(fontSize: 15)),
                leading: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      key: const Key('room2'),
                      width: 25.0,
                      height: 25.0,
                      color: HomeUtils.getRoomColor(
                          room2Value), //Sets color to appropriate value based on data pulled from firebase
                    ),
                  ),
                ),
                //additionalInfo: const Text('Not available'),
                additionalInfo: createRoomAdditionalInfo(room2Value),
                onTap: () => navigateIfDataExists(room2Value, context, 'room2'),
              ),
              CupertinoListTile.notched(
                key: const Key('title3'),
                title: const Text('W214', style: TextStyle(fontSize: 23)),
                subtitle: Text(HomeUtils.getRoomStatus(room3Value),
                    style: const TextStyle(fontSize: 15)),
                leading: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      key: const Key('room3'),
                      width: 25.0,
                      height: 25.0,
                      color: HomeUtils.getRoomColor(
                          room3Value), //Sets color to appropriate value based on data pulled from firebase
                    ),
                  ),
                ),
                additionalInfo: createRoomAdditionalInfo(room3Value),
                onTap: () => navigateIfDataExists(room3Value, context, 'room3'),
              ),
              CupertinoListTile.notched(
                key: const Key('title4'),
                title: const Text('Luparello', style: TextStyle(fontSize: 23)),
                subtitle: Text(HomeUtils.getRoomStatus(room4Value),
                    style: const TextStyle(fontSize: 15)),
                leading: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      key: const Key('room4'),
                      width: 25.0,
                      height: 25.0,
                      color: HomeUtils.getRoomColor(
                          room4Value), //Sets color to appropriate value based on data pulled from firebase
                    ),
                  ),
                ),
                additionalInfo: createRoomAdditionalInfo(room4Value),
                onTap: () => navigateIfDataExists(room4Value, context, 'room4'),
              ),
              CupertinoListTile.notched(
                key: const Key('title5'),
                title: const Text('Demo', style: TextStyle(fontSize: 23)),
                subtitle: Text(HomeUtils.getRoomStatus(room5Value),
                    style: const TextStyle(fontSize: 15)),
                leading: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      key: const Key('room5'),
                      width: 25.0,
                      height: 25.0,
                      color: HomeUtils.getRoomColor(
                          room5Value), //Sets color to appropriate value based on data pulled from firebase
                    ),
                  ),
                ),
                additionalInfo: createRoomAdditionalInfo(room5Value),
                onTap: () => navigateIfDataExists(room5Value, context, 'room5'),
              ),
            ],
          ),
        ));
  }
}
