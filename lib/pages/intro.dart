import 'package:flutter/material.dart';
import './home.dart';

class IntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IntroPageState();
  }
}

class _IntroPageState extends State<IntroPage> {
  bool _reminder = false;
  bool _donotRemind = false;

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
            children: <Widget>[
              Checkbox(
                value: _reminder,
                onChanged: (bool value) {
                  setState(() {
                    print(_reminder);
                    _reminder = value;
                  });
                },
              ),
              Text('Herinner mij niet meer'),
            ],
          ),
        ),
        SimpleDialogOption(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                child: Text('Sluiten'),
                onPressed: () {
                  _donotRemind = _reminder;
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
              RaisedButton(
                child: Text('Volgende'),
                onPressed: () {
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
    print(_reminder);

    return _donotRemind == false
        ? Scaffold(
            appBar: AppBar(
              title: Text('Applaudio!'),
            ),
            body: _buildIntroDialog(),
          )
        : HomePage();
  }
}
