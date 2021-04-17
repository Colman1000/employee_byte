import 'package:flutter/material.dart';

class AppTheme {
  static const String robotoCondensed = 'Roboto Condensed';
  static const String roboto = 'Roboto';

  static const String fontFamily = robotoCondensed;

  static const Color bgColorD = Color.fromARGB(255, 50, 50, 50);

  static const Color bgColorL = Color.fromARGB(255, 250, 250, 250);

  static const transition = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );

  static const MaterialAccentColor primaryColorD = Colors.redAccent;
  static const MaterialColor primaryColorL = Colors.red;

  static final InputDecorationTheme _inputDecor = InputDecorationTheme(
    filled: true,
    fillColor: primaryColorL.withOpacity(0.01),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(
        color: primaryColorD,
        width: 2,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
  );

  static ThemeData light = ThemeData(
    primaryColor: primaryColorL,
    accentColor: primaryColorL.shade700,
    backgroundColor: bgColorL,
    scaffoldBackgroundColor: bgColorL,
    colorScheme: ColorScheme.light(
      background: bgColorL,
      primary: primaryColorL,
      secondary: primaryColorL.shade700,
    ),
    fontFamily: fontFamily,
    platform: TargetPlatform.iOS,
    pageTransitionsTheme: transition,
    inputDecorationTheme: _inputDecor,
  );

  static ThemeData dark = ThemeData(
    primaryColor: primaryColorD,
    accentColor: primaryColorD.shade700,
    backgroundColor: bgColorD,
    scaffoldBackgroundColor: bgColorD,
    colorScheme: ColorScheme.dark(
      background: bgColorD,
      primary: primaryColorD,
      secondary: primaryColorD.shade700,
    ),
    platform: TargetPlatform.iOS,
    fontFamily: fontFamily,
    pageTransitionsTheme: transition,
    inputDecorationTheme: _inputDecor,
  );

  static InputDecoration inputDecor(
    Widget icon,
    String label,
  ) {
    return InputDecoration(
      prefixIcon: icon,
      hintText: label,
    );
  }
}
