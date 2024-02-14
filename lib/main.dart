import 'package:flutter/cupertino.dart';
import 'package:openrooms/home.dart';
import 'package:openrooms/map.dart';
import 'package:openrooms/settings.dart';
import 'package:openrooms/themeProvider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:openrooms/get_firebase_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final themeProvider = ThemeProvider();
  await themeProvider.loadSavedTheme();

  runApp(
    ChangeNotifierProvider(
      create: (context) => themeProvider,
      child: const MyApp(), // Replace CupertinoApp with MyApp
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return CupertinoApp(
        debugShowCheckedModeBanner: false,
        title: 'Open Rooms',
        theme: themeProvider.getCupertinoTheme(), // Apply the theme
        home: CupertinoTabBarBottom(
          firebaseRoomService: FirebaseRoomService(
            firebaseDatabase: FirebaseDatabase.instance,
          ),
        ));
  }
}

//this is the code that will be used to display the bottom navigation bar
class CupertinoTabBarBottom extends StatelessWidget {
  final FirebaseRoomService firebaseRoomService;
  const CupertinoTabBarBottom({super.key, required this.firebaseRoomService});

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
              return HomePage(firebaseRoomService: firebaseRoomService);
            case 1:
              return MapPage(firebaseRoomService: firebaseRoomService);
            case 2:
              return const SettingsPage();
            default:
              return HomePage(firebaseRoomService: firebaseRoomService);
          }
        },
      );
}
