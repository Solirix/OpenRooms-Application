import 'package:flutter/cupertino.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Map', style: TextStyle(fontSize: 30)),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            // Background map image
            Positioned(
              left: 5,
              right: 5,
              top: 5,
              bottom: 5,
              child: Image.asset(
                //'lib/assets/images/map1.png',
                'lib/assets/images/mapF1.png',
                //fit: BoxFit.fill,
              ),
            ),

            // Specific room overlays
            // Replace with actual data and positions
//            Positioned(
//              left: 122, // Example X position
//              top: 83, // Example Y position
//              child: Image.asset(
//                _getRoomStatusImage1('Available'),
//                width: 120,
//              ),
//            ),
//            Positioned(
//              left: 369, // Example X position
//              top: 83, // Example Y position
//              child: Image.asset(
//                _getRoomStatusImage2('Offline'),
//                width: 120,
//              ),
//            ),
//            Positioned(
//              left: 369, // Example X position
//              top: 610, // Example Y position
//              child: Image.asset(
//                _getRoomStatusImage3('Not Available'),
//                width: 120,
//              ),
//             ),
          ],
        ),
      ),
    );
  }

  // String _getRoomStatusImage1(String status) {
  //   switch (status) {
  //     case 'Available':
  //       return 'lib/assets/images/available1.png';
  //     case 'Offline':
  //       return 'lib/assets/images/offline1.png';
  //     case 'Not Available':
  //     default:
  //       return 'lib/assets/images/not_available1.png';
  //   }
  // }

  // String _getRoomStatusImage2(String status) {
  //   switch (status) {
  //     case 'Available':
  //       return 'lib/assets/images/available2.png';
  //     case 'Offline':
  //       return 'lib/assets/images/offline2.png';
  //     case 'Not Available':
  //     default:
  //       return 'lib/assets/images/not_available2.png';
  //   }
  // }

  // String _getRoomStatusImage3(String status) {
  //   switch (status) {
  //     case 'Available':
  //       return 'lib/assets/images/available3.png';
  //     case 'Offline':
  //       return 'lib/assets/images/offline3.png';
  //     case 'Not Available':
  //     default:
  //       return 'lib/assets/images/not_available3.png';
  //   }
  // }
}
