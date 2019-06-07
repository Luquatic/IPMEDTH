
import 'package:Applaudio/pages/profielen.dart';
import 'package:flutter/material.dart';

import 'package:Applaudio/styles/theme.dart' as Theme; //package for the custom styles
import 'package:flutter/widgets.dart';
// import 'package:flutter/rendering.dart';

import './pages/intro.dart';
import './pages/home.dart';
import './pages/profielen.dart';
import './pages/addProfiel.dart';

void main() {
  // debugPaintSizeEnabled = true;
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
        '/home': (BuildContext context) => HomePage(),
        '/profielen': (BuildContext context) => Profielen(),
        '/addprofiel':(BuildContext context) => AddProfiel(), 
      },
    );
  }
}
