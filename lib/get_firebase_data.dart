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
