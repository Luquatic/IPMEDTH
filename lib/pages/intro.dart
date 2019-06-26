/*
  this page is used to load the intro pages
*/

//libraries
import 'package:flutter/material.dart';

//pages
import './home.dart';

class IntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IntroPageState();
  }
}

class _IntroPageState extends State<IntroPage> {
  // build intro dialog
  Widget _buildIntroDialog() {
    return SimpleDialog(
      title: Text('Uitleg over Applaudio!'),
      children: <Widget>[
        SimpleDialogOption(
          child: Text(
              'Volg de korte handleiding door op volgende te klikken, hier vind je een uitleg over de applicatie.'
              '\n\nLiever niet, geen probleem de handleiding is altijd terug te vinden in het menu.'),
        ),
        SimpleDialogOption(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                child: Text('Sluiten'),
                onPressed: () {
                  // return to home if the user wants no tutorial
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
              RaisedButton(
                child: Text('Volgende'),
                onPressed: () {
                  // start tutorial
                  Navigator.pushReplacementNamed(context, '/tutorial');
                },
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applaudio!'),
      ),
      body: _buildIntroDialog(),
    );
  }
}
