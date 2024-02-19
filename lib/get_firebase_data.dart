import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

//this class will be used to get the data from the firebase database
class FirebaseRoomService {
  final FirebaseDatabase firebaseDatabase;

  FirebaseRoomService({required this.firebaseDatabase});

  Stream<String> getRoomValueStream(String roomId) {
    DatabaseReference roomRef = firebaseDatabase.ref().child(roomId);
    return roomRef.onValue.map((event) => event.snapshot.value.toString());
  }

  Stream<Map<int, String>> getOccupancyDataForDateAndRoom(
      String date, String roomId) {
    DatabaseReference dateRoomRef =
        firebaseDatabase.ref().child('occupancy').child(date).child(roomId);
    return dateRoomRef.onValue.map((event) {
      // The value can be a Map or a List
      final value = event.snapshot.value;
      Map<int, String> hourData = {};
      if (value is Map) {
        value.forEach((key, val) {
          final hour = int.tryParse(key.toString());
          if (hour != null) {
            hourData[hour] = val.toString();
          }
        });
      } else if (value is List) {
        // Convert List to Map
        for (int i = 0; i < value.length; i++) {
          if (value[i] != null) {
            hourData[i] = value[i].toString();
          }
        }
      }
      return hourData;
    });
  }
}


// import 'dart:async';
// import 'package:firebase_database/firebase_database.dart';

// class RoomStatus {
//   String value;
//   DateTime timestamp;

//   RoomStatus(this.value, this.timestamp);
// }

// class FirebaseRoomService {
//   final FirebaseDatabase firebaseDatabase;

//   FirebaseRoomService({required this.firebaseDatabase});

//   Stream<RoomStatus> getRoomValueStream(String roomId) {
//     DatabaseReference roomRef = firebaseDatabase.ref().child(roomId);
//     return roomRef.onValue.map((event) {
//       final value = event.snapshot.value.toString();
//       final timestamp = DateTime.now(); // Get the current time
//       return RoomStatus(
//           value, timestamp); // Return both the value and the timestamprqffdsafdsafdafafdsafedfdsgfasgfsagfdsgfsdhfhdjkugki76ik7tktkutjkrhnehtrghtwegtwe
//     });
//   }
// }
