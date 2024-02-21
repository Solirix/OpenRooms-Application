import 'package:flutter/cupertino.dart';
import 'package:openrooms/hourly_occupancy.dart';
import 'dart:async';
import 'package:openrooms/get_firebase_data.dart';
import 'package:openrooms/disclaimer.dart';

/// The HomePage class is a StatefulWidget that serves as the main screen of the app.
/// It displays real-time information about various rooms' availability and allows navigation
/// to more detailed occupancy information. It integrates Firebase data fetching and user interaction
/// through a clean and intuitive Cupertino (iOS-style) UI.
///
/// Features:
/// - Displays real-time status (available, unavailable, offline) of multiple rooms.
/// - Allows users to navigate to detailed hourly occupancy information for each room.
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

  late StreamSubscription<String> _subscriptionRoom1;
  late StreamSubscription<String> _subscriptionRoom2;
  late StreamSubscription<String> _subscriptionRoom3;

  // RoomStatus? room1Value;
  // RoomStatus? room2Value;
  // RoomStatus? room3Value;

  // late StreamSubscription<RoomStatus> _subscriptionRoom1;
  // late StreamSubscription<RoomStatus> _subscriptionRoom2;
  // late StreamSubscription<RoomStatus> _subscriptionRoom3;

  @override
  void initState() {
    super.initState();

    // display the disclaimer dialog
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool isFirstLaunch = await AppUtils.isFirstLaunch();
      if (isFirstLaunch) {
        // delay the dialog to show 1 second after the home page loads
        Future.delayed(const Duration(seconds: 1), () {
          showCupertinoDialog(
            context: context,
            builder: (context) => const DisclaimerDialog(),
          );
        });
      }

      // The following subscriptions are set up after the first launch check,
      // which is correct as these operations are not immediately related to the UI rendering.
      _subscriptionRoom1 = widget.firebaseRoomService
          .getRoomValueStream('room1')
          .listen((value) {
        //print('Room 1 Changed at ${value.timestamp}');
        setState(() => room1Value = value);
      });

      _subscriptionRoom2 = widget.firebaseRoomService
          .getRoomValueStream('room2')
          .listen((value) {
        setState(() => room2Value = value);
      });

      _subscriptionRoom3 = widget.firebaseRoomService
          .getRoomValueStream('room3')
          .listen((value) {
        setState(() => room3Value = value);
      });
    });
  }

  @override
  void dispose() {
    // Stops listening to room updates to avoid unnecessary work and free up resources.
    _subscriptionRoom1.cancel();
    _subscriptionRoom2.cancel();
    _subscriptionRoom3.cancel();
    super.dispose();
  }

  //navigate to the hourly occupancy page if the room is not offline
  void navigateIfDataExists(String? roomValue, BuildContext context) {
    if (roomValue != "null") {
      Navigator.of(context).push(
        CupertinoPageRoute<void>(
          builder: (BuildContext context) {
            return const HourlyOccupancy(); // Replace with the appropriate page
          },
        ),
      );
    }
  }

  // display the chevron and text for available rooms
  Widget? roomAdditionalInfo(String? roomValue) {
    if (roomValue == "null") {
      // Return null if the roomValue is null (indicating offline)
      return null;
    } else {
      // Return the chevron and text for available or unavailable rooms
      return const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Occupancy data'),
          CupertinoListTileChevron(),
        ],
      );
    }
  }

  //navigate to the hourly occupancy page if the room is not offline
  // void navigateIfDataExists(RoomStatus? roomValue, BuildContext context) {
  //   if (roomValue != null && roomValue.value != "null") {
  //     Navigator.of(context).push(
  //       CupertinoPageRoute<void>(
  //         builder: (BuildContext context) {
  //           return const HourlyOccupancy(); // Replace with the appropriate page
  //         },
  //       ),
  //     );
  //   }
  // }

  // // display the chevron and text for available rooms
  // Widget? roomAdditionalInfo(RoomStatus? roomValue) {
  //   if (roomValue == null || roomValue.value == "null") {
  //     // Return null if the roomValue is null (indicating offline)
  //     return null;
  //   } else {
  //     // Return the chevron and text for available or unavailable rooms
  //     return const Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Text('Occupancy data'),
  //         CupertinoListTileChevron(),
  //       ],
  //     );
  //   }
  // }

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
                title: const Text('Room 1', style: TextStyle(fontSize: 23)),
                subtitle: Text(getRoomStatus(room1Value),
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
                      color: getRoomColor(room1Value), //Sets color to appropriate value based on data pulled from firebase
                    ),
                  ),
                ),
                additionalInfo: roomAdditionalInfo(room1Value),
                onTap: () => navigateIfDataExists(room1Value, context),
              ),
              CupertinoListTile.notched(
                title: const Text('Room 2', style: TextStyle(fontSize: 23)),
                subtitle: Text(getRoomStatus(room2Value),
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
                      color: getRoomColor(room2Value), //Sets color to appropriate value based on data pulled from firebase
                    ),
                  ),
                ),
                //additionalInfo: const Text('Not available'),
                additionalInfo: roomAdditionalInfo(room2Value),
                onTap: () => navigateIfDataExists(room2Value, context),
              ),
              CupertinoListTile.notched(
                title: const Text('Room 3', style: TextStyle(fontSize: 23)),
                subtitle: Text(getRoomStatus(room3Value),
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
                      color: getRoomColor(room3Value), //Sets color to appropriate value based on data pulled from firebase
                    ),
                  ),
                ),
                additionalInfo: roomAdditionalInfo(room3Value),
                onTap: () => navigateIfDataExists(room3Value, context),
              ),
            ],
          ),
        ));
  }
}

// set the rooms subtitle
String getRoomStatus(String roomValue) {
  if (roomValue == "null") {
    return 'Offline';
  } else if (roomValue == '0') {
    return 'Available';
  } else {
    return 'Unavailable';
  }
}

// Set the room's subtitle
// String getRoomStatus(RoomStatus? roomValue) {
//   if (roomValue == null || roomValue.value == "null") {
//     return 'Offline';
//   } else if (roomValue.value == '0') {
//     return 'Available';
//   } else {
//     return 'Unavailable';
//   }
// }

//set the rooms color
Color getRoomColor(String? roomValue) {
  if (roomValue == "null") {
    return CupertinoColors.inactiveGray; // Grey color for 'null' (offline)
  } else if (roomValue == '0') {
    return CupertinoColors.activeGreen; // Green color for '0' (available)
  } else {
    return CupertinoColors.systemRed; // Red color for values > 0 (unavailable)
  }
}

// Set the room's color
// Color getRoomColor(RoomStatus? roomValue) {
//   if (roomValue == null || roomValue.value == "null") {
//     return CupertinoColors.inactiveGray; // Grey color for 'null' (offline)
//   } else if (roomValue.value == '0') {
//     return CupertinoColors.activeGreen; // Green color for '0' (available)
//   } else {
//     return CupertinoColors.systemRed; // Red color for values > 0 (unavailable)
//   }
// }
