import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';

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
    double _value = 0.0;
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Voeg een profiel toe'),
          content: Container(
              child: ListView(
              children: <Widget>[
              Text('Profiel naam:'),
              TextField(
                autofocus: true,
                decoration: new InputDecoration(
                    hintText: 'Naam van profiel ...'),
                onChanged: (value) {
                  profileName = value;
                },
              ),
              SizedBox(height: 15),
              Text('Volume:'),
              SizedBox(height: 15),
              FluidSlider(
                value: _value,
                onChanged: (double newValue) {
                  setState(() {
                    _value = newValue;
                  });
                },
                min: 0.0,
                max: 100.0,
              ),
            ],
            // mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            // children: <Widget>[

            // ],
          )),
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
                //TODO: Save data here
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
