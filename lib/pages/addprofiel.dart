import 'package:flutter/material.dart';

class AddProfiel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddProfiel();
  }
}

class _AddProfiel extends State<AddProfiel> {
  
  Widget _buildAddProfileDialog() {
    return SimpleDialog(
      title: Text('Voeg een profiel toe'),
      children: <Widget>[
        SimpleDialogOption(
          child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
        ),
        SimpleDialogOption(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                child: Text('Opslaan'),
                onPressed: () {
                  //TODO: Save the actual profile
                  Navigator.pushReplacementNamed(context, '/profielen');
                },
              ),
              RaisedButton(
                child: Text('Afsluiten'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/profielen');
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
        title: Text(''),
      ),
      body: _buildAddProfileDialog(),
    );
  }
}
