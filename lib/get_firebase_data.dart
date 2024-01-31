import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class FirebaseRoomService {
  final FirebaseDatabase firebaseDatabase;

  FirebaseRoomService({required this.firebaseDatabase});

  Stream<String> getRoomValueStream(String roomId) {
    DatabaseReference roomRef = firebaseDatabase.ref().child(roomId);
    return roomRef.onValue.map((event) => event.snapshot.value.toString());
  }
}
