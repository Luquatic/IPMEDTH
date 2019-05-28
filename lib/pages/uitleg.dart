import 'package:flutter/material.dart';

class UitlegPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UitlegPageState();
  }
}

class _UitlegPageState extends State<UitlegPage> {
  bool _herinnering = false;

  _buildUitlegDialog() {
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
                value: _herinnering,
                onChanged: (bool value) {
                  setState(() {
                    _herinnering = value;
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
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
              RaisedButton(
                child: Text('Volgende'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/uitleg_profielen');
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
      body: _buildUitlegDialog(),
    );
  }
}
