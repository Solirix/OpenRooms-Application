import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

/// This class provides a service layer for interacting with Firebase database,
/// specifically designed for operations related to room data within an application.
/// It allows fetching real-time updates for room values and occupancy data.

// Defines a service for interacting with Firebase database specific to room data.
class FirebaseRoomService {
  final FirebaseDatabase firebaseDatabase;

  // Constructor requires an instance of FirebaseDatabase to interact with Firebase.
  FirebaseRoomService({required this.firebaseDatabase});

  // Returns a stream of room values as a string for a given room ID.
  Stream<String> getRoomValueStream(String roomId) {
    // References the database location of the specified room.
    DatabaseReference roomRef = firebaseDatabase.ref().child(roomId);
    // Listens for changes at this location, converting each event to a string value.
    return roomRef.onValue.map((event) => event.snapshot.value.toString());
  }

  // Returns a stream of occupancy data as a map, given a date and room ID.
  Stream<Map<int, String>> getOccupancyDataForDateAndRoom(
      String date, String roomId) {
    // References the database location for occupancy data of a specific date and room.
    DatabaseReference dateRoomRef =
        firebaseDatabase.ref().child('occupancy').child(date).child(roomId);
    // Listens for changes at this location, processing the data into a map of hour to occupancy value.
    return dateRoomRef.onValue.map((event) {
      // The value can be a Map or a List
      final value = event.snapshot.value;
      Map<int, String> hourData = {};
      // If the value is a map, parse it directly into the hourData map.
      if (value is Map) {
        value.forEach((key, val) {
          final hour = int.tryParse(key.toString());
          if (hour != null) {
            hourData[hour] = val.toString();
          }
        });

        // If the value is a list, convert each list item into an entry in the hourData map.
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
