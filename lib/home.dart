import 'package:flutter/cupertino.dart';
import 'package:openrooms/hourly_occupancy.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({super.key, required this.title});

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
                      return const HourlyOccupancy();
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
                      return const HourlyOccupancy();
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
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
