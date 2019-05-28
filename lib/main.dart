import 'package:first_app/pages/uitleg.dart';
import 'package:first_app/pages/uitleg_profielen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import './pages/home.dart';
import './pages/uitleg.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        ),
      // home: HomePage(),
      routes: {
        '/': (BuildContext context) => UitlegPage(),
        '/uitleg_profielen': (BuildContext context) => UitlegProfielenPage(),
        '/home': (BuildContext context) => HomePage(),
      },
    );
  }
}
