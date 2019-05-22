import 'package:flutter/material.dart';

import './pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      // home: HomePage(),
      routes: {
        '/': (BuildContext context) => HomePage(),
      },
    );
  }
}
