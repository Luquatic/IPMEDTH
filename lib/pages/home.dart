import 'package:flutter/material.dart';

import '../RecordAudio.dart';
import '../constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageButtonState createState() => _HomePageButtonState();
}

class _HomePageButtonState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Applaudio!'),
          actions: <Widget>[
            PopupMenuButton<String>(itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            })
          ],
        ),
        body: RecordAudio());
  }

  void choiceAction(String choice) {
    if (choice == Constants.Settings) {
      print('Settings');
    }
  }
}
