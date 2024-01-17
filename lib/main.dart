import 'package:flutter/cupertino.dart'; //iOS styling
import 'package:openrooms/home.dart'; //importing home page
import 'package:openrooms/map.dart'; //importing map page
import 'package:openrooms/settings.dart'; //importing settings page
import 'package:openrooms/disclaimer.dart'; //importing disclaimer page
import 'package:openrooms/themeProvider.dart';
import 'package:provider/provider.dart';

// Cupertino is iOS styling. Look up flutter cupertino there's a lot of docs.
/// Flutter code sample for [CupertinoTabBar].
///
const String initialRoute = '/disclaimer';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const OpenRooms(),
      ),
    );


// class OpenRooms extends StatelessWidget {
//   const OpenRooms({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const CupertinoApp(
//       //can change this to dark for dark mode it looks like
//       theme: CupertinoThemeData(brightness: Brightness.light),
//       home: DisclaimerPage(), //make this
//     );
//   }
// }

class OpenRooms extends StatelessWidget {
  const OpenRooms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      // theme: const CupertinoThemeData(brightness: Brightness.light),
      theme: Provider.of<ThemeProvider>(context).getCupertinoTheme(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return CupertinoPageRoute(
                builder: (_) => const CupertinoTabBarBottom());
          case '/disclaimer':
          default:
            return CupertinoPageRoute(builder: (_) => const DisclaimerPage());
        }
      },
    );
  }
}

class CupertinoTabBarBottom extends StatelessWidget {
  const CupertinoTabBarBottom({super.key});

  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_fill),
            //label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.map_fill),
            //label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.gear_alt_fill),
            //label: 'Settings',
          ),
        ]),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return const HomePage(title: 'Home');
            case 1:
              return const MapPage(title: 'Map');
            case 2:
              return const SettingsPage(title: 'Settings');
            default:
              return const HomePage(title: 'Home');
          }
        },
      );
}
