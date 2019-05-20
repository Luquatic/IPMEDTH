import 'package:flutter/material.dart';

import 'RecordAudio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Applaudio!'),
        ),
        body:RecordAudio()
      ),
    );
  }
}
