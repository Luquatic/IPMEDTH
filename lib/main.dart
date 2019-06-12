import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:Applaudio/themes/applaudio.dart' as Theme; //package for the custom styles
import 'package:flutter/widgets.dart';
// import 'package:flutter/rendering.dart';

import './pages/intro.dart';
import './pages/tutorial.dart';
import './pages/home.dart';
import './pages/profiles.dart';

void main() {
  // debugPaintSizeEnabled = true;
  
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      // statusBarColor: Colors.white, //top bar color
      // statusBarIconBrightness: Brightness.dark, //top bar icons
      systemNavigationBarColor: Colors.black, //bottom bar color
      systemNavigationBarIconBrightness: Brightness.light, //bottom bar icons
    )
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
      color: Theme.ApplaudioColors.lichtGroen[500],
      theme: Theme.ApplaudioThemeData,
      // home: HomePage(),
      routes: {
        '/': (BuildContext context) => IntroPage(),
        '/intro': (BuildContext context) => IntroPage(),
        '/tutorial': (BuildContext context) => TutorialPage(),
        '/home': (BuildContext context) => HomePage(),
        '/profiles': (BuildContext context) => Profiles(),
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => HomePage());
      },
    );
  }
}
