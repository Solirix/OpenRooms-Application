import 'package:flutter/cupertino.dart';
import 'package:openrooms/home.dart';
import 'package:openrooms/map.dart';
import 'package:openrooms/settings.dart';

//this is the code that will be used to display the bottom navigation bar
class CupertinoTabBarBottom extends StatelessWidget {
  const CupertinoTabBarBottom({super.key});

  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_fill),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.map_fill),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.gear_alt_fill),
          ),
        ]),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return const HomePage();
            case 1:
              return const MapPage();
            case 2:
              return const SettingsPage();
            default:
              return const HomePage();
          }
        },
      );
}