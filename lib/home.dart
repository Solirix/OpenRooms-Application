import 'package:flutter/cupertino.dart';
import 'package:openrooms/hourly_occupancy.dart';
import 'dart:async';
import 'package:openrooms/get_firebase_data.dart';

// class HomePage extends StatefulWidget {
//   final FirebaseDatabase firebaseDatabase;

//   const HomePage({super.key, required this.firebaseDatabase});

//   @override
//   State<HomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<HomePage> {
//   String room1Value = 'null';
//   String room2Value = 'null';
//   String room3Value = 'null';

//   late StreamSubscription<DatabaseEvent> _subscriptionRoom1;
//   late StreamSubscription<DatabaseEvent> _subscriptionRoom2;
//   late StreamSubscription<DatabaseEvent> _subscriptionRoom3;

//   @override
//   void initState() {
//     super.initState();
//     setupRoomListeners();
//   }

//   // set up the listeners for the rooms
//   void setupRoomListeners() {
//     DatabaseReference refRoom1 = FirebaseDatabase.instance.ref().child('room1');
//     DatabaseReference refRoom2 = FirebaseDatabase.instance.ref().child('room2');
//     DatabaseReference refRoom3 = FirebaseDatabase.instance.ref().child('room3');

//     _subscriptionRoom1 = refRoom1.onValue.listen((DatabaseEvent event) {
//       setState(() {
//         room1Value = event.snapshot.value.toString();
//         //print('Updated Room1 Value: $room1Value');
//       });
//     });

//     _subscriptionRoom2 = refRoom2.onValue.listen((DatabaseEvent event) {
//       setState(() {
//         room2Value = event.snapshot.value.toString();
//         //print('Updated Room2 Value: $room2Value');
//       });
//     });

//     _subscriptionRoom3 = refRoom3.onValue.listen((DatabaseEvent event) {
//       setState(() {
//         room3Value = event.snapshot.value.toString();
//         //print('Updated Room3 Value: $room3Value');
//       });
//     });
//   }

//   // cancel the listeners when we leave the page
//   @override
//   void dispose() {
//     _subscriptionRoom1.cancel();
//     _subscriptionRoom2.cancel();
//     _subscriptionRoom3.cancel();
//     super.dispose();
//   }

//   // navigate to the hourly occupancy page if the room is not offline
//   void navigateIfDataExists(String? roomValue, BuildContext context) {
//     if (roomValue != "null") {
//       Navigator.of(context).push(
//         CupertinoPageRoute<void>(
//           builder: (BuildContext context) {
//             return const HourlyOccupancy(); // Replace with the appropriate page
//           },
//         ),
//       );
//     }
//   }

//   // display the chevron and text for available rooms
//   Widget? roomAdditionalInfo(String? roomValue) {
//     if (roomValue == "null") {
//       // Return null if the roomValue is null (indicating offline)
//       return null;
//     } else {
//       // Return the chevron and text for available or unavailable rooms
//       return const Row(
//         mainAxisSize: MainAxisSize.min,
//         children: const [
//           Text('Occupancy data'),
//           CupertinoListTileChevron(),
//         ],
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//         navigationBar: const CupertinoNavigationBar(
//           middle: Text('Home', style: TextStyle(fontSize: 30)),
//         ),
//         child: SafeArea(
//           child: CupertinoListSection.insetGrouped(
//             children: <CupertinoListTile>[
//               CupertinoListTile.notched(
//                 title: const Text('Room 1', style: TextStyle(fontSize: 23)),
//                 subtitle: Text(getRoomStatus(room1Value),
//                     style: const TextStyle(fontSize: 15)),
//                 leading: SizedBox(
//                   width: double.infinity,
//                   height: double.infinity,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15.0),
//                     child: Container(
//                       width: 25.0,
//                       height: 25.0,
//                       color: getRoomColor(room1Value),
//                     ),
//                   ),
//                 ),
//                 additionalInfo: roomAdditionalInfo(room1Value),
//                 onTap: () => navigateIfDataExists(room1Value, context),
//               ),
//               CupertinoListTile.notched(
//                 title: const Text('Room 2', style: TextStyle(fontSize: 23)),
//                 subtitle: Text(getRoomStatus(room2Value),
//                     style: const TextStyle(fontSize: 15)),
//                 leading: SizedBox(
//                   width: double.infinity,
//                   height: double.infinity,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15.0),
//                     child: Container(
//                       width: 25.0,
//                       height: 25.0,
//                       color: getRoomColor(room2Value),
//                     ),
//                   ),
//                 ),
//                 //additionalInfo: const Text('Not available'),
//                 additionalInfo: roomAdditionalInfo(room2Value),
//                 onTap: () => navigateIfDataExists(room2Value, context),
//               ),
//               CupertinoListTile.notched(
//                 title: const Text('Room 3', style: TextStyle(fontSize: 23)),
//                 subtitle: Text(getRoomStatus(room3Value),
//                     style: const TextStyle(fontSize: 15)),
//                 leading: SizedBox(
//                   width: double.infinity,
//                   height: double.infinity,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15.0),
//                     child: Container(
//                       width: 25.0,
//                       height: 25.0,
//                       color: getRoomColor(room3Value),
//                     ),
//                   ),
//                 ),
//                 additionalInfo: roomAdditionalInfo(room3Value),
//                 onTap: () => navigateIfDataExists(room3Value, context),
//               ),
//             ],
//           ),
//         ));
//   }
// }

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

  @override
  void initState() {
    super.initState();

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
  }

  @override
  void dispose() {
    _subscriptionRoom1.cancel();
    _subscriptionRoom2.cancel();
    _subscriptionRoom3.cancel();
    super.dispose();
  }

  // Rest of your widget code...
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
                      color: getRoomColor(room1Value),
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
                      color: getRoomColor(room2Value),
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
                      color: getRoomColor(room3Value),
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
