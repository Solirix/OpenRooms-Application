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

/// Main entry point for the Open Rooms app:
///   This file sets up Firebase, theme management with `ThemeProvider`, and provides the main app structure
///   with bottom navigation to switch between the Home, Map, and Settings pages. The FirebaseRoomService is 
///   initialized here and passed down to the necessary components for grabbing and displaying room data.
///
/// Key Components:
/// - `Firebase.initializeApp`: Initializes Firebase with platform-specific options.
/// - `ThemeProvider`: Manages and applies the app's theme based on user preferences.
/// - `MyApp`: The root widget of the application, setting up the theme and main navigation structure.
/// - `CupertinoTabBarBottom`: Handles bottom navigation, dynamically displaying the selected page.
///
/// Pages:
/// - `HomePage`: Displays room availability and other relevant information.
/// - `MapPage`: Shows a map view for room locations.
/// - `SettingsPage`: Allows users to modify app settings and preferences.

void main() async {
  // Ensures that widget binding is initialized before running the app.
  // This is necessary for plugins to work correctly in the async main function.
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes Firebase with default options for the current platform.
  // This setup is required to use Firebase services in the app.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Creates an instance of ThemeProvider to manage theme data across the app.
  // This includes loading the saved theme preference at the start of the app.
  final themeProvider = ThemeProvider();
  await themeProvider.loadSavedTheme();

  // Runs the app and wraps it with a ChangeNotifierProvider to manage theme changes.
  // The ThemeProvider instance is passed to MyApp to apply the selected theme globally.
  runApp(
    ChangeNotifierProvider(
      create: (context) => themeProvider,
      child: const MyApp(), // MyApp is the root widget of the application.
    ),
  );
}

/// Defines the root widget of the application, `MyApp`, which is a StatelessWidget.
/// This class is responsible for creating the main structure of the app using CupertinoApp.
class MyApp extends StatelessWidget {
  // Constructor with an optional key parameter.
  const MyApp({super.key});

  /// Builds the CupertinoApp widget that sets the overall theme, title, and home widget of the app.
  @override
  Widget build(BuildContext context) {
    // Retrieves the current theme data using ThemeProvider from the context.
    // This allows for dynamic theme switching throughout the app.
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Returns a CupertinoApp widget, setting up the overall app environment.
    // This includes the app's theme, title, and the navigation structure.
    return CupertinoApp(
        debugShowCheckedModeBanner: false, // Hides the debug banner for a cleaner UI.
        title: 'Open Rooms', // Sets the title of the app shown in the task switcher.
        theme: themeProvider.getCupertinoTheme(), // Applies the current theme from ThemeProvider.
        home: CupertinoTabBarBottom(
          // The main content of the app is a bottom navigation bar, defined in CupertinoTabBarBottom.
          // It passes a FirebaseRoomService instance to be used by child widgets.
          firebaseRoomService: FirebaseRoomService(
            firebaseDatabase: FirebaseDatabase.instance, // Initializes FirebaseRoomService with the default Firebase instance.
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
