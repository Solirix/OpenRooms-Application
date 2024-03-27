import 'package:flutter/cupertino.dart';

// This file contains utility functions that are used across multiple pages in the Open Rooms app.

// function for occupancy page to get color by using status
class OccupancyUtils {
  static Color getStatusColor(String status) {
    switch (status) {
      case 'available':
        return CupertinoColors.activeGreen;
      case 'unavailable':
        return CupertinoColors.systemRed;
      case 'offline':
      default:
        return CupertinoColors.inactiveGray;
    }
  }
}

// functions for home page to get room status and color
class HomeUtils {
  static String getRoomStatus(String roomValue) {
    if (roomValue == "null") {
      return 'Offline';
    } else if (roomValue == '0') {
      return 'Available';
    } else {
      return 'Unavailable';
    }
  }

  static Color getRoomColor(String? roomValue) {
    if (roomValue == "null") {
      return CupertinoColors.inactiveGray; // Grey color for 'null' (offline)
    } else if (roomValue == '0') {
      return CupertinoColors.activeGreen; // Green color for '0' (available)
    } else {
      return CupertinoColors
          .systemRed; // Red color for values > 0 (unavailable)
    }
  }
}

// widget for additional info in home page
Widget? createRoomAdditionalInfo(String? roomValue) {
  if (roomValue == "null") {
    return null;
  } else {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Historical data'),
        CupertinoListTileChevron(),
      ],
    );
  }
}
