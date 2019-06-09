import 'package:flutter/material.dart';

class Profiles extends StatefulWidget {
  @override
  _Profiles createState() => new _Profiles();
}

class _Profiles extends State<Profiles> {
  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Menu'),
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Profielen'),
            onTap: () {
              Navigator.pushNamed(context, '/profiles');
            },
          ),
        ],
      ),
    );
  }

  Future<String> _addProfileDialog(BuildContext context) async {
    String profileName = '';
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Voeg een profiel toe'),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Profiel naam:',
                    hintText: 'Vul hier de naam van het profiel in ...'),
                onChanged: (value) {
                  profileName = value;
                },
              ))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Afsluiten'),
              onPressed: () {
                Navigator.of(context).pop(profileName);
              },
            ),
            FlatButton(
              child: Text('Opslaan'),
              onPressed: () {
                Navigator.of(context).pop(profileName);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text(''),
        ),
        body: ListView(children: <Widget>[
          //TODO: Show empty message if there are no profiles
        ]),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: new Color(0xFFB4C42D),
          onPressed: () async {
            await _addProfileDialog(context);
          },
        ));
  }
}
