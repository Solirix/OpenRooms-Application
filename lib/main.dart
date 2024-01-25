import 'package:flutter/cupertino.dart';
import 'package:openrooms/home.dart';
import 'package:openrooms/map.dart';
import 'package:openrooms/settings.dart';
import 'package:openrooms/disclaimer.dart';
import 'package:openrooms/themeProvider.dart';
import 'package:provider/provider.dart';

const String initialRoute = '/disclaimer';

void main() async {
  // Ensure that Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load the saved theme before runApp
  final themeProvider = ThemeProvider();
  await themeProvider.loadSavedTheme(); // Use the loadSavedTheme method to load the saved theme settings

  // Run the app, providing the ThemeProvider to the widget tree
  runApp(
    ChangeNotifierProvider(
      create: (context) => themeProvider,
      child: const OpenRooms(),
    ),
  );
}

class OpenRooms extends StatelessWidget {
  const OpenRooms({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
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