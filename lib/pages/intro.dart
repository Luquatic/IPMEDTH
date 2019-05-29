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
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
        ),
        SimpleDialogOption(
          child: Row(
            children: <Widget>[
              Checkbox(
                value: _donotRemind,
                onChanged: (bool value) {
                  setState(() {
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
                child: Text('Afsluiten'),
                onPressed: () {
                  _donotRemind = _reminder;
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
              RaisedButton(
                child: Text('Volgende'),
                onPressed: () {},
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _getContent(BuildContext context, _donotRemind) {
    if (_donotRemind == true) {
      return HomePage();
    } else {
      return _buildIntroDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applaudio!'),
      ),
      body: _getContent(context, _donotRemind),
    );
  }
}
