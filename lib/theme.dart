import 'package:flutter/cupertino.dart';

const CupertinoThemeData lightTheme = CupertinoThemeData(
  brightness: Brightness.light,
  primaryColor: CupertinoColors.systemBlue,
  primaryContrastingColor: CupertinoColors.white,
  barBackgroundColor: CupertinoColors.systemBackground,
  textTheme: CupertinoTextThemeData(
    textStyle: TextStyle(
      fontFamily: '.SF Pro Text', //IOS font
       fontSize: 16.0,
    )
  )
);

const CupertinoThemeData darkTheme = CupertinoThemeData(
  brightness: Brightness.dark,
  primaryColor: CupertinoColors.black,
  primaryContrastingColor: CupertinoColors.white,
  barBackgroundColor: CupertinoColors.black,
  textTheme: CupertinoTextThemeData(
    textStyle: TextStyle(
      fontFamily: '.SF Pro Text', //IOS Font
      fontSize: 16.0,
    )
  )

);

