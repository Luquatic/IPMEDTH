import 'package:flutter/material.dart';


final ThemeData ApplaudioThemeData = new ThemeData(
    brightness: Brightness.light,
    primarySwatch: MaterialColor(ApplaudioColors.lichtGroen[50].value, ApplaudioColors.lichtGroen),
    primaryColor: ApplaudioColors.lichtGroen[500],
    primaryColorBrightness: Brightness.light,
    accentColor: ApplaudioColors.donkerGroen[500],
    accentColorBrightness: Brightness.light
);

class ApplaudioColors {
  ApplaudioColors._(); // this basically makes it so you can instantiate this class

  static const Map<int, Color> lichtGroen = const <int, Color> {
    50: const Color(0xFFd9e382),
    100: const Color(0xFFd3de6e),
    200: const Color(0xFFccd959),
    300: const Color(0xFFc6d544),
    400: const Color(0xFFc0d02f),
    500: const Color(0xFFB4C42D), // 500 = normal color
    600: const Color(0xFF99a626),
    700: const Color(0xFF869121),
    800: const Color(0xFF737d1c),
    900: const Color(0xFF606818)
  };

  static const Map<int, Color> donkerGroen = const <int, Color> {
    50: const Color(0xFFbed049),
    100: const Color(0xFFb7cb34),
    200: const Color(0xFFa4b62f),
    300: const Color(0xFF92a22a),
    400: const Color(0xFF808e25),
    500: const Color(0xFF7D8B24), // 500 = normal color
    600: const Color(0xFF6e7a1f),
    700: const Color(0xFF5b651a),
    800: const Color(0xFF495115),
    900: const Color(0xFF373d10)
  };
}