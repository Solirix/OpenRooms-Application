import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

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
                subtitle:
                    const Text('Available', style: TextStyle(fontSize: 15)),
                leading: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  //color: CupertinoColors.activeGreen,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      width: 25.0,
                      height: 25.0,
                      color: CupertinoColors.activeGreen,
                    ),
                  ),
                ),
                additionalInfo: const Text('View historical occupancy data'),
                trailing: const CupertinoListTileChevron(),
                onTap: () => Navigator.of(context).push(
                  CupertinoPageRoute<void>(
                    builder: (BuildContext context) {
                      return const _SecondPage(text: 'Room 1 Data');
                    },
                  ),
                ),
              ),
              CupertinoListTile.notched(
                title: const Text('Room 2', style: TextStyle(fontSize: 23)),
                subtitle: const Text('Offline', style: TextStyle(fontSize: 15)),
                leading: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  //color: CupertinoColors.systemRed,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      width: 25.0,
                      height: 25.0,
                      color: CupertinoColors.inactiveGray,
                    ),
                  ),
                ),
                //additionalInfo: const Text('Not available'),
              ),
              CupertinoListTile.notched(
                title: const Text('Room 3', style: TextStyle(fontSize: 23)),
                subtitle:
                    const Text('Not Available', style: TextStyle(fontSize: 15)),
                leading: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  //color: CupertinoColors.activeOrange,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      width: 25.0,
                      height: 25.0,
                      color: CupertinoColors.systemRed,
                    ),
                  ),
                ),
                additionalInfo: const Text('View historical occupancy data'),
                trailing: const CupertinoListTileChevron(),
                onTap: () => Navigator.of(context).push(
                  CupertinoPageRoute<void>(
                    builder: (BuildContext context) {
                      return const _SecondPage(text: 'Room 3 Data');
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return CupertinoPageScaffold(
  //     navigationBar: const CupertinoNavigationBar(
  //       middle: Text('Home', style: TextStyle(fontSize: 30)),
  //     ),
  //     child: SafeArea(
  //         child: CupertinoListSection(
  //       children: <CupertinoListTile>[
  //         CupertinoListTile(
  //           title: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               const Padding(
  //                 padding: EdgeInsets.only(left: 20.0),
  //                 child: Text('Room 1', style: TextStyle(fontSize: 20)),
  //               ),
  //               //const Text('Room 1'),
  //               Padding(
  //                 padding: const EdgeInsets.only(right: 20.0),
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(10.0),
  //                   child: Container(
  //                     width: 25.0,
  //                     height: 25.0,
  //                     color: CupertinoColors.activeGreen,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           trailing: const CupertinoListTileChevron(),
  //           onTap: () => Navigator.of(context).push(
  //             CupertinoPageRoute<void>(
  //               builder: (BuildContext context) {
  //                 return const _SecondPage(text: 'Room 1 Data');
  //               },
  //             ),
  //           ),
  //         ),
  //         CupertinoListTile(
  //           title: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               const Padding(
  //                 padding: const EdgeInsets.only(left: 20.0),
  //                 child: const Text('Room 2', style: TextStyle(fontSize: 20)),
  //               ),
  //               //const Text('Room 2'),
  //               Padding(
  //                 padding: const EdgeInsets.only(right: 20.0),
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(10.0),
  //                   child: Container(
  //                     width: 25.0,
  //                     height: 25.0,
  //                     color: CupertinoColors.systemRed,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           trailing: const CupertinoListTileChevron(),
  //           onTap: () => Navigator.of(context).push(
  //             CupertinoPageRoute<void>(
  //               builder: (BuildContext context) {
  //                 return const _SecondPage(text: 'Room 2 Data');
  //               },
  //             ),
  //           ),
  //         ),
  //         CupertinoListTile(
  //           title: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               const Padding(
  //                 padding: const EdgeInsets.only(left: 20.0),
  //                 child: const Text('Room 3', style: TextStyle(fontSize: 20)),
  //               ),
  //               //const Text('Room 3'),
  //               Padding(
  //                 padding: const EdgeInsets.only(right: 20.0),
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(10.0),
  //                   child: Container(
  //                     width: 25.0,
  //                     height: 25.0,
  //                     color: CupertinoColors.inactiveGray,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           trailing: const CupertinoListTileChevron(),
  //           onTap: () => Navigator.of(context).push(
  //             CupertinoPageRoute<void>(
  //               builder: (BuildContext context) {
  //                 return const _SecondPage(text: 'Last commit');
  //               },
  //             ),
  //           ),
  //         ),
  //       ],
  //     )),
  //   );
  // }
}

class _SecondPage extends StatelessWidget {
  const _SecondPage({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Text(text),
      ),
    );
  }
}
